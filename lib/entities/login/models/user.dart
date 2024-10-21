class User {
  final String nameSurname;
  final int birthDateInMillis;
  final String location;
  final String email;
  final String phoneNumber;
  final String password;

  const User({
    required this.nameSurname,
    required this.birthDateInMillis,
    required this.email,
    required this.location,
    required this.password,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nameSurname: json['nameSurname'],
        birthDateInMillis: json['birthDateInMillis'],
        email: json['email'],
        location: json['location'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'nameSurname': nameSurname,
        'birthDateInMillis': birthDateInMillis,
        'email': email,
        'location': location,
        'password': password,
        'phoneNumber': phoneNumber,
      };
}
