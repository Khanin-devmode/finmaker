import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivePolicyCubit extends Cubit<Policy?> {
  final FirebaseFirestore _firestore;

  ActivePolicyCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(null);

  void selectPolicy(Policy policy) {
    emit(policy);
  }

  updatePolicy(List<String> specGroupsKey) async {
    print('updating policy');
    final newPolicy = state!.copyWith(specGroupKeys: specGroupsKey);
    final map = newPolicy.toMap();

    try {
      await _firestore
          .collection('clients')
          .doc(state?.clientId)
          .collection('policies')
          .doc(state!.id)
          .update(map);

      emit(newPolicy);
    } catch (e) {
      print(e);
    }
  }
}
