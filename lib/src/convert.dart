// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
// //
// // XYZ Utils
// //
// // ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// import 'dart:convert';
// import 'dart:core';
// import 'dart:typed_data';

// import '../xyz_utils.dart';
// import 'data.dart';

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class MapConverter<K, V> extends _Converter<Map<K, V>> {
//   const MapConverter();
//   @override
//   Map<K, V>? convert(dynamic input, {bool filterNulls = false}) {
//     dynamic decoded;
//     if (input is String) {
//       decoded = const JsonDecoder().convert(input);
//     } else {
//       decoded = input;
//     }
//     if (decoded is Map) {
//       try {
//         final temp = decoded.entries
//             .map((final entry) {
//               final convertedKey = let<K>(entry.key);
//               final convertedValue = let<V>(entry.value);
//               if (filterNulls) {
//                 if (!isNullable<K>() && convertedKey == null) return const _Empty();
//                 if (!isNullable<V>() && convertedValue == null) return const _Empty();
//               }
//               return MapEntry(convertedKey as K, convertedValue as V);
//             })
//             .where((final e) => e != const _Empty())
//             .map((final e) => e as MapEntry<K, V>);
//         return Map.fromEntries(temp.nonNulls;
//       } catch (_) {
//         return null;
//       }
//     }
//     return null;
//   }
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class IterableConverter<V> extends _Converter<Iterable<V>> {
//   @override
//   Iterable<V>? convert(dynamic input, {bool filterNulls = false}) {
//     final nullable = isNullable<V>();
//     if (!nullable && input == null) return null;
//     dynamic decoded;
//     if (input is String) {
//       decoded = input.split(",").map((final e) => e.trim());
//     } else {
//       decoded = input;
//     }
//     if (decoded is Iterable) {
//       try {
//         final a = decoded.map((final element) {
//           final result = let<V>(element);
//           if (filterNulls) {
//             if (!nullable && result == null) {
//               return const _Empty();
//             }
//           }
//           return result;
//         });
//         final b = a.where((final e) => e != const _Empty());
//         var c = b.map((final e) => e as V);
//         if (filterNulls) {
//           c = c.where((final e) => e != null);
//         }
//         return c;
//       } catch (_) {}
//     }
//     return [input];
//   }
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// class _Empty {
//   const _Empty();
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// T? let<T>(dynamic input, {T? fallback}) {
//   try {
//     if (T == dynamic) return input;
//     if (input == null && T != Null) return null;
//     if (T == input.runtimeType) return input as T;
//     if (typeEquality<T, double>() || typeEquality<T, double?>()) {
//       // num to double
//       if (input is num) {
//         return input.toDouble() as T;
//       }
//       // String to double
//       if (input is String) {
//         return double.tryParse(input) as T;
//       }
//     } else if (typeEquality<T, int>() || typeEquality<T, int?>()) {
//       // num to int
//       if (input is num) {
//         return input.toInt() as T;
//       }
//       // String to int
//       if (input is String) {
//         return int.tryParse(input) as T;
//       }
//     } else if (typeEquality<T, num>() || typeEquality<T, num?>()) {
//       // num to num
//       if (input is num) {
//         return input as T;
//       }
//       // String to num
//       if (input is String) {
//         return num.tryParse(input) as T;
//       }
//     } else if (typeEquality<T, bool>() || typeEquality<T, bool?>()) {
//       // String to bool
//       if (input is String) {
//         final temp = input.toLowerCase();
//         final isTrue = temp == "true";
//         if (isTrue) return true as T;
//         final isFalse = temp == "false";
//         if (isFalse) return false as T;
//       }
//     } else if (typeEquality<T, DateTime>() || typeEquality<T, DateTime?>()) {
//       // String to DateTime
//       if (input is String) {
//         return DateTime.tryParse(input) as T;
//       }
//       // anything to DateTime
//       final microseconds = let<int>(input);
//       if (microseconds != null) {
//         return DateTime.fromMicrosecondsSinceEpoch(microseconds) as T;
//       }
//     } else if (typeEquality<T, Duration>() || typeEquality<T, Duration?>()) {
//       // String to Duration
//       if (input is String) {
//         return input.tryParseDuration() as T;
//       }
//     } else if (typeEquality<T, Uri>() || typeEquality<T, Uri?>()) {
//       // String to Uri
//       if (input is String) {
//         return Uri.tryParse(input) as T;
//       }
//     } else if (typeEquality<T, String>() || typeEquality<T, String?>()) {
//       // anything to String
//       return input.toString() as T;
//     }
//   } catch (_) {}
//   return fallback;
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// void testLet() {
//   // Test double conversion
//   assert(let<double>(1) == 1.0);
//   assert(let<double>("1") == 1.0);
//   assert(let<double>(true, fallback: 0.0) == 0.0);

//   // Test int conversion
//   assert(let<int>(1.5) == 1);
//   assert(let<int>("1") == 1);
//   assert(let<int>(true, fallback: 0) == 0);

//   // Test num conversion
//   assert(let<num>(1) == 1);
//   assert(let<num>(1.5) == 1.5);
//   assert(let<num>("1") == 1);

//   // Test bool conversion
//   assert(let<bool>(true) == true);
//   assert(let<bool>("true") == true);
//   assert(let<bool>("false") == false);

//   // Test DateTime conversion
//   final dateTime = DateTime(2022, 4, 23, 12, 0, 0);
//   final microseconds = dateTime.microsecondsSinceEpoch;
//   assert(let<DateTime>(microseconds) == dateTime);
//   assert(let<DateTime>("2022-04-23T12:00:00") == dateTime);

//   // Test Duration conversion
//   final duration = Duration(hours: 2, minutes: 30);
//   final microseconds2 = duration.inMicroseconds;
//   assert(let<Duration>(microseconds2) == duration);
//   assert(let<Duration>(microseconds2.toString()) == duration);

//   // Test Uri conversion
//   final uri = Uri.parse("https://example.com");
//   assert(let<Uri>("https://example.com") == uri);

//   // Test String conversion
//   assert(let<String>(1) == "1");
//   assert(let<String>(1.5) == "1.5");
//   assert(let<String>(true) == "true");
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// void main() {
//   print(IterableConverter<int>().convert([null])?.toSet());

//   //print("24:00:04.00003".tryParseDuration().toString());
//   //testLet();
//   // dynamic map = {"key1": 1, "key2": 2, "key3": 3, "key4": 4, "key5": "six", "key6": "6"};

//   // print(const MapConverter<String, int>().convert(map, filterNulls: true));
//   // print(let<String?>("hello"));
//   // print(let<String>("hello"));
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// extension ParseDuration on String {
//   //
//   //
//   //

//   Duration? tryParseDuration() {
//     final a = this.split(":");
//     if (a.length != 3) return null;
//     final b = a[2].split(".");
//     if (b.length != 2) return null;
//     final c = [...a.sublist(0, 2), ...b];
//     if (c.length != 4) return null;
//     final hours = int.tryParse(c[0]);
//     if (hours == null) return null;
//     final minutes = int.tryParse(c[1]);
//     if (minutes == null) return null;
//     final seconds = int.tryParse(c[2]);
//     if (seconds == null) return null;
//     final microseconds = int.tryParse(c[3]);
//     if (microseconds == null) return null;
//     return Duration(
//       hours: hours,
//       minutes: minutes,
//       seconds: seconds,
//       microseconds: microseconds,
//     );
//   }

//   //
//   //
//   //

//   Duration parseDuration() {
//     final duration = this.tryParseDuration();
//     if (duration == null) {
//       throw ArgumentError("Invalid duration string: $this");
//     }

//     return duration;
//   }
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// bool isNullable<T>() => null is T;

// abstract class _Converter<T> {
//   const _Converter();
//   T? convert(dynamic input, {bool filterNulls = false});
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// /// Calculates the FNV-1a hash value for the given input string.
// int fnvHash(String input) {
//   final data = Uint8List.fromList(input.codeUnits);
//   final length = data.length;
//   var hash = 0;
//   for (var n = 0; n < length; n++) {
//     var code = data[n];
//     // Apply the FNV-1a algorithm to update the hash value.
//     hash = ((hash << 5) - hash) + code;
//     // Convert the hash value to a 32-bit integer using bitwise AND.
//     hash = hash & hash;
//   }
//   // Ensure the hash value is positive by masking out the sign bit.
//   return hash & 0x7fffffff;
// }

// // ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// final _dateTimeHash = fnvHash((DateTime).toString());
// final _stringHash = fnvHash((String).toString());
// final _doubleHash = fnvHash((double).toString());
// final _numHash = fnvHash((num).toString());
// final _intHash = fnvHash((int).toString());
// final _boolHash = fnvHash((bool).toString());

// final _nullableDateTimeHash = fnvHash("${(DateTime).toString()}?");
// final _nullableStringHash = fnvHash("${(String).toString()}?");
// final _nullableDoubleHash = fnvHash("${(double).toString()}?");
// final _nullableNumHash = fnvHash("${(num).toString()}?");
// final _nullableIntHash = fnvHash("${(int).toString()}?");
// final _nullableBoolHash = fnvHash("${(bool).toString()}?");

// final _nullableDateTime = "${(DateTime).toString()}?";
// final _nullableString = "${(String).toString()}?";
// final _nullableDouble = "${(double).toString()}?";
// final _nullableNum = "${(num).toString()}?";
// final _nullableInt = "${(int).toString()}?";
// final _nullableBool = "${(bool).toString()}?";
// final _nullableUri = "${(Uri).toString()}?";
// final _nullableDuration = "${(Duration).toString()}?";
