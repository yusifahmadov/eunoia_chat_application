import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class UserRegisterUsecase extends Usecase<AuthResponse, UserRegisterHelper> {
  UserRepository userRepository;

  UserRegisterUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, AuthResponse>> call(UserRegisterHelper params) {
    return userRepository.register(params);
  }
}
