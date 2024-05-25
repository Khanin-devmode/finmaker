import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  Client(
      {required this.firstName,
      required this.lastName,
      required this.nickName,
      required this.dateOfBirth,
      required this.age,
      this.id,
      this.creatdBy});
  String firstName;
  String lastName;
  String nickName;
  DateTime dateOfBirth;
  int age;
  String? id;
  String? creatdBy;

  Map<String, dynamic> toCollectionObj() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'dateOfBirth': dateOfBirth,
      'age': age,
    };
  }

  int get calcAge => DateTime.now().year - dateOfBirth.year;

  // Client copyWith({String? id, String? description, bool? completed}) {
  //   return Client(
  //     id: id ?? this.id,
  //     description: description ?? this.description,
  //     completed: completed ?? this.completed,
  //   );
  // }

  factory Client.fromDocData(Map<String, dynamic> clientData) {
    Timestamp timestamp = clientData['dateOfBirth'];
    DateTime dateOfBirth =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);

    Client client = Client(
      firstName: clientData['firstName'],
      lastName: clientData['lastName'],
      nickName: clientData['nickName'],
      dateOfBirth: dateOfBirth,
      age: clientData['age'],
      id: clientData['id'],
      creatdBy: clientData['createdBy'],
    );

    return client;
  }
}

enum MartialStatus { single, married, divorce }