import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_response.dart';
import '../repositories/user_repository.dart';

class RefreshTokenUsecase extends Usecase<AuthResponse, String> {
  UserRepository userRepository;

  RefreshTokenUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(params) {
    return userRepository.refreshToken(refreshToken: params);
  }
}
