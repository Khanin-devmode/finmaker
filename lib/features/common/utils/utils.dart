import 'package:cloud_firestore/cloud_firestore.dart';

DateTime timestampToDateTime(Timestamp timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
}
