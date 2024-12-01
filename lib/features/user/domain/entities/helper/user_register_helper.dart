import 'package:equatable/equatable.dart';

class UserRegisterHelper extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String username;

  const UserRegisterHelper({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.username = '',
  });

  copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? password,
      String? username}) {
    return UserRegisterHelper(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username);
  }

  @override
  String toString() =>
      'UserRegisterHelper(firstName: $firstName, lastName: $lastName, email: $email, password: $password)';

  toJson() {
    return {
      'email': email,
      'password': password,
      'data': {
        "name": "$firstName $lastName",
        "username": username,
      },
    };
  }

  factory UserRegisterHelper.fromMap(Map<String, dynamic> map) {
    return UserRegisterHelper(
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  List<Object?> get props => [];
}
