import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class RefreshTokenUsecase extends Usecase<AuthResponse, String> {
  UserRepository userRepository;

  RefreshTokenUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(params) {
    return userRepository.refreshToken(refreshToken: params);
  }
}
