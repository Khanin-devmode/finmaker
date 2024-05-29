import 'package:flutter/material.dart';

class Policy {
  // Policy(this.policyNumber, this.policyName, this.policyCompany, this.startDate,
  //     this.endDate, this.policyCoverage, this.policyCost,
  //     [this.id, this.clientId]);
  Policy({
    required this.policyNumber,
    required this.policyName,
    required this.policyCompany,
    required this.startDate,
    required this.endDate,
    required this.policyCoverage,
    required this.policyCost,
    this.id,
    this.clientId,
  });

  final String policyNumber;
  final String policyName;
  final String policyCompany;
  final DateTime startDate;
  final DateTime endDate;
  final double policyCoverage;
  final double policyCost;
  final String? id;
  final String? clientId;
  final List<Map<int, int>> protections = [];
  final List<CashBenefits> cashIncomes = [];

  Map<String, dynamic> toCollectionObj() {
    return {
      'policyNumber': policyNumber,
      'policyName': policyName,
      'policyCompany': policyCompany,
      'startDate': startDate,
      'endDate': endDate,
      'policyCoverage': policyCoverage,
      'policyCost': policyCost,
    };
  }
}

class Protection {
  Protection(this.name, this.protectionsYears, this.protectionAmount);

  String name;
  List<int> protectionsYears;
  double protectionAmount;
}

class CashBenefits {
  CashBenefits(this.name, this.cashDueMonths, this.cashAmount);

  String name;
  List<int> cashDueMonths;
  double cashAmount;
}

class NewPolicyForms {
  NewPolicyForms()
      : number = TextEditingController(),
        name = TextEditingController(),
        company = TextEditingController(),
        startDay = TextEditingController(),
        startMonth = TextEditingController(),
        startYear = TextEditingController(),
        endDay = TextEditingController(),
        endMonth = TextEditingController(),
        endYear = TextEditingController(),
        coverage = TextEditingController(),
        cost = TextEditingController();

  NewPolicyForms.temp()
      : number = TextEditingController(text: 'T12345678'),
        name = TextEditingController(text: '90/5 ...'),
        company = TextEditingController(text: 'AIA'),
        startDay = TextEditingController(text: '01'),
        startMonth = TextEditingController(text: '01'),
        startYear = TextEditingController(text: '2511'),
        endDay = TextEditingController(text: '01'),
        endMonth = TextEditingController(text: '01'),
        endYear = TextEditingController(text: '2601'),
        coverage = TextEditingController(text: '11000000'),
        cost = TextEditingController(text: '11000');

  TextEditingController number;
  TextEditingController name;
  TextEditingController company;
  TextEditingController startDay;
  TextEditingController startMonth;
  TextEditingController startYear;
  TextEditingController endDay;
  TextEditingController endMonth;
  TextEditingController endYear;
  TextEditingController coverage;
  TextEditingController cost;

  Policy toPolicyObj() {
    return Policy(
      policyNumber: number.text,
      policyName: name.text,
      policyCompany: company.text,
      startDate: DateTime.utc(int.parse(startYear.text) - 543,
          int.parse(startMonth.text), int.parse(startDay.text)),
      endDate: DateTime.utc(int.parse(endYear.text) - 543,
          int.parse(endMonth.text), int.parse(endDay.text)),
      policyCoverage: double.parse(coverage.text),
      policyCost: double.parse(cost.text),
    );
  }
}
