//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the path of the package's `lib` directory or `null` if the package
/// is not found.
Future<String?> getPackageLibPath(String packageName) async {
  final packageUri = Uri.parse("package:$packageName/");
  final pathUri = await Isolate.resolvePackageUri(packageUri);
  if (pathUri == null) return null;
  var path = pathUri.path;
  // On Windows, adjust the path format.
  if (Platform.isWindows) {
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    path = path.replaceAll('/', '\\');
  }
  return path;
}
