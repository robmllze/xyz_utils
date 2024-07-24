//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the path of the `lib` directory of [package] or `null` if the
/// package is not found.
Future<String?> getPackageLibPath(String package) async {
  final packageUri = Uri.parse('package:$package/');
  final pathUri = await Isolate.resolvePackageUri(packageUri);
  if (pathUri == null) return null;
  var path = Uri.decodeFull(pathUri.path);

  // On Windows, adjust the path format.
  if (Platform.isWindows) {
    // Regular expression to match patterns like /CC:
    final driveLetterPattern = RegExp(r'^[/\\][A-Za-z]+:');
    if (driveLetterPattern.hasMatch(path)) {
      path = path.substring(1);
    }
    path = path.replaceAll('/', '\\');
  }
  return path;
}
