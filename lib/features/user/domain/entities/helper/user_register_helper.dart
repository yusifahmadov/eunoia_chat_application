import 'package:equatable/equatable.dart';

class UserRegisterHelper extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const UserRegisterHelper({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
  });

  copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return UserRegisterHelper(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() =>
      'UserRegisterHelper(firstName: $firstName, lastName: $lastName, email: $email, password: $password)';

  toJson() {
    return {
      'email': email,
      'password': password,
      'data': {
        'first_name': firstName,
        'last_name': lastName,
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
