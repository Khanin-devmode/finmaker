import 'package:equatable/equatable.dart';

abstract class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<Map<String, dynamic>> clients;

  ClientLoaded(this.clients);

  @override
  List<Object> get props => [clients];
}

class ClientError extends ClientState {
  final String message;

  ClientError(this.message);

  @override
  List<Object> get props => [message];
}
