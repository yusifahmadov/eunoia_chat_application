import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class SetPublicKeyUsecase extends Usecase<void, String> {
  UserRepository userRepository;

  SetPublicKeyUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, void>> call(String params) {
    return userRepository.setPublicKey(params);
  }
}
