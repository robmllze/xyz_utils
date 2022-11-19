// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// CRYPT
//
// TODO: Finish comments.
//
// <#Author=>
// <#Date   =>
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math' show Random;

import 'base.dart';
import 'int_convert.dart';
import 'mapping.dart' show mapShuffle, unmapShuffle;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// CRYPT METHOD
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Used to identify the cryptic type used.
enum CryptMethod { BASIC, BOGUS, NONE }

extension CryptMethod_Code on CryptMethod {
  /// Returns the integer representation of the [CryptMethod] value.
  int get code {
    switch (this) {
      case CryptMethod.BASIC:
        return 0;
      case CryptMethod.BOGUS:
        return 1;
      default:
        return -1;
    }
  }
}

extension CryptMethod_toShortString on CryptMethod {
  /// Returns the name of the [CryptMethod] value.
  String get name {
    final s = this.toString();
    return s.substring(s.indexOf('.') + 1);
  }
}

/// Returns the [CryptMethod] value from a valid `name`.
CryptMethod nameToCryptMethod(final String name) {
  switch (name.toLowerCase()) {
    case "basic":
      return CryptMethod.BASIC;
    case "bogus":
      return CryptMethod.BOGUS;
    default:
      return CryptMethod.NONE;
  }
}

/// Returns the [CryptMethod] value from a valid `code`.
CryptMethod codeToCryptMethod(final int code) {
  switch (code) {
    case 0:
      return CryptMethod.BASIC;
    case 1:
      return CryptMethod.BOGUS;
    default:
      return CryptMethod.NONE;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// OK
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// Used to verify decryption success.
const String _OK = "0|<@Y";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// CRYPT
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension Crypt on String {
  /// Encrypts `this` using the "basic" `password` protection algorithm.
  String encryptedBasic(final String password) {
    final _password = password.codeUnits;
    final _encrypted = <int>[];
    int p, m = 0;
    // Encode _OK in order to verify success when decrypting.
    for (final int c in "$_OK$this".codeUnits) {
      p = c + m + _password[m++];
      if (m == _password.length) m = 0;
      while (p > 255) p -= 255;
      _encrypted.add(p);
    }
    // Encode the method.
    return CryptMethod.BASIC.code.toBytesFromUint32 + String.fromCharCodes(_encrypted);
  }

  /// Decrypts `this` using the "basic" `password` protection algorithm. If
  /// decryption failed, `null` is returned instead.
  String? decryptedBasic(final String password) {
    // Verify that String is encrypted with the "basic" algorithm.
    if (this.length >= 4 && this.toUint32FromBytes == CryptMethod.BASIC.code) {
      final _password = password.codeUnits;
      final _codes = <int>[];
      int p, m = 0;
      for (final int c in this.substring(4).codeUnits) {
        p = c - m - _password[m++];
        if (m == _password.length) m = 0;
        while (p < 0) p += 255;
        _codes.add(p);
      }
      final _decrypted = String.fromCharCodes(_codes);
      // Verify that _decrypted starts with _OK.
      if (_decrypted.startsWith(_OK)) {
        return _decrypted.substring(_OK.length);
      }
    }
    return null;
  }

  /// Encrypts `this` using the "bogus" `password` protection algorithm.
  ///
  /// **How it Works:**
  ///
  /// First, "bogus" data of length between `bogusLenMin` and
  /// `bogusLenMax` is prepended to the real data, then it is encrypted by
  /// the "basic" algorithm.
  ///
  /// See [encryptedBasic].
  String encryptedBogus(
    final String password, [
    final int bogusLenMin = 4,
    final int bogusLenMax = 12,
  ]) {
    assert(bogusLenMin >= 0);
    assert(bogusLenMax >= 0);
    final _random = Random();
    final _bogusLen = bogusLenMin + (bogusLenMax != 0 ? _random.nextInt(bogusLenMax) : 0);
    final _bogusLenAsBytes = _bogusLen.toBytesFromUint32;
    // Generate bogus data.
    final _charCodesBogus = List<int>.generate(_bogusLen, (_) => _random.nextInt(256));
    final _bogus = String.fromCharCodes(_charCodesBogus);
    // If message starts with \0\0\0\0, the first 4 characters of the password
    // will be visible. Adding #### before the password hides it.
    return CryptMethod.BOGUS.code.toBytesFromUint32 +
        ("$_bogusLenAsBytes"
                "$_bogus"
                "$_OK"
                "$this")
            .encryptedBasic("####$password");
  }

  /// Decrypts `this` using the "bogus" `password` protection algorithm.
  ///
  /// Note: `bogusLenMax` must be sufficiently large, otherwise decryption will
  /// fail. If decryption failed, `null` is returned instead.
  ///
  /// See descriptions of [encryptedBogus] and [decryptedBasic] for more
  /// information.
  String? decryptedBogus(
    final String password, [
    final int bogusLenMax = 1024,
  ]) {
    assert(bogusLenMax >= 0);
    if (this.length >= 4 && this.toUint32FromBytes == CryptMethod.BOGUS.code) {
      final String? _basic = this.substring(4).decryptedBasic("####$password");
      if (_basic != null) {
        final _bogusLen = _basic.toUint32FromBytes ?? 0;
        if (_bogusLen > bogusLenMax) return "";
        final _start = 4 + _bogusLen;
        final String? _res = _basic.length >= _start ? _basic.substring(_start) : null;
        if (_res != null && _res.startsWith(_OK)) {
          return _res.substring(_OK.length);
        }
      }
    }
    return null;
  }

  /// Decrypts `this` no matter which encryption methof is used. If decryption
  /// failed, `null` is returned instead.
  String? decrypted(final String password) {
    if (this.length >= 4) {
      final int? _code = this.toUint32FromBytes;
      if (_code != null) {
        final CryptMethod? _method = codeToCryptMethod(_code);
        switch (_method) {
          case CryptMethod.BASIC:
            return this.decryptedBasic(password);
          case CryptMethod.BOGUS:
            return this.decryptedBogus(password);
          default:
            return null;
        }
      }
    }
    return null;
  }

  //
  //
  //

  String shuffled([final int shuffle = 3]) {
    final _length = this.length;
    final _charCodes = this.codeUnits;
    final _shuffledPositions = <int>[];
    for (int n = 0; n < _length; n++) {
      _shuffledPositions.add(mapShuffle(n, _length - 1, shuffle));
    }
    final _shuffled = List<int>.generate(this.length, (_m) => _charCodes[_shuffledPositions[_m]]);
    return String.fromCharCodes(_shuffled);
  }

  //
  //
  //

  String unshuffled([final int shuffle = 3]) {
    final _length = this.length;
    final _charCodes = this.codeUnits;
    final unshuffledPositions = <int>[];
    for (int n = 0; n < _length; n++) {
      unshuffledPositions.add(unmapShuffle(n, _length - 1, shuffle));
    }
    final unshuffled = List<int>.generate(this.length, (_m) => _charCodes[unshuffledPositions[_m]]);
    return String.fromCharCodes(unshuffled);
  }

  //
  //
  //

  /// Returns `this` with its encoded length.
  String withLength() {
    return this.length.toBytesFromUint32 + this;
  }

  //
  //
  //

  /// Returns `this` without its encoded length.
  String withoutLength([final int? lengthMax]) {
    final int? _length = this.toUint32FromBytes;
    if (_length != null &&
        _length <= this.length - 4 &&
        (lengthMax == null || _length <= lengthMax)) {
      return this.substring(4, 4 + _length);
    }
    return this;
  }

  //
  //
  //

  /// Unjoins `this` String joined via the [join] extension method on
  /// List<String> back into a List<String> object.
  List<String> lengthUnjoin() {
    final _res = <String>[];
    int n = 0;
    while (true) {
      final _temp = this.substring(n).withoutLength();
      _res.add(_temp);
      n += 4 + _temp.length;
      if (n >= this.length) {
        break;
      }
    }
    return _res;
  }

  //
  //
  //

  String stripified() {
    return this.codeUnits.join("-");
  }

  //
  //
  //

  String unstripified() {
    final _charCodes = <int>[];
    for (final el in this.split("-")) {
      final int? c = int.tryParse(el);
      if (c == null) return "";
      _charCodes.add(c);
    }
    return String.fromCharCodes(_charCodes);
  }

  //
  //
  //

  String codified([final int shuffle = 3]) {
    final _codeUnits = this.codeUnits;
    final _res = <String>[];
    for (final el in _codeUnits) {
      final u = getBaseXFromBase10(el, DIGITS_BASE_36_SHUFFLED);
      if (u.length == 1) {
        final _code = Random.secure().nextInt(26); // NB: May throw UnsupportedError!
        final _prefix = String.fromCharCode(97 /*'a'*/ + _code);
        _res.add("$_prefix$u");
      } else {
        _res.add(u);
      }
    }
    return _res.join().shuffled(shuffle);
  }

  //
  //
  //

  String? uncodified([final int shuffle = 3]) {
    final unshuffled = this.unshuffled(shuffle);
    final _res = <int>[];
    for (int n = 0; n < unshuffled.length; n += 2) {
      int? c;
      final _code = unshuffled[n].codeUnitAt(0);
      if (_code >= 97 /*'a'*/ && _code <= 122 /*'z'*/) {
        c = getBase10FromBaseX(unshuffled[n + 1], DIGITS_BASE_36_SHUFFLED);
      } else {
        c = getBase10FromBaseX(unshuffled[n] + unshuffled[n + 1], DIGITS_BASE_36_SHUFFLED);
      }
      if (c == -1) return null;
      _res.add(c);
    }
    return String.fromCharCodes(_res);
  }

  /// Returns the reverse of `this`.
  String get reversed {
    return this.split("").reversed.join("");
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension Join on List<String> {
  /// Joins Strings together into a single [String]. The result can be unjoined
  /// via the [unjoin] String-extension method.
  String lengthJoin() {
    String _res = "";
    for (final el in this) _res += el.withLength();
    return _res;
  }
}
