import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finmaker/features/clients/data/client_model.dart';
import 'dart:async';

import 'package:finmaker/features/clients/data/client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final FirebaseFirestore _firestore;
  StreamSubscription? _subscription;

  ClientCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(ClientInitial());

  void listenToClients(String userId) {
    emit(ClientLoading());
    _subscription?.cancel();
    _subscription = _firestore
        .collection('clients')
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      final clients =
          snapshot.docs.map((doc) => Client.fromDocData(doc.data())).toList();
      emit(ClientLoaded(clients));
    }, onError: (error) {
      emit(ClientError(error.toString()));
    });
  }

  void addClient(String userId, Client client) async {
    final clientData = client.toCollectionObj();

    try {
      clientData['createdBy'] = userId;
      await _firestore.collection('clients').add(clientData);
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
