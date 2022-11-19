// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:convert';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

T? letAs<T>(dynamic input) {
  return input is T ? input : null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Converts any [input] to `T` if possible. Returns `null` if not possible.
T? let<T>(dynamic input) {
  if (input == null) return null;
  if (T == input.runtimeType) return input as T;
  final t = T.toString();
  if (T == int || t == "int?") {
    return letInt(input) as T?;
  }
  if (T == double || t == "double?") {
    return letInt(input) as T?;
  }
  if (T == bool || t == "bool?") {
    return letInt(input) as T?;
  }
  if (T == String || t == "String?") {
    return letString(input) as T?;
  }
  if (T == Map || (t == "Map?" || (t.startsWith("Map<") && t.endsWith("?")))) {
    return letMap(input) as T?;
  }
  if (T == Set || (t == "Set?" || (t.startsWith("Set<") && t.endsWith("?")))) {
    return letSet(input) as T?;
  }
  if (T == List || (t == "List?" || (t.startsWith("List<") && t.endsWith("?")))) {
    return letList(input) as T?;
  }
  if (T == DateTime || t == "DateTime?") {
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

/// Converts any [input] to a `Map` if possible. Returns `null` if not possible.
Map<T1, T2>? letMap<T1, T2>(dynamic input) {
  if (input == null) return null;
  if (input is String) {
    try {
      return letMap<T1, T2>(jsonDecode(input) as Map);
    } catch (_) {
      assert(false, "letMap cannot convert ${input.runtimeType} to Map (1)");
      return null;
    }
  }
  if (input is Map) {
    try {
      final a = input.map((final key, final value) {
        return MapEntry<T1?, T2?>(let<T1>(key), let<T2>(value));
      });
      return nullFilterableMap<T1, T2>(a);
    } catch (_) {
      assert(false, "letMap cannot convert ${input.runtimeType} to Map (2)");
      return null;
    }
  }
  return null;
}

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
    case double:
      return DateTime.fromMicrosecondsSinceEpoch((input as double).round());
    case int:
      return DateTime.fromMicrosecondsSinceEpoch(input);
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