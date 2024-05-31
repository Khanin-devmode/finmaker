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
  'a001': RegularSpec,
  'a002': CustomSpec,
};

const specGroup = {
  //e.g. Cash Income, Expense, CI coverage, default
  0: 'Yearly Income',
  1: 'Yearly Expense'
};
