import '../../features/user/data/models/auth_response_model.dart';
import 'custom_shared_preferences.dart';

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
