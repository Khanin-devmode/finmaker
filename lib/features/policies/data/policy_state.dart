import 'package:equatable/equatable.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';

abstract class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object> get props => [];
}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  final List<Policy> policies;

  const PolicyLoaded(this.policies);

  @override
  List<Object> get props => [policies];
}

class PolicyError extends PolicyState {
  final String message;

  const PolicyError(this.message);

  @override
  List<Object> get props => [message];
}
