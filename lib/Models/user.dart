class UserModel {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
