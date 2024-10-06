import 'dart:convert';

import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for managing user data using shared preferences.
///
/// This class provides methods to save and read user data in the form of
/// `ExtendedUser` objects to and from the shared preferences storage.
///
/// Methods:
///
/// - `saveUser(String key, ExtendedUser value)`: Saves the given `ExtendedUser`
///   object to shared preferences under the specified key. The user data is
///   serialized to a JSON string before being stored.
///
/// - `readUser(String key)`: Reads the user data stored under the specified key
///   from shared preferences. The data is deserialized from a JSON string back
///   into a user object. Returns `null` if no data is found for the given key.

class CustomSharedPreferences {
  static Future<void> saveUser(String key, AuthResponse value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  static Future<Map<String, dynamic>?> readUser(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key)!);
    }
    return null;
  }
}
