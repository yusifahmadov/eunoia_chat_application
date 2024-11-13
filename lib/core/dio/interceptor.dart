import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/user/data/models/auth_response_model.dart';
import '../../features/user/presentation/cubit/user_cubit.dart';
import '../../injection.dart';
import '../shared_preferences/custom_shared_preferences.dart';

class CustomInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final Map<String, dynamic>? user = await CustomSharedPreferences.readUser('user');
    if (user != null) {
      options.headers['Authorization'] =
          "Bearer ${AuthResponseModel.fromJson(user).accessToken}";
    }
    options.headers['apikey'] = dotenv.get('SUPABASE_API_KEY');

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newAccessToken = await (getIt<UserCubit>().refreshToken());
      final previusUserData = AuthResponseModel.fromJson(
        await CustomSharedPreferences.readUser('user') as Map<String, dynamic>,
      );
      err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      CustomSharedPreferences.saveUser(
        'user',
        AuthResponseModel(
          accessToken: newAccessToken,
          refreshToken: previusUserData.refreshToken,
          user: previusUserData.user,
        ),
      );

      return handler.resolve(await Dio().fetch(err.requestOptions));
    }
    super.onError(err, handler);
  }
}
