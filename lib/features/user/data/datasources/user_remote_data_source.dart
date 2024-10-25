import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/data/models/user_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';

abstract class UserRemoteDataSource {
  Future<AuthResponseModel> login(UserLoginHelper body);
  Future<AuthResponseModel> register(UserRegisterHelper body);
  Future<AuthResponseModel> refreshToken(String refreshToken);
  Future<List<UserModel>> getUser(int conversationId);

  Future<UserModel> getCurrentUser();
}
