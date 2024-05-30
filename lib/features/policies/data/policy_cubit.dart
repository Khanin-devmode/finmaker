import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'dart:async';
import 'package:finmaker/features/policies/data/policy_state.dart';

class PolicyCubit extends Cubit<PolicyState> {
  final FirebaseFirestore _firestore;
  StreamSubscription? _subscription;

  PolicyCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(PolicyInitial());

  void listenToPolicies(String clientId) {
    print('listening to clients...');
    emit(PolicyLoading());
    _subscription?.cancel();
    _subscription = _firestore
        .collection('clients')
        .where('createdBy', isEqualTo: clientId)
        .snapshots()
        .listen((snapshot) {
      final policies = snapshot.docs
          .map((doc) => Policy.fromDocData(uid: doc.id, policyData: doc.data()))
          .toList();
      emit(PolicyLoaded(policies));
    }, onError: (error) {
      emit(PolicyError(error.toString()));
    });
  }

  Future<void> addClient(String userId, Client client) async {
    final clientData = client.toCollectionObj();

    try {
      clientData['createdBy'] = userId;
      await _firestore.collection('clients').add(clientData);
    } catch (e) {
      emit(PolicyError(e.toString()));
    }
  }

  void deleteClient(String clientId) async {
    try {
      await _firestore.collection('clients').doc(clientId).delete();
    } catch (e) {
      emit(PolicyError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
