import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class GetUserUsecase extends Usecase<List<User>, String> {
  UserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, List<User>>> call(params) {
    return userRepository.getUser(id: params);
  }
}
