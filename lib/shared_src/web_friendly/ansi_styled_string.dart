//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// X|Y|Z & Dev
//
// Copyright Ⓒ Robert Mollentze, xyzand.dev
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class AnsiStyle {
  //
  //
  //

  final List<int> _codes;

  //
  //
  //

  AnsiStyle(int code) : this._codes = [code];

  //
  //
  //

  AnsiStyle._multiple(this._codes);

  //
  //
  //

  AnsiStyle operator +(AnsiStyle other) {
    return AnsiStyle._multiple([...this._codes, ...other._codes]);
  }

  //
  //
  //

  String formatted(Object? value) {
    var result = value.toString();
    for (final code in this._codes) {
      result = result.withAnsiStyleCode(code);
    }
    return result;
  }

  //
  //
  //

  static AnsiStyle get escape => AnsiStyle(0);
  static AnsiStyle get bold => AnsiStyle(1);
  static AnsiStyle get dim => AnsiStyle(2);
  static AnsiStyle get italic => AnsiStyle(3);
  static AnsiStyle get underline => AnsiStyle(4);
  static AnsiStyle get blink => AnsiStyle(5);
  static AnsiStyle get flicker => AnsiStyle(6);

  //
  //
  //

  static AnsiStyle get reverse => AnsiStyle(7);
  static AnsiStyle get cancelled => AnsiStyle(8);
  static AnsiStyle get strikethrough => AnsiStyle(9);

  //
  //
  //

  static AnsiStyle get style11 => AnsiStyle(11);
  static AnsiStyle get style12 => AnsiStyle(12);
  static AnsiStyle get style13 => AnsiStyle(13);
  static AnsiStyle get style14 => AnsiStyle(14);
  static AnsiStyle get style15 => AnsiStyle(15);
  static AnsiStyle get h4 => AnsiStyle(16);
  static AnsiStyle get h3 => AnsiStyle(17);
  static AnsiStyle get h2 => AnsiStyle(18);
  static AnsiStyle get headingTertiary1 => AnsiStyle(19);
  static AnsiStyle get style20 => AnsiStyle(20);
  static AnsiStyle get style21 => AnsiStyle(21);

  //
  //
  //

  static AnsiStyle get fgBlack => AnsiStyle(30);
  static AnsiStyle get fgRed => AnsiStyle(31);
  static AnsiStyle get fgGreen => AnsiStyle(32);
  static AnsiStyle get fgYellow => AnsiStyle(33);
  static AnsiStyle get fgBlue => AnsiStyle(34);
  static AnsiStyle get fgPurple => AnsiStyle(35);
  static AnsiStyle get fgCyan => AnsiStyle(36);
  static AnsiStyle get fgWhite => AnsiStyle(37);

  //
  //
  //

  static AnsiStyle get fgLightBlack => AnsiStyle(90);
  static AnsiStyle get fgLightRed => AnsiStyle(91);
  static AnsiStyle get fgLightGreen => AnsiStyle(92);
  static AnsiStyle get fgLightYellow => AnsiStyle(93);
  static AnsiStyle get fgLightBlue => AnsiStyle(94);
  static AnsiStyle get fgLightPurple => AnsiStyle(95);
  static AnsiStyle get fgLightCyan => AnsiStyle(96);
  static AnsiStyle get fgLightWhite => AnsiStyle(97);

  //
  //
  //

  static AnsiStyle get bgBlack => AnsiStyle(40);
  static AnsiStyle get bgRed => AnsiStyle(41);
  static AnsiStyle get bgGreen => AnsiStyle(42);
  static AnsiStyle get bgYellow => AnsiStyle(43);
  static AnsiStyle get bgBlue => AnsiStyle(44);
  static AnsiStyle get bgPurple => AnsiStyle(45);
  static AnsiStyle get bgCyan => AnsiStyle(46);
  static AnsiStyle get bgWhite => AnsiStyle(47);

  //
  //
  //

  static AnsiStyle get superscript => AnsiStyle(48);
  static AnsiStyle get subscript => AnsiStyle(49);

  //
  //
  //

  static AnsiStyle get bgLightBlack => AnsiStyle(100);
  static AnsiStyle get bgLightRed => AnsiStyle(101);
  static AnsiStyle get bgLightGreen => AnsiStyle(102);
  static AnsiStyle get bgLightYellow => AnsiStyle(103);
  static AnsiStyle get bgLightBlue => AnsiStyle(104);
  static AnsiStyle get bgLightPurple => AnsiStyle(105);
  static AnsiStyle get bgLightCyan => AnsiStyle(106);
  static AnsiStyle get bgLightWhite => AnsiStyle(107);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension AnsiStyledString on String {
  String withAnsiStyleCode(int? code) {
    if (code == null) return this;
    return "\u001b[${code}m$this\u001b[0m";
  }

  String withAnsiStyle(AnsiStyle? style) {
    if (style == null) return this;
    return style.formatted(this);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void printBlack(Object? message) {
  final formatted = AnsiStyle.fgBlack.formatted(message);
  print(formatted);
}

void printRed(Object? message) {
  final formatted = AnsiStyle.fgRed.formatted(message);
  print(formatted);
}

void printGreen(Object? message) {
  final formatted = AnsiStyle.fgGreen.formatted(message);
  print(formatted);
}

void printYellow(Object? message) {
  final formatted = AnsiStyle.fgYellow.formatted(message);
  print(formatted);
}

void printBlue(Object? message) {
  final formatted = AnsiStyle.fgBlue.formatted(message);
  print(formatted);
}

void printPurple(Object? message) {
  final formatted = AnsiStyle.fgPurple.formatted(message);
  print(formatted);
}

void printCyan(Object? message) {
  final formatted = AnsiStyle.fgCyan.formatted(message);
  print(formatted);
}

void printWhite(Object? message) {
  final formatted = AnsiStyle.fgWhite.formatted(message);
  print(formatted);
}

void printLightBlack(Object? message) {
  final formatted = AnsiStyle.fgLightBlack.formatted(message);
  print(formatted);
}

void printLightRed(Object? message) {
  final formatted = AnsiStyle.fgLightRed.formatted(message);
  print(formatted);
}

void printLightGreen(Object? message) {
  final formatted = AnsiStyle.fgLightGreen.formatted(message);
  print(formatted);
}

void printLightYellow(Object? message) {
  final formatted = AnsiStyle.fgLightYellow.formatted(message);
  print(formatted);
}

void printLightBlue(Object? message) {
  final formatted = AnsiStyle.fgLightBlue.formatted(message);
  print(formatted);
}

void printLightPurple(Object? message) {
  final formatted = AnsiStyle.fgLightPurple.formatted(message);
  print(formatted);
}

void printLightCyan(Object? message) {
  final formatted = AnsiStyle.fgLightCyan.formatted(message);
  print(formatted);
}

void printLightWhite(Object? message) {
  final formatted = AnsiStyle.fgLightWhite.formatted(message);
  print(formatted);
}
