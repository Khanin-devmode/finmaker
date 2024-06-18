import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:finmaker/features/specs/data/spec_model.dart';
import 'package:finmaker/features/specs/data/spec_state.dart';

class SpecCubit extends Cubit<SpecState> {
  final FirebaseFirestore _firestore;
  StreamSubscription? _subscription;
  String? _currentPolicyId;

  SpecCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(SpecInitial());

  void listenToSpecs(String clientId, String policyId) {
    if (_currentPolicyId == policyId) {
      return; // Policy ID has not changed, no need to re-subscribe
    }

    _currentPolicyId = policyId;
    print('listening to policy specs...');

    emit(SpecLoading());
    _subscription?.cancel();
    _subscription = _firestore
        .collection('clients')
        .doc(clientId)
        .collection('policies')
        .doc(policyId)
        .collection('specs')
        .snapshots()
        .listen((snapshot) {
      final specs = snapshot.docs.map((doc) {
        return OneTimeSpec.fromDocData(uid: doc.id, specData: doc.data());
      }).toList();
      emit(SpecLoaded(specs));
    }, onError: (error) {
      emit(SpecError(error.toString()));
    });
  }

  Future<void> addSpec(String clientId, String policyId, Spec spec) async {
    late Map<String, dynamic> specData;

    print('adding spec');

    if (spec is OneTimeSpec) {
      specData = spec.toMap();
    }

    try {
      await _firestore
          .collection('clients')
          .doc(clientId)
          .collection('policies')
          .doc(policyId)
          .collection('specs')
          .add(specData);
    } catch (e) {
      emit(SpecError(e.toString()));
    }

    print('spec added');
  }

  // void deletePolicySpec(String clientId) async {
  //   try {
  //     await _firestore.collection('clients').doc(clientId).delete();
  //   } catch (e) {
  //     emit(SpecError(e.toString()));
  //   }
  // }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
