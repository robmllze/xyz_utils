//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

final dynamic iterable = _VarArgsFunction<Iterable>((args1, args2) {
  return args1.skip(0).followedBy(args2.values);
});

/// **Example:**
/// ```dart
/// final List a = list(1, 2, 3, 4, /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// [1, 2, 3, 4]
/// ```
final dynamic list = _VarArgsFunction<List>((args1, args2) {
  return List.from(args1.skip(0).followedBy(args2.values));
});

/// **Example:**
/// ```dart
/// final Set a = set(1, 2, 3, 4, /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// {1, 2, 3, 4}
/// ```
final dynamic set = _VarArgsFunction<Set>((args1, args2) {
  return Set.from(args1.skip(0).followedBy(args2.values));
});

/// **Example:**
/// ```dart
/// final Map a = map(1, 2, x: "x-axis", y: "y-axis", /* etc. */);
/// print(a);
/// ```
/// **Output:**
/// ```bash
/// {0: 1, 1: 2, x: x-axis, y: y-axis}
/// ```
final dynamic map = _VarArgsFunction<Map>((args1, args2) {
  var n = 0;
  final l1 = args1.map((final value) => MapEntry<dynamic, dynamic>(n++, value));
  final l2 = args2.entries;
  return Map.fromEntries(l1.followedBy(l2));
});

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

typedef _VarArgsCallback<T> = T Function(List<dynamic>, Map<String, dynamic>);

class _VarArgsFunction<T> {
  //
  //
  //

  static const _OFFSET = 'Symbol("'.length;

  //
  //
  //

  final _VarArgsCallback<T> callback;

  //
  //
  //

  _VarArgsFunction(this.callback);

  //
  //
  //

  T call() => callback([], {});

  //
  //
  //

  @override
  T noSuchMethod(Invocation inv) {
    return callback(
      inv.positionalArguments,
      inv.namedArguments.map(
        (k, v) {
          final keyAsString = k.toString();
          return MapEntry(
              keyAsString.substring(_OFFSET, keyAsString.length - 2), v);
        },
      ),
    );
  }
}