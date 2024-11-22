import 'dart:convert';

import 'package:eunoia_chat_application/core/encryption/dh_base.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomizedSecureStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<DhKey?> getUserKeys() async {
    final String? userId = await getUserId();

    if (userId == null) {
      return null;
    }
    final userKey = await storage.read(key: userId);

    if (userKey == null) {
      return null;
    }

    final DhKey publicKey =
        DhKey.fromJson(jsonDecode(await storage.read(key: userId) as String));
    return publicKey;
  }

  static Future<String?> getUserId() async {
    String? id = AuthResponseModel.fromJson(
            await CustomSharedPreferences.readUser('user') as Map<String, dynamic>)
        .user
        .id;

    return id;
  }

  static Future<void> setUserKeys({required DhKey keyPair}) async {
    final String? userId = await getUserId();
    if (userId == null) {
      return;
    }

    await storage.write(key: userId, value: jsonEncode(keyPair.toJson(userId: userId)));
  }
}
