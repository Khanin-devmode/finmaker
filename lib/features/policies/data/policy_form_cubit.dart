import 'package:bloc/bloc.dart';
import 'package:finmaker/features/policies/data/policy_model.dart';

class PolicyFormCubit extends Cubit<NewPolicyForms> {
  PolicyFormCubit() : super(NewPolicyForms.temp());

  void resetForm() {
    emit(NewPolicyForms());
  }
}
