import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class AuthResponse extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}
