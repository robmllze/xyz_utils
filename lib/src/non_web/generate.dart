// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';

import '/xyz_utils_non_web.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Future<void> generateFromTemplates({
  String? fallbackDartSdkPath,
  required Set<String> rootPaths,
  Set<String> subPaths = const {},
  required Future<void> Function(
    AnalysisContextCollection collection,
    String filePath,
    Map<String, String> templates,
  ) generateForFile,
  required Set<String> templateFilePaths,
  String begType = "",
  Set<String> pathPatterns = const {},
  bool deleteGeneratedFiles = false,
  void Function(String filePath)? onDelete,
}) async {
  final combinedPaths = combinePaths([rootPaths, subPaths]);
  final collection = await createCollection(
    combinedPaths,
    fallbackDartSdkPath,
  );
  for (final path in combinedPaths) {
    if (deleteGeneratedFiles) {
      await deleteGeneratedDartFiles(
        path,
        onDelete: onDelete,
        pathPatterns: pathPatterns,
      );
    }
    final templates = <String, String>{};
    for (final templateFilePath in templateFilePaths) {
      templates[templateFilePath] = await readDartTemplate(templateFilePath);
    }
    final results = await findDartFiles(
      path,
      pathPatterns: pathPatterns,
      onFileFound: (final dirName, final folderName, final filePath) {
        final a = isMatchingFileName(filePath, begType, "dart").$1;
        final b = isSourceDartFilePath(filePath);
        if (a && b) {
          return true;
        }
        return false;
      },
    );
    for (final result in results) {
      final filePath = result.$3;
      await generateForFile(collection, filePath, templates);
    }
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Deletes all the .g.dart files form [dirPath] and its sub-directories if
/// [dirPath] contains any of the [pathPatterns].
Future<void> deleteGeneratedDartFiles(
  String dirPath, {
  void Function(String filePath)? onDelete,
  Set<String> pathPatterns = const {},
}) async {
  final filePaths = await listFilePaths(dirPath);
  if (filePaths != null) {
    for (final filePath in filePaths) {
      await deleteGeneratedDartFile(
        filePath,
        onDelete: onDelete,
        pathPatterns: pathPatterns,
      );
    }
  }
}

Future<void> deleteGeneratedDartFile(
  String filePath, {
  void Function(String filePath)? onDelete,
  Set<String> pathPatterns = const {},
}) async {
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
  String rootDirPath, {
  Set<String> pathPatterns = const {},
  FutureOr<bool> Function(
    String dirPath,
    String folderName,
    String filePath,
  )? onFileFound,
}) async {
  final results = <(String, String, String)>[];
  final filePaths = await listFilePaths(rootDirPath);
  if (filePaths != null) {
    filePaths.sort();
    for (final filePath in filePaths) {
      if (isSourceDartFilePath(filePath, pathPatterns)) {
        final dirPath = getDirPath(filePath);
        final folderName = getBaseName(dirPath);
        final add = (await onFileFound?.call(dirPath, folderName, filePath)) ?? true;
        if (add) {
          results.add((dirPath, folderName, filePath));
        }
      }
    }
  }
  return results;
}

Future<List<(String, String, String)>> findGeneratedDartFiles(
  String rootDirPath, {
  Set<String> pathPatterns = const {},
  FutureOr<bool> Function(
    String dirPath,
    String folderName,
    String filePath,
  )? onFileFound,
}) async {
  final results = <(String, String, String)>[];
  final filePaths = await listFilePaths(rootDirPath);
  if (filePaths != null) {
    filePaths.sort();
    for (final filePath in filePaths) {
      if (isGeneratedDartFilePath(filePath, pathPatterns)) {
        final dirPath = getDirPath(filePath);
        final folderName = getBaseName(dirPath);
        final add = (await onFileFound?.call(dirPath, folderName, filePath)) ?? true;
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
