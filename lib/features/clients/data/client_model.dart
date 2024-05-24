class Client {
  Client(
      this.firstName, this.lastName, this.nickName, this.dateOfBirth, this.age,
      [this.id, this.creatdBy]);
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
}

enum MartialStatus { single, married, divorce }
