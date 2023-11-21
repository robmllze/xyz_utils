//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:convert';
import 'dart:core';

import 'data.dart';
import '../time/parse_duration.dart';

part '_timestamp.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// DateTime, Duration [_Timestamp], String, int, num, double, bool, Uri
T? let<T>(dynamic input) {
  try {
    if (T == dynamic) return input;
    if (input == null && T != Null) return null;
    if (T == input.runtimeType) return input as T;
    if (typeEquality<T, double>() || typeEquality<T, double?>()) {
      return letDouble(input) as T;
    } else if (typeEquality<T, int>() || typeEquality<T, int?>()) {
      return letInt(input) as T;
    } else if (typeEquality<T, num>() || typeEquality<T, num?>()) {
      return letNum(input) as T;
    } else if (typeEquality<T, bool>() || typeEquality<T, bool?>()) {
      return letBool(input) as T;
    } else if (typeEquality<T, DateTime>() || typeEquality<T, DateTime?>()) {
      return letDateTime(input) as T;
    } else if (typeEquality<T, _Timestamp>() || typeEquality<T, _Timestamp?>()) {
      return letTimestamp(input) as T;
    } else if (typeEquality<T, Duration>() || typeEquality<T, Duration?>()) {
      return letDuration(input) as T;
    } else if (typeEquality<T, Uri>() || typeEquality<T, Uri?>()) {
      return letUri(input) as T;
    } else if (typeEquality<T, String>() || typeEquality<T, String?>()) {
      return input?.toString() as T;
    }
    return input as T;
  } catch (_) {}
  return null;
}

/// Converts the [input] to a [num] type if possible, or returns null if the
/// conversion cannot be performed.
num? letNum(dynamic input) {
  if (input is num) return input;
  if (input is String) {
    final trimmed = input.trim();
    return num.tryParse(trimmed) ?? trimmed.tryParseDuration()?.inMilliseconds;
  }
  if (input is Duration) return input.inMilliseconds;
  if (input is DateTime) return input.millisecondsSinceEpoch;
  if (input is bool) return input ? 1 : 0;
  try {
    // Assume input is a Timestamp (from Firestore package).
    return input.millisecondsSinceEpoch;
  } catch (_) {}
  return null;
}

/// Converts the [input] to aa [int] type if possible, or returns null if the
/// conversion cannot be performed.
int? letInt(dynamic input) {
  return letNum(input)?.toInt();
}

/// Converts the [input] to a [double] type if possible, or returns null if the
/// conversion cannot be performed.
double? letDouble(dynamic input) {
  return letNum(input)?.toDouble();
}

/// Converts the [input] to a [bool] type if possible, or returns null if the
/// conversion cannot be performed.
bool? letBool(dynamic input) {
  if (input is bool) return input;
  if (input is num) return input == 1;
  if (input is String) return input.trim().toLowerCase() == "true";
  return null;
}

/// Converts the [input] to a [Uri] type if possible, or returns null if the
/// conversion cannot be performed.
Uri? letUri(dynamic input) {
  if (input is Uri) return input;
  if (input is String) return Uri.tryParse(input.trim());
  return null;
}

/// Converts the [input] to a [DateTime] type if possible, or returns null if
/// the conversion cannot be performed.
DateTime? letDateTime(dynamic input) {
  if (input is DateTime) {
    return input;
  }
  if (input is String) {
    return DateTime.tryParse(input);
  }
  if (input is Duration) {
    return DateTime.fromMillisecondsSinceEpoch(input.inMilliseconds);
  }
  if (input is _Timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(input.millisecondsSinceEpoch);
  }
  if (input is int) {
    return DateTime.fromMillisecondsSinceEpoch(input);
  }
  if (input is num) {
    return DateTime.fromMillisecondsSinceEpoch(input.round());
  }
  return null;
}

/// Converts the [input] to a [_Timestamp] type if possible, or returns null if
/// the conversion cannot be performed.
_Timestamp? letTimestamp(dynamic input) {
  if (input is DateTime) {
    return _Timestamp.fromMillisecondsSinceEpoch(input.millisecondsSinceEpoch);
  }
  if (input is int) {
    return _Timestamp.fromMillisecondsSinceEpoch(input);
  }
  if (input is Duration) {
    return _Timestamp.fromMillisecondsSinceEpoch(input.inMilliseconds);
  }
  if (input is String) {
    final date = DateTime.tryParse(input.trim());
    if (date != null) {
      return _Timestamp.fromDate(date);
    }
  }
  if (input is num) {
    return _Timestamp.fromMillisecondsSinceEpoch(input.round());
  }
  try {
    // Assume input is a Timestamp (from Firestore package).
    return _Timestamp.fromMillisecondsSinceEpoch(input.millisecondsSinceEpoch);
  } catch (_) {}
  return null;
}

/// Converts the [input] to a [Duration] type if possible, or returns null if
/// the conversion cannot be performed.
Duration? letDuration(dynamic input) {
  if (input is Duration) {
    return input;
  }
  if (input is int) {
    return Duration(milliseconds: input);
  }
  if (input is DateTime) {
    return Duration(milliseconds: input.millisecondsSinceEpoch);
  }
  if (input is String) {
    return input.tryParseDuration();
  }
  if (input is num) {
    return Duration(milliseconds: input.round());
  }
  try {
    // Assume input is a Timestamp (from Firestore package).
    return Duration(milliseconds: input.millisecondsSinceEpoch);
  } catch (_) {}
  return null;
}

/// Converts the [input] to a [Map] type if possible, or returns null if the
/// conversion cannot be performed.
Map<K, V>? letMap<K, V>(
  dynamic input, {
  bool filterNulls = false,
  V? nullFallback,
}) {
  return MapConverter<K, V>().convert(
    input,
    filterNulls: filterNulls,
    nullFallback: nullFallback,
  );
}

/// Converts the [input] to an [Iterable] type if possible, or returns null if the
/// conversion cannot be performed.
Iterable<T>? letIterable<T>(
  dynamic input, {
  bool filterNulls = false,
  T? nullFallback,
}) {
  return IterableConverter<T>().convert(
    input,
    filterNulls: filterNulls,
    nullFallback: nullFallback,
  );
}

/// Converts the [input] to a [List] type if possible, or returns null if the
/// conversion cannot be performed.
List<T>? letList<T>(
  dynamic input, {
  bool filterNulls = false,
  T? nullFallback,
}) {
  return IterableConverter<T>()
      .convert(
        input,
        filterNulls: filterNulls,
        nullFallback: nullFallback,
      )
      ?.toList();
}

/// Converts the [input] to a [Set] type if possible, or returns null if the
/// conversion cannot be performed.
Set<T>? letSet<T>(
  dynamic input, {
  bool filterNulls = false,
  T? nullFallback,
}) {
  return IterableConverter<T>()
      .convert(
        input,
        filterNulls: filterNulls,
        nullFallback: nullFallback,
      )
      ?.toSet();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class MapConverter<K, V> extends _Converter<Map<K, V>> {
  const MapConverter();
  @override
  Map<K, V>? convert(
    dynamic input, {
    bool filterNulls = false,
    dynamic nullFallback,
  }) {
    dynamic decoded;
    try {
      if (input is String) {
        final trimmed = input.trim();
        if (trimmed.isEmpty) return const {};
        decoded = const JsonDecoder().convert(trimmed);
      } else {
        decoded = input;
      }
      if (decoded is Map) {
        final temp = decoded.entries
            .map((final entry) {
              final convertedKey = let<K>(entry.key);
              final convertedValue = let<V>(entry.value) ?? let<V?>(nullFallback);
              if (filterNulls) {
                if (!isNullable<K>() && convertedKey == null) return const _Empty();
                if (!isNullable<V>() && convertedValue == null) return const _Empty();
              }
              return MapEntry(convertedKey as K, convertedValue as V);
            })
            .where((final e) => e != const _Empty())
            .map((final e) => e as MapEntry<K, V>);
        return Map.fromEntries(temp.nonNulls);
      }
    } catch (_) {}
    return null;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class IterableConverter<V> extends _Converter<Iterable<V>> {
  @override
  Iterable<V>? convert(
    dynamic input, {
    bool filterNulls = false,
    dynamic nullFallback,
  }) {
    final nullable = isNullable<V>();
    if (!nullable && input == null) return null;
    dynamic decoded;
    if (input is String) {
      decoded = commaSeparatedStringToIterable(input);
    } else {
      decoded = input;
    }
    if (decoded is Iterable) {
      try {
        final a = decoded.map((final element) {
          final result = let<V>(element) ?? let<V>(nullFallback);
          if (filterNulls) {
            if (!nullable && result == null) {
              return const _Empty();
            }
          }
          return result;
        });
        final b = a.where((final e) => e != const _Empty());
        var c = b.map((final e) => e as V);
        if (filterNulls) {
          c = c.where((final e) => e != null);
        }
        return c;
      } catch (_) {}
    }
    return [input];
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Iterable<String> commaSeparatedStringToIterable(
  String input, [
  String separator = ",",
]) {
  var temp = input.trim();
  if (temp.isEmpty) return const [];
  if (temp.length > 1 &&
      ((temp.startsWith("[") && temp.endsWith("]")) ||
          (temp.startsWith("{") && temp.endsWith("}")) ||
          (temp.startsWith("(") && temp.endsWith(")")))) {
    temp = temp.substring(1, temp.length - 1);
  }
  return temp.split(",").map((final e) => e.trim());
}

class _Empty {
  const _Empty();
}

T? letAs<T>(dynamic input) => input is T ? input : null;

Map<String, dynamic>? letJMap(dynamic input) {
  return letAs<Map>(input)?.map((final k, final v) {
    return MapEntry(k?.toString(), v);
  }).nonNulls;
}

bool isNullable<T>() => null is T;

bool typeEquality<T1, T2>() => T1 == T2;

extension GenericTypeOnIterable<T> on Iterable<T> {
  Type get genericType => T;
}

extension GenericTypeOnMap<K, V> on Map<K, V> {
  Type get genericTypeKey => K;
  Type get genericTypeValue => V;
}

abstract class _Converter<T> {
  const _Converter();
  T? convert(dynamic input, {bool filterNulls = false, dynamic nullFallback});
}

/// Tries to cast [input] to `T` if possible. Returns `null` if not possible.
T? tryCast<T>(dynamic input) {
  try {
    return input as T;
  } catch (_) {
    return null;
  }
}

/// Converts [input] to a Map with non-null keys and values if `T1` and `T2` are
/// non-null respectively.
Map<T1, T2> nullFilteredMap<T1, T2>(Map input) {
  final filtered = input.entries.toList()
    ..retainWhere((final l) => (null is T1 || l.key != null) && (null is T2 || l.value != null));
  final mapped = filtered.map((final l) => MapEntry<T1, T2>(l.key, l.value));
  final result = Map.fromEntries(mapped);
  return result;
}

/// Converts [input] to a List with non-null elements if `T` is non-null.
List<T> nullFilteredList<T>(Iterable input) {
  final filtered = input.toList()..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}

/// Converts [input] to a Set with non-null elements if `T` is non-null.
Set<T> nullFilteredSet<T>(Iterable input) {
  final filtered = input.toSet()..retainWhere((final l) => (null is T || l != null));
  return filtered.cast();
}
