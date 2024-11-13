import '../../domain/entities/auth_response.dart';
import 'user_model.dart';

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
