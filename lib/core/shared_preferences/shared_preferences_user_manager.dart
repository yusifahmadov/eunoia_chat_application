import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';

class SharedPreferencesUserManager {
  static Future<AuthResponseModel?> getUser() async {
    try {
      final AuthResponseModel user = AuthResponseModel.fromJson(
          (await CustomSharedPreferences.readUser('user')) ?? {});
      return user;
    } catch (e) {
      return null;
    }
  }
}
