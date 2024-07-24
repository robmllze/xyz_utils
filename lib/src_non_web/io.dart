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

import 'dart:io';
import 'package:path/path.dart' as p;

import '/xyz_utils.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Reads the contents of the file located at [filePath] as a String.
Future<String?> readFile(String filePath) async {
  try {
    final localSystemFilePath = toLocalSystemPathFormat(filePath);
    final file = File(localSystemFilePath);
    final data = await file.readAsString();
    return data;
  } catch (_) {
    return null;
  }
}

/// Reads the contents of the file located at [filePath] as a list of lines.
Future<List<String>?> readFileAsLines(String filePath) async {
  try {
    final localSystemFilePath = toLocalSystemPathFormat(filePath);
    final file = File(localSystemFilePath);
    final lines = await file.readAsLines();
    return lines;
  } catch (_) {
    return null;
  }
}

/// Writes the given [content] to the file located at [filePath]. Set [append]
/// to `true` to append the [content] to the file instead of overwriting it.
Future<void> writeFile(
  String filePath,
  String content, {
  bool append = false,
}) async {
  final localSystemFilePath = toLocalSystemPathFormat(filePath);
  final file = File(localSystemFilePath);
  await file.parent.create(recursive: true);
  await file.writeAsString(
    content,
    mode: append ? FileMode.append : FileMode.write,
  );
}

/// Clears the contents of the file located at [filePath].
Future<void> clearFile(String filePath) async {
  final localSystemFilePath = toLocalSystemPathFormat(filePath);
  final file = File(localSystemFilePath);
  await file.writeAsString('');
}

/// Deletes the file located at [filePath].
Future<void> deleteFile(String filePath) async {
  final localSystemFilePath = toLocalSystemPathFormat(filePath);
  final file = File(localSystemFilePath);
  await file.delete();
}

/// Returns `true` if the file located at [filePath] exists.
Future<bool> fileExists(String filePath) {
  final localSystemFilePath = toLocalSystemPathFormat(filePath);
  final file = File(localSystemFilePath);
  return file.exists();
}

/// Finds a file with the given [fileName] in the directory located at
/// [directoryPath]. Returns `null` if the directory does not exist or if the
Future<File?> findFileByName(String fileName, String directoryPath) async {
  final directory = Directory(directoryPath);
  if (!await directory.exists()) return null;
  final entities = directory.listSync(recursive: true);
  for (final entity in entities) {
    if (entity is File && entity.path.endsWith('/$fileName')) {
      return entity;
    }
  }
  return null;
}

/// Lists the file paths of the files in the directory located at [dirPath].
/// Set [recursive] to `true` to list the file paths of the files in
/// the sub-directories as well.
Future<List<String>?> listFilePaths(
  String dirPath, {
  bool recursive = true,
}) async {
  final localSystemDirPath = toLocalSystemPathFormat(dirPath);
  final dir = Directory(localSystemDirPath);
  final filePaths = <String>[];
  if (await dir.exists()) {
    final entities = dir.listSync(recursive: recursive);
    for (final entity in entities) {
      if (entity is File) {
        filePaths.add(entity.path);
      }
    }
  } else {
    return null;
  }
  return filePaths;
}

/// Gets the current Operating System's Desktop path.
String getDesktopPath() {
  try {
    if (Platform.isMacOS) {
      return p.join('Users', Platform.environment['USER']!, 'Desktop');
    } else if (Platform.isWindows) {
      return p.join(Platform.environment['USERPROFILE']!, 'Desktop');
    } else if (Platform.isLinux) {
      return p.join('home', Platform.environment['USER']!, 'Desktop');
    } else {
      throw false;
    }
  } catch (_) {
    throw UnsupportedError('Unsupported platform');
  }
}
