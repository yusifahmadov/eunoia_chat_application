import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';

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

  copyWith({
    String? accessToken,
    String? refreshToken,
    UserModel? user,
  }) {
    return AuthResponseModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}
