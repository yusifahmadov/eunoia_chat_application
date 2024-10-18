import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel(
      {required super.accessToken, required super.refreshToken, required super.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user,
    };
  }
}
