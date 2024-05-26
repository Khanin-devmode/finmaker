import 'package:equatable/equatable.dart';
import 'package:finmaker/features/clients/data/client_model.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<Client> clients;

  const ClientLoaded(this.clients);

  @override
  List<Object> get props => [clients];
}

class ClientError extends ClientState {
  final String message;

  const ClientError(this.message);

  @override
  List<Object> get props => [message];
}
