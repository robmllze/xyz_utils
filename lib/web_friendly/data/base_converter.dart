//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class BaseConverter {
  //
  //
  //

  static const base36Chars = "0123456789abcdefghijklmnopqrstuvwxyz";
  static const base62Chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

  //
  //
  //

  static String toBase62(int value) => _convertBase(value, base62Chars);
  static int fromBase62(String value) => _unconvertBase(value, base62Chars);

  static String toBase36(int value) => _convertBase(value, base36Chars);
  static int fromBase36(String value) => _unconvertBase(value, base36Chars);

  //
  //
  //

  static String _convertBase(int value, String chars) {
    if (value == 0) return chars[0];

    final buffer = StringBuffer();
    while (value > 0) {
      buffer.write(chars[value % chars.length]);
      value ~/= chars.length;
    }
    return buffer.toString().split('').reversed.join();
  }

  //
  //
  //

  static int _unconvertBase(String value, String chars) {
    var result = 0;
    for (var ch in value.split('')) {
      result = result * chars.length + chars.indexOf(ch);
    }
    return result;
  }
}
