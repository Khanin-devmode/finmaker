import 'package:equatable/equatable.dart';
import 'package:finmaker/features/specs/data/spec_model.dart';

abstract class SpecState extends Equatable {
  const SpecState();

  @override
  List<Object> get props => [];
}

class SpecInitial extends SpecState {}

class SpecLoading extends SpecState {}

class SpecLoaded extends SpecState {
  final List<Spec> specs;

  const SpecLoaded(this.specs);

  @override
  List<Object> get props => [specs];
}

class SpecError extends SpecState {
  final String message;

  const SpecError(this.message);

  @override
  List<Object> get props => [message];
}
