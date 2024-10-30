import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveClientCubit extends Cubit<Client?> {
  final FirebaseFirestore _firestore;

  ActiveClientCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(null);

  void selectClient(Client client) {
    emit(client);
  }

  updatePolicy(List<Map<String, dynamic>>? specGroups) async {
    //state.copyWith

    _firestore.collection('clients').doc(state?.uid)

        // .update(data)
        ;

    // emit();
  }
}
