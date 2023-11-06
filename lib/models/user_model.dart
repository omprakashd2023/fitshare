import 'dart:convert';

import 'package:intl/intl.dart';

class UserModel {
  final String uid;
  final bool isCompletedProfile;
  final String? name;
  final String email;
  final String? gender;
  final String? dateOfBirth;
  final String? height;
  final String? weight;
  final int? goalIndex;
  UserModel({
    required this.uid,
    this.isCompletedProfile = false,
    this.name,
    required this.email,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.goalIndex,
  });

  UserModel copyWith({
    String? uid,
    bool? isCompletedProfile,
    String? name,
    String? email,
    String? gender,
    String? dateOfBirth,
    String? height,
    String? weight,
    int? goalIndex,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      isCompletedProfile: isCompletedProfile ?? this.isCompletedProfile,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goalIndex: goalIndex ?? this.goalIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'isCompletedProfile': isCompletedProfile,
      'name': name,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'height': height,
      'weight': weight,
      'goalIndex': goalIndex,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      isCompletedProfile: map['isCompletedProfile'] as bool,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
      goalIndex: map['goalIndex'] != null ? map['goalIndex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  String calculateAge() {
    final DateTime birthDate = dateOfBirth == null
        ? DateTime.now()
        : DateFormat('yyyy-MM-dd').parse(dateOfBirth!);
    final DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age.toString();
  }
}
