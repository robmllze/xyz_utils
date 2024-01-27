//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension ToTrimmedOrNullExtension on Object {
  /// Converts the input to a string and trims it or returns `null` if the
  /// result is empty.
  String? toTrimmedOrNull() {
    return trimmedOrNull(this);
  }
}

/// Converts the input to a string if it's not null and trims it or returns
/// `null` if the result is empty.
String? trimmedOrNull(Object? input) {
  final a = input?.toString().trim();
  final b = a?.isEmpty == true ? null : a;
  return b;
}
