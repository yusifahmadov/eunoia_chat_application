import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth_response.dart';
import '../entities/helper/user_register_helper.dart';
import '../repositories/user_repository.dart';

class UserRegisterUsecase extends Usecase<AuthResponse, UserRegisterHelper> {
  UserRepository userRepository;

  UserRegisterUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(UserRegisterHelper params) {
    return userRepository.register(params);
  }
}
