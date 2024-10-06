import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/injection.dart';

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
}
