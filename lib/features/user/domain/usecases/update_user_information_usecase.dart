import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/update_user_information_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class UpdateUserInformationUsecase extends Usecase<void, UpdateUserInformationHelper> {
  UserRepository userRepository;

  UpdateUserInformationUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, void>> call(UpdateUserInformationHelper params) {
    return userRepository.updateUserInformation(params);
  }
}
