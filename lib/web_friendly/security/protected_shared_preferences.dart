//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:encrypt/encrypt.dart';
export 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ProtectedSharedPreferences {
  //
  //
  //

  final SharedPreferences sharedPreferences;
  final String password;

  //
  //
  //

  ProtectedSharedPreferences._(
    this.sharedPreferences,
    this.password,
  );

  //
  //
  //

  static Future<ProtectedSharedPreferences> getInstance(String password) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return ProtectedSharedPreferences._(sharedPreferences, password);
  }

  //
  //
  //

  Future<bool> setStringSalsa20(String key, String value) {
    // Password = hardcoded password + key.
    final password = Key.fromUtf8("${this.password}$key");
    final encrypter = Encrypter(Salsa20(password));
    final encrypted = encrypter.encrypt(value, iv: IV.fromLength(8));
    return this.sharedPreferences.setString(key, encrypted.base64);
  }

  //
  //
  //

  String? getStringSalsa20(String key) {
    final raw = this.sharedPreferences.getString(key);
    if (raw != null) {
      // Password = hardcoded password + key.
      final password = Key.fromUtf8("${this.password}$key");
      final encrypter = Encrypter(Salsa20(password));
      final decrypted = encrypter.decrypt(
        Encrypted.fromBase64(raw),
        iv: IV.fromLength(8),
      );
      return decrypted;
    }
    return null;
  }

  //
  //
  //

  Future<bool> setIntSalsa20(String key, int value) {
    return this.setStringSalsa20(key, value.toString());
  }

  //
  //
  //

  int? getIntSalsa20(String key) {
    final temp = this.getStringSalsa20(key);
    if (temp != null) return int.tryParse(temp);
    return null;
  }

  //
  //
  //

  Future<void> removeAll(List<String> keys) async {
    final all = keys.map((final key) => this.sharedPreferences.remove(key));
    await Future.wait(all);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String specificKey({
  required String key,
  required String appId,
}) {
  return "$appId?key=$key";
}

String specificVersionKey({
  required String key,
  required String appId,
  required String appVersion,
}) {
  return "$appId?version=$appVersion&key=$key";
}
