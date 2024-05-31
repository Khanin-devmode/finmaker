import 'package:equatable/equatable.dart';

abstract class Spec extends Equatable {
  @override
  List<Object> get props => [];
}

class BenefitsSpec extends Spec {
  BenefitsSpec();

  Map<String, dynamic> toMap() {
    return {};
  }

  factory BenefitsSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    BenefitsSpec spec = BenefitsSpec();

    return spec;
  }
}

class CashExpense extends Spec {
  CashExpense();

  Map<String, dynamic> toMap() {
    return {};
  }

  factory CashExpense.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    CashExpense spec = CashExpense();

    return spec;
  }
}
