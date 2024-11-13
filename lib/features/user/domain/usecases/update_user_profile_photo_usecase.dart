import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class UpdateUserProfilePhotoUsecase extends Usecase<void, UploadUserProfilePhotoHelper> {
  UserRepository userRepository;

  UpdateUserProfilePhotoUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, void>> call(UploadUserProfilePhotoHelper params) {
    return userRepository.updateUserProfilePhoto(params);
  }
}
