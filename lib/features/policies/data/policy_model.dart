import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmaker/features/specs/data/spec_model.dart';
import 'package:flutter/material.dart';

class Policy {
  Policy({
    required this.policyNumber,
    required this.policyName,
    required this.policyCompany,
    required this.startDate,
    required this.endDate,
    required this.policyCoverage,
    required this.policyCost,
    this.id,
    required this.clientId,
    this.specs = const [],
    this.specGroupKeys = const [],
  });

  final String policyNumber;
  final String policyName;
  final String policyCompany;
  final DateTime startDate;
  final DateTime endDate;
  final double policyCoverage;
  final double policyCost;
  final String? id;
  final String clientId;
  final List<Spec> specs;
  final List<String> specGroupKeys;

  Policy copyWith({
    String? policyNumber,
    String? policyName,
    String? policyCompany,
    DateTime? startDate,
    DateTime? endDate,
    double? policyCoverage,
    double? policyCost,
    String? id,
    String? clientId,
    List<Spec>? specs,
    List<String>? specGroupKeys,
  }) {
    return Policy(
      policyNumber: policyNumber ?? this.policyNumber,
      policyName: policyName ?? this.policyName,
      policyCompany: policyCompany ?? this.policyCompany,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      policyCoverage: policyCoverage ?? this.policyCoverage,
      policyCost: policyCost ?? this.policyCost,
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      specs: specs ?? this.specs,
      specGroupKeys: specGroupKeys ?? this.specGroupKeys,
    );
  }

  Map<String, dynamic> toMap() {
    print('mapping policy');
    print(specGroupKeys);
    return {
      'policyNumber': policyNumber,
      'policyName': policyName,
      'policyCompany': policyCompany,
      'startDate': startDate,
      'endDate': endDate,
      'policyCoverage': policyCoverage,
      'policyCost': policyCost,
      'clienId': clientId,
      'specGroupKeys': specGroupKeys,
    };
  }

  factory Policy.fromDocData(
      {required String uid, required Map<String, dynamic> policyData}) {
    Timestamp startTimestamp = policyData['startDate'];
    DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(startTimestamp.seconds * 1000);

    Timestamp endTimestamp = policyData['startDate'];
    DateTime endDate =
        DateTime.fromMillisecondsSinceEpoch(endTimestamp.seconds * 1000);

    Policy policy = Policy(
        id: uid,
        policyName: policyData['policyName'],
        policyNumber: policyData['policyNumber'],
        policyCompany: policyData['policyCompany'],
        policyCoverage: policyData['policyCoverage'],
        policyCost: policyData['policyCost'],
        clientId: policyData['clienId'],
        startDate: startDate,
        endDate: endDate,
        specGroupKeys: List<String>.from(policyData['specGroupKeys']));

    return policy;
  }
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

  Policy toPolicyObj({required String clienId}) {
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
        clientId: clienId);
  }
}
