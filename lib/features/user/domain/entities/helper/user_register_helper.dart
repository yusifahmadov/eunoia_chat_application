class UserRegisterHelper {
  final String name;
  final String email;
  final String password;

  UserRegisterHelper({
    required this.name,
    required this.email,
    required this.password,
  });

  copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserRegisterHelper(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() =>
      'UserRegisterHelper(name: $name, email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRegisterHelper &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ password.hashCode;

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserRegisterHelper.fromMap(Map<String, dynamic> map) {
    return UserRegisterHelper(
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
