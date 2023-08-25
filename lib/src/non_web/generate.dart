// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Gen
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:io';

import '../UNSORTED.dart';
import 'non_web.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> generateFromTemplates({
  required String rootDirPath,
  required Future<void> Function(String, Map<String, String>) generateForFiles,
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
  await findDartFiles(
    rootDirPath: rootDirPath,
    pathPatterns: pathPatterns,
    onFileFound: (final dirName, final folderName, final filePath) async {
      final a = isMatchingFileName(filePath, begType, "dart").$1;
      final b = isSourceDartFilePath(filePath);
      if (a && b) {
        await generateForFiles(filePath, templates);
      }
    },
  );
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
      final a = pathPatterns.isEmpty || pathContainsPatterns(filePath, pathPatterns);
      final b = isGeneratedDartFilePath(filePath);
      final c = a && b;
      if (c) {
        await deleteFile(filePath);
        onDelete?.call(filePath);
      }
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<bool> sourceAndGeneratedDartFileExists(String filePath) async {
  if (isSourceDartFilePath(filePath)) {
    final a = await fileExists(filePath);
    final b = await fileExists("${filePath.substring(0, filePath.length - ".dart".length)}.g.dart");
    return a && b;
  }
  if (isGeneratedDartFilePath(filePath)) {
    final a = await fileExists(filePath);
    final b = await fileExists("${filePath.substring(0, filePath.length - ".g.dart".length)}.dart");
    return a && b;
  }
  return false;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> findDartFiles({
  required String rootDirPath,
  Set<String> pathPatterns = const {},
  required Future<void> Function(
    String dirName,
    String folderName,
    String filePath,
  ) onFileFound,
}) async {
  final filePaths = await listFilePaths(rootDirPath);
  if (filePaths != null) {
    filePaths.sort();
    for (final filePath in filePaths) {
      if (isSourceDartFilePath(filePath)) {
        final dirName = getDirPath(filePath);
        final folderName = getFileName(dirName);
        final a = pathPatterns.isEmpty || pathContainsPatterns(filePath, pathPatterns);
        if (a) {
          await onFileFound(dirName, folderName, filePath);
        }
      }
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<String> readDartTemplate(String filePath) async {
  final file = File(filePath);
  final input = await file.readAsString();
  final output = input.replaceFirst("````dart", "").replaceLast("````", "").trim();
  return output;
}
