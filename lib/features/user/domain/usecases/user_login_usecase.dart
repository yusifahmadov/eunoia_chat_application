import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class UserLoginUsecase extends Usecase<AuthResponse, UserLoginHelper> {
  UserRepository userRepository;

  UserLoginUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(UserLoginHelper params) {
    return userRepository.login(params);
  }
}
