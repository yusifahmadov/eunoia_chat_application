import 'package:eunoia_chat_application/core/response/response_model.dart';
import 'package:eunoia_chat_application/features/message/data/models/participant_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/set_public_key_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';

import '../../domain/entities/helper/user_login_helper.dart';
import '../../domain/entities/helper/user_register_helper.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<AuthResponseModel> login(UserLoginHelper body);
  Future<AuthResponseModel> register(UserRegisterHelper body);
  Future<AuthResponseModel> refreshToken(String refreshToken);
  Future<List<ParticipantModel>> getUser(int conversationId);

  Future<UserModel> getCurrentUser();
  Future<void> updateUserProfilePhoto(UploadUserProfilePhotoHelper body);
  Future<String> setPublicKey(SetPublicKeyHelper helper);

  Future<ResponseModel> updateUserInformation(Map<String, dynamic> body);

  Future<ResponseModel> setE2eeStatus(bool status);
}
