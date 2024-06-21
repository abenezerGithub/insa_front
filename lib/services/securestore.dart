import 'dart:convert';
import 'package:insa_report/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  static const _storage = FlutterSecureStorage();

  static const _userKey = "userforinsareport";

  static Future<User?> getUser() async {
    try {
      // _storage.deleteAll();
      final user = await _storage.read(key: _userKey);
      if (user == null) return null;
      final parsedUser = jsonDecode(user);
      await Future.delayed(const Duration(seconds: 0), () {});
      return User.fromMap(parsedUser);
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<bool> setUser(User user) async {
    try {
      await _storage.write(key: _userKey, value: user.toJson());
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> removeUser() async {
    try {
      await _storage.delete(key: _userKey);
      return true;
    } catch (err) {
      return false;
    }
  }
}
