class UserModel {
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;

  UserModel({this.username, this.email, this.firstName, this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      };
}
