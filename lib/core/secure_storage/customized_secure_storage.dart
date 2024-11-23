import 'dart:convert';

import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomizedSecureStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<String?> getUserId() async {
    String? id = AuthResponseModel.fromJson(
            await CustomSharedPreferences.readUser('user') as Map<String, dynamic>)
        .user
        .id;

    return id;
  }

  static setNewPublicKey({required String publicKey}) async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.write(key: "publicKey_$userId", value: publicKey);
  }

  static setNewPrivateKey({required String privateKey}) async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.write(key: "privateKey_$userId", value: privateKey);
  }

  static Future<bool> checkPrivateKey() async {
    final String? userId = await getUserId();

    if (userId == null) {
      return false;
    }

    final String? privateKey = await storage.read(key: "privateKey_$userId");

    if (privateKey == null) {
      return false;
    }

    return true;
  }

  static void removeUserKeys() async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.delete(key: userId);
  }

  static void removePublicKey() async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.delete(key: "publicKey_$userId");
  }

  static Future removePrivateKey() async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.delete(key: "privateKey_$userId");
  }

  static Future<void> storeDhEngine({required DhPkcs3Engine engine}) async {
    final String? userId = await getUserId();

    if (userId == null) {
      return;
    }

    await storage.write(
        key: "dhEngine_$userId", value: jsonEncode(engine.toJson(userId: userId)));
  }

  static Future<DhPkcs3Engine?> getDhEngine() async {
    try {
      final String? userId = await getUserId();

      if (userId == null) {
        return null;
      }

      return DhPkcs3Engine.fromJson(
          jsonDecode(await storage.read(key: "dhEngine_$userId") as String)
              as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
