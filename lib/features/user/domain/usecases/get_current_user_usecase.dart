import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/no_params.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class GetCurrentUserUsecase extends Usecase<User, NoParams> {
  UserRepository userRepository;

  GetCurrentUserUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, User>> call(params) {
    return userRepository.getCurrentUser();
  }
}
