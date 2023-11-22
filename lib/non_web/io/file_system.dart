//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:io';
import 'package:path/path.dart' as p;

import '/io.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<String?> readFile(String filePath) async {
  try {
    final file = File(toLocalPathFormat(filePath));
    final data = await file.readAsString();
    return data;
  } catch (_) {
    return null;
  }
}

Future<void> writeFile(
  String filePath,
  String content, {
  bool append = false,
}) async {
  final file = File(toLocalPathFormat(filePath));
  await file.parent.create(recursive: true); // ensure the parent directory exists
  await file.writeAsString(
    content,
    mode: append ? FileMode.append : FileMode.write,
  );
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> clearFile(String filePath) async {
  final file = File(toLocalPathFormat(filePath));
  await file.writeAsString("");
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> deleteFile(String filePath) async {
  final file = File(toLocalPathFormat(filePath));
  await file.delete();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<bool> fileExists(String filePath) {
  return File(toLocalPathFormat(filePath)).exists();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<File?> findFileByName(String fileName, String directoryPath) async {
  final directory = Directory(directoryPath);

  // Check if the directory exists.
  if (!await directory.exists()) return null;

  // Get a list of all files and directories in the directory.
  final entities = directory.listSync(recursive: true);

  // Iterate over the entities and look for the file by name.
  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('/$fileName')) {
      return entity;
    }
  }

  // File not found.
  return null;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

String getDesktopPath() {
  try {
    if (Platform.isMacOS) {
      return p.join("Users", Platform.environment["USER"]!, "Desktop");
    } else if (Platform.isWindows) {
      return p.join(Platform.environment["USERPROFILE"]!, "Desktop");
    } else if (Platform.isLinux) {
      return p.join("home", Platform.environment["USER"]!, "Desktop");
    } else {
      throw false;
    }
  } catch (_) {
    throw UnsupportedError("Unsupported platform");
  }
}
