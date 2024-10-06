class UserLoginHelper {
  final String email;
  final String password;

  UserLoginHelper({
    required this.email,
    required this.password,
  });

  copyWith({
    String? email,
    String? password,
  }) {
    return UserLoginHelper(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'UserLoginHelper(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLoginHelper && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
