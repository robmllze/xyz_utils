// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// INT CONVERT
//
// NB: Dart only supports 32 bit int on web.
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// INT SIZE INFORMATION
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const String UINT8_MAX = "255";
const String INT8_MAX = "128";
const String INT8_MIN = "-128";
const String UINT16_MAX = "65535";
const String INT16_MAX = "32767";
const String INT16_MIN = "-32768";
const String UINT32_MAX = "4294967295";
const String INT32_MAX = "2147483647";
const String INT32_MIN = "-2147483648";
const String INT64_MAX = "9223372036854775807";
const String INT64_MIN = "-9223372036854775808";
const String UINT64_MAX = "18446744073709551615";

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

const int _256e0 = 1;
const int _256e1 = 256;
const int _256e2 = 256 * 256;
const int _256e3 = 256 * 256 * 256;
const int _256e4 = 256 * 256 * 256 * 256;
const int _256e5 = 256 * 256 * 256 * 256 * 256;
const int _256e6 = 256 * 256 * 256 * 256256 * 256;
const int _256e7 = 256 * 256 * 256 * 256 * 256 * 256 * 256;
const int _256e8 = 256 * 256 * 256 * 256 * 256 * 256 * 256 * 256;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ByteConvertIntExtensionOnInt on int {
  // 8
  int get toUint8 => _toUint8(this);
  int get toInt8 => _toInt8(this);
  // 16
  int get toUint16 => _toUint16(this);
  int get toInt16 => _toInt16(this);
  // 32
  int get toUint32 => _toUint32(this);
  int get toInt32 => _toInt32(this);
  // 64
  int get toUint64 => _toUint64(this);
  int get toInt64 => _toInt64(this);
  // 8
  String get toBytesFromUint8 => _toBytesFromUint8(this);
  String get toBytesFromInt8 => _toBytesFromInt8(this);
  // 16
  String get toBytesFromUint16 => _toBytesFromUint16(this);
  String get toBytesFromInt16 => _toBytesFromInt16(this);
  // 32
  String get toBytesFromUint32 => _toBytesFromUint32(this);
  String get toBytesFromInt32 => _toBytesFromInt32(this);
  // 64
  String get toBytesFromUint64 => _toBytesFromUint64(this);
  String get toBytesFromInt64 => _toBytesFromInt64(this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension ByteConvertIntExtensionOnString on String {
  // 8
  int? get toUint8FromBytes => _toUint8FromBytes(this);
  int? get toInt8FromBytes => _toInt8FromBytes(this);
  // 16
  int? get toUint16FromBytes => _toUint16FromBytes(this);
  int? get toInt16FromBytes => _toInt16FromBytes(this);
  // 32
  int? get toUint32FromBytes => _toUint32FromBytes(this);
  int? get toInt32FromBytes => _toInt32FromBytes(this);
  // 64
  int? get toUint64FromBytes => _toInt64FromBytes(this);
  int? get toInt64FromBytes => _toUint64FromBytes(this);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// 8

int _toUint8(final int i) {
  const int _max = _256e1;
  return i >= _max ? (i % _max) : (i < 0 ? (_max + i) % _max : i);
}

int _toInt8(final int i) {
  const int _min = -(_256e1 ~/ 2);
  return _toUint8(i - _min) + _min;
}

// 16

int _toUint16(final int i) {
  const int _max = _256e2;
  return i >= _max ? (i % _max) : (i < 0 ? (_max + i) % _max : i);
}

int _toInt16(final int i) {
  const int _min = -(_256e2 ~/ 2);
  return _toUint16(i - _min) + _min;
}

// 32

int _toUint32(final int i) {
  const int _max = _256e4;
  return i >= _max ? (i % _max) : (i < 0 ? (_max + i) % _max : i);
}

int _toInt32(final int i) {
  const int _min = -(_256e4 ~/ 2);
  return _toUint32(i - _min) + _min;
}

// 64

int _toUint64(final int i) {
  const int _max = _256e8;
  return i >= _max ? (i % _max) : (i < 0 ? (_max + i) % _max : i);
}

int _toInt64(final int i) {
  const int _min = -(_256e8 ~/ 2);
  return _toUint64(i - _min) + _min;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// 8

String _toBytesFromUint8(final int i) {
  return String.fromCharCode(i.toUint8);
}

// 16

String _toBytesFromUint16(final int i) {
  final int _r0 = i.toUint32;
  return String.fromCharCodes([
    _r0 ~/ _256e1,
    _r0 % _256e1,
  ]);
}

// 32

String _toBytesFromUint32(final int i) {
  final int _r0 = i.toUint32;
  final int _r1 = _r0 % _256e3;
  final int _r2 = _r1 % _256e2;
  final int _r3 = _r2 % _256e1;
  return String.fromCharCodes([
    _r0 ~/ _256e3,
    _r1 ~/ _256e2,
    _r2 ~/ _256e1,
    _r3 ~/ _256e0,
  ]);
}

// 64

String _toBytesFromUint64(final int i) {
  final int _r0 = i.toUint32;
  final int _r1 = _r0 % _256e7;
  final int _r2 = _r1 % _256e6;
  final int _r3 = _r2 % _256e5;
  final int _r4 = _r3 % _256e4;
  final int _r5 = _r4 % _256e3;
  final int _r6 = _r5 % _256e2;
  final int _r7 = _r6 % _256e1;
  return String.fromCharCodes([
    _r0 ~/ _256e7,
    _r1 ~/ _256e6,
    _r2 ~/ _256e5,
    _r3 ~/ _256e4,
    _r4 ~/ _256e3,
    _r5 ~/ _256e2,
    _r6 ~/ _256e1,
    _r7 ~/ _256e0,
  ]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// 8

String _toBytesFromInt8(final int i) {
  return _toBytesFromUint8(i);
}

// 16

String _toBytesFromInt16(final int i) {
  return _toBytesFromUint16(i);
}

// 32

String _toBytesFromInt32(final int i) {
  return _toBytesFromUint32(i);
}

// 64

String _toBytesFromInt64(final int i) {
  return _toBytesFromUint64(i);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// 8

int? _toUint8FromBytes(final String bytes) {
  final List<int> _c = bytes.codeUnits;
  return _c.isNotEmpty
      ? _c[0] //
      : null;
}

// 16

int? _toUint16FromBytes(final String bytes) {
  final List<int> _c = bytes.codeUnits;
  return _c.length >= 2 //
      ? 256 * _c[0] + //
          _c[1]
      : null;
}

// 32

int? _toUint32FromBytes(final String bytes) {
  final List<int> _c = bytes.codeUnits;
  return _c.length >= 4 //
      ? _256e3 * _c[0] + //
          _256e2 * _c[1] +
          _256e1 * _c[2] +
          _c[3]
      : null;
}

// 64

int? _toUint64FromBytes(final String bytes) {
  final List<int> _c = bytes.codeUnits;
  return _c.length >= 8 //
      ? _256e7 * _c[0] + //
          _256e6 * _c[1] +
          _256e5 * _c[2] +
          _256e4 * _c[3] +
          _256e3 * _c[4] +
          _256e2 * _c[5] +
          _256e1 * _c[6] +
          _c[7]
      : null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// 8

int? _toInt8FromBytes(final String bytes) {
  return _toUint8FromBytes(bytes)?.toInt8;
}

// 16

int? _toInt16FromBytes(final String bytes) {
  return _toUint16FromBytes(bytes)?.toInt16;
}

// 32

int? _toInt32FromBytes(final String bytes) {
  return _toUint32FromBytes(bytes)?.toInt32;
}

// 64

int? _toInt64FromBytes(final String bytes) {
  return _toUint64FromBytes(bytes)?.toInt64;
}
