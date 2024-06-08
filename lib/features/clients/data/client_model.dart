import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finmaker/features/common/utils/utils.dart';

class Client {
  Client({
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.dateOfBirth,
    required this.specGroupsConfig,
    this.uid,
    this.creatdBy,
  });
  String firstName;
  String lastName;
  String nickName;
  DateTime dateOfBirth;
  String? uid;
  String? creatdBy;

  Map<String, dynamic> specGroupsConfig;

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'dateOfBirth': dateOfBirth,
      'specGroupsConfig': specGroupsConfig
    };
  }

  int get age => DateTime.now().year - dateOfBirth.year;

  // Client copyWith({String? id, String? description, bool? completed}) {
  //   return Client(
  //     id: id ?? this.id,
  //     description: description ?? this.description,
  //     completed: completed ?? this.completed,
  //   );
  // }

  factory Client.fromDocData(
      {required String uid, required Map<String, dynamic> clientData}) {
    Timestamp timestamp = clientData['dateOfBirth'];

    Client client = Client(
        firstName: clientData['firstName'],
        lastName: clientData['lastName'],
        nickName: clientData['nickName'],
        dateOfBirth: timestampToDateTime(timestamp),
        uid: uid,
        creatdBy: clientData['createdBy'],
        specGroupsConfig:
            clientData['specGroupsConfig'] as Map<String, dynamic>);

    return client;
  }
}

enum MartialStatus { single, married, divorce }
