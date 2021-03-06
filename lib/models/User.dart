import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  List<String> petIds;

  DocumentReference reference;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.petIds});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> convertPetIds = new List<String>();
    List petIds = json['petIds'] as List;
    if (petIds != null) {
      petIds.forEach((petId) {
        convertPetIds.add(petId.toString());
      });
    }

    return User(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      petIds: convertPetIds,
    );
  }

  Map<String, dynamic> toJson() => _UserToJson(this);

  Map<String, dynamic> _UserToJson(User instance) => <String, dynamic>{
        'uid': instance.uid,
        'firstName': instance.firstName,
        'lastName': instance.lastName,
        'phoneNumber': instance.phoneNumber,
        'email': instance.email,
        'petIds': instance.petIds,
  };
}
