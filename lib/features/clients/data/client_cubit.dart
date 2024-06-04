import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    print('listening to clients...');
    emit(ClientLoading());
    _subscription?.cancel();
    _subscription = _firestore
        .collection('clients')
        .where('createdBy', isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
      final clients = snapshot.docs.map((doc) {
        print(doc.data());

        return Client.fromDocData(uid: doc.id, clientData: doc.data());
      }).toList();
      emit(ClientLoaded(clients));
    }, onError: (error) {
      emit(ClientError(error.toString()));
    });
  }

  Future<void> addClient(String userId, Client client) async {
    final clientData = client.toMap();

    try {
      clientData['createdBy'] = userId;
      await _firestore.collection('clients').add(clientData);
    } catch (e) {
      emit(ClientError(e.toString()));
    }
  }

  void deleteClient(String clientId) async {
    try {
      await _firestore.collection('clients').doc(clientId).delete();
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
