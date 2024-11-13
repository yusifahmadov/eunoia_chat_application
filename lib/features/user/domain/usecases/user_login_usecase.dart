import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_response.dart';
import '../entities/helper/user_login_helper.dart';
import '../repositories/user_repository.dart';

class UserLoginUsecase extends Usecase<AuthResponse, UserLoginHelper> {
  UserRepository userRepository;

  UserLoginUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(UserLoginHelper params) {
    return userRepository.login(params);
  }
}
