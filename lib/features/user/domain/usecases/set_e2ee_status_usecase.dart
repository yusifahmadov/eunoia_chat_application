import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class SetE2eeStatusUsecase extends Usecase<ResponseI, bool> {
  UserRepository userRepository;

  SetE2eeStatusUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, ResponseI>> call(params) {
    return userRepository.setE2eeStatus(params);
  }
}
