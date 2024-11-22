import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/update_user_information_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';

import '../../../../core/response/response.dart';
import '../../data/models/auth_response_model.dart';
import '../entities/auth_response.dart';
import '../entities/helper/user_login_helper.dart';
import '../entities/helper/user_register_helper.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<ResponseI, AuthResponse>> login(UserLoginHelper body);
  Future<Either<ResponseI, AuthResponse>> register(UserRegisterHelper body);
  Future<Either<ResponseI, AuthResponseModel>> refreshToken(
      {required String refreshToken});

  Future<Either<ResponseI, List<User>>> getUser({required int conversationId});
  Future<Either<ResponseI, User>> getCurrentUser();
  Future<Either<ResponseI, void>> updateUserProfilePhoto(
      UploadUserProfilePhotoHelper body);

  Future<Either<ResponseI, void>> setPublicKey(String publicKey);

  Future<Either<ResponseI, ResponseI>> updateUserInformation(
      UpdateUserInformationHelper helper);
}
