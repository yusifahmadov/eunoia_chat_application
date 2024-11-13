import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../injection.dart';
import '../../domain/entities/helper/user_login_helper.dart';
import '../../domain/entities/helper/user_register_helper.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<AuthResponseModel> login(UserLoginHelper body) async {
    final response = await getIt<Dio>().post(
      '/auth/v1/token?grant_type=password',
      data: body.toJson(),
    );

    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> register(UserRegisterHelper body) async {
    final response = await getIt<Dio>().post(
      '/auth/v1/signup',
      data: body.toJson(),
    );

    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    final response = await getIt<Dio>().post(
      '/auth/v1/token?grant_type=refresh_token',
      data: {
        'refresh_token': refreshToken,
      },
    );

    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<List<UserModel>> getUser(int conversationId) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/get_participants_data',
      data: {
        'p_conversation_id': conversationId,
      },
    );

    return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/get_current_user',
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> updateUserProfilePhoto(UploadUserProfilePhotoHelper body) async {
    String fileName =
        AuthResponseModel.fromJson((await CustomSharedPreferences.readUser('user'))!)
            .user
            .id;
    final data = FormData();
    data.files.add(MapEntry(
      'body',
      MultipartFile.fromFileSync(
        body.file.path,
        filename: '$fileName.jpg',
        contentType: MediaType.parse('image/jpeg'),
      ),
    ));
    await getIt<Dio>().post('/storage/v1/object/users/${'$fileName.jpg'}', data: data);
  }
}
