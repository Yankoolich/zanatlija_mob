import 'package:zanatlija_app/data/models/craft.dart';

class User {
  final String nameSurname;
  final int birthDateInMillis;
  final String location;
  final String email;
  final String phoneNumber;
  final String password;
  final List<Craft>? myJobs;
  final List<Craft>? savedCrafts;

  const User({
    required this.nameSurname,
    required this.birthDateInMillis,
    required this.email,
    required this.location,
    required this.password,
    required this.phoneNumber,
    this.myJobs = const [],
    this.savedCrafts = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nameSurname: json['nameSurname'],
        birthDateInMillis: json['birthDateInMillis'],
        email: json['email'],
        location: json['location'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        myJobs: json['myJobs'] != null
            ? (json['myJobs'] as List<dynamic>?)
                ?.map((e) => Craft.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
        savedCrafts: json['savedCrafts'] != null
            ? (json['savedCrafts'] as List<dynamic>?)
                ?.map((e) => Craft.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'nameSurname': nameSurname,
        'birthDateInMillis': birthDateInMillis,
        'email': email,
        'location': location,
        'password': password,
        'phoneNumber': phoneNumber,
        'myJobs': myJobs?.map((e) => e.toJson()).toList() ?? [],
        'savedCrafts': savedCrafts?.map((e) => e.toJson()).toList() ?? [],
      };

  User copyWith({
    List<Craft>? myJobs = const [],
    List<Craft>? savedCrafts = const [],
  }) =>
      User(
        nameSurname: nameSurname,
        birthDateInMillis: birthDateInMillis,
        email: email,
        location: location,
        password: password,
        phoneNumber: phoneNumber,
        myJobs: myJobs ?? this.myJobs,
        savedCrafts: savedCrafts ?? this.savedCrafts,
      );
}
