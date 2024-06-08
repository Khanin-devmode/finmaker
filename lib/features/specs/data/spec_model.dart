import 'package:equatable/equatable.dart';
import 'package:finmaker/features/common/utils/constants.dart';

abstract class Spec extends Equatable {
  const Spec(
      {this.uid, required this.specCalType, required this.specGroupCode});

  final String? uid;
  final String specCalType;
  final String specGroupCode;

  @override
  List<Object?> get props => [uid, specCalType];

  Map<String, dynamic> toMap();

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

class OneTimeSpec extends Spec {
  const OneTimeSpec({
    super.uid,
    required super.specGroupCode,
    required this.contractMonths,
    required this.amount,
  }) : super(specCalType: 'aa');

  final int contractMonths;
  final double amount;

  @override
  Map<String, dynamic> toMap() {
    return {
      kSpecCalType: specCalType,
      kContractMonths: contractMonths,
      kAmount: amount,
    };
  }

  factory OneTimeSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    return OneTimeSpec(
      uid: uid,
      specGroupCode: specData[kSpecGroupCode],
      contractMonths: specData[kContractMonths],
      amount: specData[kAmount],
    );
  }
}

class PeriodSpec extends Spec {
  const PeriodSpec({
    super.uid,
    required super.specGroupCode,
  }) : super(specCalType: 'ab');

  @override
  Map<String, dynamic> toMap() {
    return {
      kSpecCalType: specCalType,
    };
  }

  factory PeriodSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    return PeriodSpec(
      uid: uid,
      specGroupCode: specData['specGroupCode'],
    );
  }
}

class CustomSpec extends Spec {
  const CustomSpec({
    super.uid,
    required super.specGroupCode,
  }) : super(specCalType: 'ac');

  @override
  Map<String, dynamic> toMap() {
    return {
      'specCalType': specCalType,
    };
  }

  factory CustomSpec.fromDocData(
      {required String uid, required Map<String, dynamic> specData}) {
    return CustomSpec(uid: uid, specGroupCode: specData['specGroupCode']);
  }
}
