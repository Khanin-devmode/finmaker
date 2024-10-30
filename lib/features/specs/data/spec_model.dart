import 'package:equatable/equatable.dart';
import 'package:finmaker/features/common/utils/constants.dart';

abstract class Spec extends Equatable {
  const Spec({
    this.uid,
    required this.specCalType,
    required this.specGroupCode,
    required this.isExpense,
    this.description,
  });

  final String? uid;
  final String specCalType;
  final String specGroupCode;
  final bool isExpense;
  final String? description;

  @override
  List<Object?> get props => [uid, specCalType, specGroupCode, isExpense];

  Map<String, dynamic> toMap() {
    return {
      'specCalType': specCalType,
      'specGroupCode': specGroupCode,
      'isExpense': isExpense,
      'description': description,
    };
  }

  factory Spec.fromDocData({
    required String uid,
    required String specCalType,
    required Map<String, dynamic> specData,
  }) {
    switch (specCalType) {
      case 'aa':
        return OneTimeSpec.fromDocData(uid: uid, specData: specData);
      case 'ab':
        return PeriodSpec.fromDocData(uid: uid, specData: specData);
      case 'ac':
        return CustomSpec.fromDocData(uid: uid, specData: specData);
      default:
        throw UnimplementedError('Spec type not recognized: $specCalType');
    }
  }
}

const Map<String, Type> kSpecCalTypes = {
  'aa': OneTimeSpec,
  'ab': PeriodSpec,
  'ac': CustomSpec,
};

class OneTimeSpec extends Spec {
  const OneTimeSpec({
    super.uid,
    super.description,
    required super.specGroupCode,
    required super.isExpense,
    required this.contractMonths,
    required this.amount,
  }) : super(specCalType: 'aa');

  final int contractMonths;
  final double amount;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      kContractMonths: contractMonths,
      kAmount: amount,
    };
  }

  factory OneTimeSpec.fromDocData({
    required String uid,
    required Map<String, dynamic> specData,
  }) {
    return OneTimeSpec(
      uid: uid,
      specGroupCode: specData[kSpecGroupCode],
      contractMonths: specData[kContractMonths],
      amount: specData[kAmount],
      isExpense: specData['isExpense'],
    );
  }
}

class PeriodSpec extends Spec {
  const PeriodSpec({
    super.uid,
    required super.specGroupCode,
    required super.isExpense,
  }) : super(specCalType: 'ab');

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory PeriodSpec.fromDocData({
    required String uid,
    required Map<String, dynamic> specData,
  }) {
    return PeriodSpec(
      uid: uid,
      specGroupCode: specData[kSpecGroupCode],
      isExpense: specData['isExpense'],
    );
  }
}

class CustomSpec extends Spec {
  const CustomSpec({
    super.uid,
    required super.specGroupCode,
    required super.isExpense,
  }) : super(specCalType: 'ac');

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
    };
  }

  factory CustomSpec.fromDocData({
    required String uid,
    required Map<String, dynamic> specData,
  }) {
    return CustomSpec(
      uid: uid,
      specGroupCode: specData[kSpecGroupCode],
      isExpense: specData['isExpense'],
    );
  }
}
