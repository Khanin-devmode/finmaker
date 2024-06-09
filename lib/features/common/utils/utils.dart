import 'package:cloud_firestore/cloud_firestore.dart';

DateTime timestampToDateTime(Timestamp timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
}

double convertToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else if (value is String) {
    return double.tryParse(value) ?? 0.0;
  } else {
    throw const FormatException("Cannot convert value to double");
  }
}
