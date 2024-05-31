import 'package:equatable/equatable.dart';

abstract class Spec extends Equatable {
  @override
  List<Object> get props => [];
}

class RegularSpec extends Spec {
  RegularSpec();

  Map<String, dynamic> toMap() {
    return {};
  }

  factory RegularSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    RegularSpec spec = RegularSpec();

    return spec;
  }
}

class CustomSpec extends Spec {
  CustomSpec();

  Map<String, dynamic> toMap() {
    return {};
  }

  factory CustomSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    CustomSpec spec = CustomSpec();

    return spec;
  }
}

const specCode = {
  'aa': RegularSpec,
  'ab': CustomSpec,
};

const specGroup = {
  //e.g. Cash Income, Expense, CI coverage, default
  '101': 'Yearly Income',
  '001': 'Yearly Expense'
};
