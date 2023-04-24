// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
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
//         return Map.fromEntries(temp.nullsRemoved());
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

// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'convert.dart';
import 'data.dart' show MapNullKeysAndValuesRemoved;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T? letAs<T>(dynamic input) {
  return input is T ? input : null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Map<String, dynamic>? letAsKeyMap(dynamic input) {
  return letAs<Map>(input)?.map((final k, final v) {
    return MapEntry(k?.toString(), v);
  }).nullsRemoved();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

bool isNullable<T>() => null is T;
bool typeEquality<T1, T2>() => T1 == T2;

extension GenericTypeOnIterable<T> on Iterable<T> {
  Type get genericType => T;
}

extension GenericTypeOnMap<K, V> on Map<K, V> {
  Type get genericTypeKey => K;
  Type get genericTypeValue => V;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to `T` if possible. Returns `null` if not possible.
T? let<T>(dynamic input) {
  if (input == null) return null;
  if (T == input.runtimeType) return input as T;
  final t = T.toString();
  if (typeEquality<T, int>() || typeEquality<T, int?>()) {
    return letInt(input) as T?;
  }
  if (typeEquality<T, double>() || typeEquality<T, double?>()) {
    return letInt(input) as T?;
  }
  if (typeEquality<T, bool>() || typeEquality<T, bool?>()) {
    return letInt(input) as T?;
  }
  if (typeEquality<T, String>() || typeEquality<T, String?>()) {
    return letString(input) as T?;
  }
  // if (t.startsWith("Map<")) {
  //   return _letMap(input) as T?;
  // }
  // if (t.startsWith("Set<")) {
  //   return letSet(input) as T?;
  // }
  // if (t.startsWith("List<")) {
  //   return letList(input) as T?;
  // }
  if (typeEquality<T, DateTime>() || typeEquality<T, DateTime?>()) {
    return letDateTime(input) as T?;
  }
  return tryCast<T>(input);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Tries to cast [input] to `T` if possible. Returns `null` if not possible.
T? tryCast<T>(dynamic input) {
  try {
    return input as T;
  } catch (_) {
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to an `bool` if possible. Returns `null` if not possible.
bool? letBool(dynamic input) {
  if (input == null) return null;
  switch (input.runtimeType) {
    case bool:
      return input;
    case int:
      return input == 1;
    case double:
      return input == 1.0;
  }
  if (input is String) {
    final a = double.tryParse(input);
    return a != null ? a == 1.0 : input.toLowerCase() == "true";
  }
  return null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to an `int` if possible. Returns `null` if not possible.
int? letInt(dynamic input) {
  if (input == null) return null;
  switch (input.runtimeType) {
    case int:
      return input;
    case double:
      return (input as double).round();
    case bool:
      return input ? 1 : 0;
  }
  if (input is String) {
    return double.tryParse(input)?.round();
  }
  if (input is DateTime) {
    return input.microsecondsSinceEpoch;
  }
  return input.hashCode;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to a `double` if possible. Returns `null` if not possible.
double? letDouble(dynamic input) {
  if (input == null) return null;
  switch (input.runtimeType) {
    case double:
      return input;
    case int:
      return (input as int).toDouble();
    case bool:
      return input ? 1.0 : 0.0;
  }
  if (input is String) {
    return double.tryParse(input);
  }
  if (input is DateTime) {
    return input.microsecondsSinceEpoch.toDouble();
  }
  return input.hashCode.toDouble();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to a `String` if possible. Returns `null` if not possible.
String? letString(dynamic input) {
  if (input == null) return null;
  if (input is String) return input;
  if (input is DateTime) return input.toIso8601String();
  return input.toString();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// TODO: Potentially dangerous. Needs further testing.
/// Converts any [input] to a `Map` if possible. Returns `null` if not possible.
// Map<T1, T2>? letMap<T1, T2>(dynamic input) {
//   if (input == null) return null;
//   if (input is String) {
//     try {
//       return letMap<T1, T2>(jsonDecode(input) as Map);
//     } catch (_) {
//       assert(false, "letMap cannot convert ${input.runtimeType} to Map (1)");
//       return null;
//     }
//   }
//   if (input is Map) {
//     try {
//       final a = input.map((final key, final value) {
//         return MapEntry<T1?, T2?>(let<T1>(key), let<T2>(value));
//       });
//       return nullFilterableMap<T1, T2>(a);
//     } catch (_) {
//       assert(false, "letMap cannot convert ${input.runtimeType} to Map (2)");
//       return null;
//     }
//   }
//   return null;
// }

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to a `Set` if possible. Returns `null` if not possible.
Set<T>? letSet<T>(dynamic input) {
  if (input == null) {
    if (null is T) return {null}.cast();
    return null;
  }
  if (input is Set || input is List) {
    try {
      return nullFilterableSet<T>(input.map((final l) => let<T>(l)));
    } catch (_) {
      assert(false, "letSet cannot convert ${input.runtimeType} to Set (1)");
    }
  }
  if (input is String) {
    try {
      return input.split(",").map((final l) => let<T>(l.trim())).toSet().cast<T>();
    } catch (_) {
      assert(false, "letSet cannot convert ${input.runtimeType} to Set (2)");
      return null;
    }
  }
  return letSet<T>({input});
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to a `List` if possible. Returns `null` if not possible.
List<T>? letList<T>(dynamic input) {
  if (input == null) {
    if (null is T) return [null].cast();
    return null;
  }
  if (input is List || input is Set) {
    try {
      return nullFilterableList<T>(input.map((final l) => let<T>(l)));
    } catch (_) {
      assert(false, "letList cannot convert ${input.runtimeType} to List (1)");
    }
  }
  if (input is String) {
    try {
      return input.split(",").map((final l) => let<T>(l.trim())).toList().cast<T>();
    } catch (_) {
      assert(false, "letList cannot convert ${input.runtimeType} to List (2)");
      return null;
    }
  }
  return letList<T>([input]);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to a `DateTime` if possible. Returns `null` if not possible.
DateTime? letDateTime(
  dynamic input, {
  final stringFormat = LetDateTimeStringFormat.MMDDYYYY,
}) {
  if (input == null) return null;
  if (input is DateTime) return input;
  switch (input.runtimeType) {
    case int:
      return DateTime.fromMicrosecondsSinceEpoch(input);
    case double:
      return DateTime.fromMicrosecondsSinceEpoch((input as double).round());
  }
  if (input is String) {
    final result = DateTime.tryParse(input);
    if (result != null) return result;
    final a = input.split(RegExp(r"[^0-9]+")).map((final l) => int.tryParse(l)).toList();
    if (!a.contains(null)) {
      int? year, month, day, hour, minute, second, millisecond, microsecond;
      final length = a.length;
      switch (stringFormat) {
        case LetDateTimeStringFormat.MMDDYYYY:
          if (length > 0) month = a[0];
          if (length > 1) day = a[1];
          if (length > 2) year = a[2];
          break;
        case LetDateTimeStringFormat.DDMMYYYY:
          if (length > 0) day = a[0];
          if (length > 1) month = a[1];
          if (length > 2) year = a[2];
          break;
        case LetDateTimeStringFormat.YYYYMMDD:
          if (length > 0) year = a[0];
          if (length > 1) month = a[1];
          if (length > 2) day = a[2];
          break;
      }
      if (length > 3) hour = a[3];
      if (length > 4) minute = a[4];
      if (length > 5) second = a[5];
      if (length > 6) millisecond = a[6];
      if (length > 7) microsecond = a[7];
      return DateTime(
        year ?? 1970,
        month ?? 1,
        day ?? 1,
        hour ?? 0,
        minute ?? 0,
        second ?? 0,
        millisecond ?? 0,
        microsecond ?? 0,
      );
    }
  }
  return null;
}

enum LetDateTimeStringFormat {
  MMDDYYYY,
  DDMMYYYY,
  YYYYMMDD,
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts [input] to a Map with non-null keys and values if `T1` and `T2` are
/// non-null respectively.
Map<T1, T2> nullFilterableMap<T1, T2>(Map input) {
  final filtered = input.entries.toList()
    ..retainWhere((final l) => (null is T1 || l.key != null) && (null is T2 || l.value != null));
  final mapped = filtered.map((final l) => MapEntry<T1, T2>(l.key, l.value));
  final result = Map.fromEntries(mapped);
  return result;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts [input] to a List with non-null elements if `T` is non-null.
List<T> nullFilterableList<T>(Iterable input) {
  final filtered = input.toList()..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts [input] to a Set with non-null elements if `T` is non-null.
Set<T> nullFilterableSet<T>(Iterable input) {
  final filtered = input.toSet()..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
void test() {
  [
    "letBool",
    letBool(null),
    letBool(true),
    letBool(false),
    letBool("true"),
    letBool("false"),
    letBool("1"),
    letBool(DateTime.now()),
    "\nletInt",
    letInt(null),
    letInt(1),
    letInt(1.6),
    letInt(true),
    letInt("1.6"),
    letInt(DateTime.now()),
    "\nletDouble",
    letDouble(null),
    letDouble(1),
    letDouble(1.6),
    letDouble(true),
    letDouble("1.6"),
    letDouble(DateTime.now()),
    "\nletString",
    letString(null),
    letString("Hello"),
    letString(DateTime.now()),
    "\nletMap",
    letMap(null),
    letMap("Hello"),
    letMap<String, int>('{"hello": "0", "world": 1}').runtimeType,
    letMap<String, int>({"hello": "0", "world": 1}).runtimeType,
    letMap<String, bool>({"hello": "0", "world": 1}),
    letMap<String, DateTime>({"hello": DateTime.now(), "world": "1/7/1990"}),
    letMap<String, DateTime>({"hello": DateTime.now(), "world": null}),
    "\nletList",
    letList<String>(null),
    letList<String?>(null),
    letList<String?>(1),
    letList<String>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letList<String?>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letList<int>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letList<DateTime>([1, false, "3/3/2003", DateTime.now(), null, 4, null, 4]),
    "\nletSet",
    letSet<String>(null),
    letSet<String?>(null),
    letSet<String?>(1),
    letSet<String>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letSet<String?>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letSet<int>([1, false, "3", DateTime.now(), null, 4, null, 4]),
    letSet<DateTime>([1, false, "3/3/2003", DateTime.now(), null, 4, null, 4]),
    "\nletDateTime",
    letDateTime(null),
    letDateTime(DateTime.now().microsecondsSinceEpoch),
    letDateTime(DateTime.now().microsecondsSinceEpoch.toDouble()),
    letDateTime(DateTime.now()),
    letDateTime(DateTime.now().toIso8601String()),
    letDateTime(DateTime.now().toString()),
    letDateTime("1/2/2003", stringFormat: LetDateTimeStringFormat.MMDDYYYY),
    letDateTime("2/1/2003", stringFormat: LetDateTimeStringFormat.DDMMYYYY),
    letDateTime("2003/2/1", stringFormat: LetDateTimeStringFormat.YYYYMMDD),
  ].forEach((final l) {
    print(l);
  });
}
*/