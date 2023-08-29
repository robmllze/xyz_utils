// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'dart:io';

import '../UNSORTED.dart';
import 'non_web.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> generateFromTemplates({
  required String rootDirPath,
  required FutureOr<void> Function(String, Map<String, String>) generateForFile,
  required Set<String> templateFilePaths,
  String begType = "",
  Set<String> pathPatterns = const {},
  bool deleteGeneratedFiles = false,
  void Function(String filePath)? onDelete,
}) async {
  if (deleteGeneratedFiles) {
    await deleteGeneratedDartFiles(
      rootDirPath,
      pathPatterns: pathPatterns,
      onDelete: onDelete,
    );
  }
  final templates = <String, String>{};
  for (final templateFilePath in templateFilePaths) {
    templates[templateFilePath] = await readDartTemplate(templateFilePath);
  }
  final results = await findDartFiles(
    rootDirPath,
    (_ /*final dirName*/, __ /*final folderName*/, final filePath) {
      final a = isMatchingFileName(filePath, begType, "dart").$1;
      final b = isSourceDartFilePath(filePath);
      if (a && b) {
        return true;
      }
      return false;
    },
    pathPatterns,
  );
  for (final result in results) {
    // final dirName = result.$1;
    // final folderName = result.$2;
    final filePath = result.$3;
    await generateForFile(filePath, templates);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Deletes all the .g.dart files form [dirPath] and its sub-directories if
/// [dirPath] contains any of the [pathPatterns].
Future<void> deleteGeneratedDartFiles(
  String dirPath, {
  Set<String> pathPatterns = const {},
  void Function(String filePath)? onDelete,
}) async {
  final filePaths = await listFilePaths(dirPath);
  if (filePaths != null) {
    for (final filePath in filePaths) {
      await deleteGeneratedDartFile(
        filePath,
        onDelete,
        pathPatterns,
      );
    }
  }
}

Future<void> deleteGeneratedDartFile(
  String filePath, [
  void Function(String filePath)? onDelete,
  Set<String> pathPatterns = const {},
]) async {
  if (isGeneratedDartFilePath(filePath, pathPatterns)) {
    await deleteFile(filePath);
    onDelete?.call(filePath);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<bool> sourceAndGeneratedDartFileExists(
  String filePath, [
  Set<String> pathPatterns = const {},
]) async {
  if (isSourceDartFilePath(filePath, pathPatterns)) {
    final a = await fileExists(filePath);
    final b = await fileExists("${filePath.substring(0, filePath.length - ".dart".length)}.g.dart");
    return a && b;
  }
  if (isGeneratedDartFilePath(filePath, pathPatterns)) {
    final a = await fileExists(filePath);
    final b = await fileExists("${filePath.substring(0, filePath.length - ".g.dart".length)}.dart");
    return a && b;
  }
  return false;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<List<(String, String, String)>> findDartFiles(
  String rootDirPath,
  FutureOr<bool> Function(
    String dirPath,
    String folderName,
    String filePath,
  ) onFileFound, [
  Set<String> pathPatterns = const {},
]) async {
  final results = <(String, String, String)>[];
  final filePaths = await listFilePaths(rootDirPath);
  if (filePaths != null) {
    filePaths.sort();
    for (final filePath in filePaths) {
      if (isSourceDartFilePath(filePath, pathPatterns)) {
        final dirPath = getDirPath(filePath);
        final folderName = getBaseName(dirPath);
        final add = await onFileFound(dirPath, folderName, filePath);
        if (add) {
          results.add((dirPath, folderName, filePath));
        }
      }
    }
  }
  return results;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<String> readDartTemplate(String filePath) async {
  final file = File(filePath);
  final input = await file.readAsString();
  final output = input.replaceFirst("````dart", "").replaceLast("````", "").trim();
  return output;
}
