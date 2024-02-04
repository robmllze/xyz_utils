//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:path/path.dart' as p;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Returns the base name of a given file path.
String getBaseName(String path) => p.basename(toLocalPathFormat(path));

/// Returns the directory path of a given file path.
String getDirPath(String path) => p.dirname(toLocalPathFormat(path));

/// Checks if the provided path contains any of the specified components.
bool pathContainsComponent(String path, Set<String> components) {
  final fixedPath = toLocalPathFormat(path);
  final a = p.split(fixedPath);
  for (final component in components) {
    if (a.contains(component.toLowerCase())) {
      return true;
    }
  }
  return false;
}

/// Checks if the provided path matches any of the specified path patterns.
bool matchesAnyPathPattern(String path, Set<String> pathPatterns) {
  if (pathPatterns.isNotEmpty) {
    final fixedPath = toLocalPathFormat(path);
    for (final pattern in pathPatterns) {
      if (RegExp(pattern).hasMatch(fixedPath)) return true;
    }
    return false;
  }
  return true;
}

/// Converts the given path to a consistent, local path format.
String getFileNameWithoutExtension(String filePath) {
  return p.basenameWithoutExtension(toLocalPathFormat(filePath));
}

/// Converts the given path to a consistent, local path format.
String toLocalPathFormat(String path) {
  return path.split(RegExp(r"[\\/]")).join(p.separator).toLowerCase();
}

/// Checks if the provided file is a private Dart file (starts with an
/// underscore).
bool isPrivateFileName(String filePath) {
  final fileName = getBaseName(filePath);
  return fileName.startsWith("_");
}

/// Checks if the file name matches the specified beginning and ending types.
/// Returns a tuple with the match status and the file name.
(bool, String) isMatchingFileName(
  String filePath,
  String begType,
  String endType,
) {
  final fileName = getBaseName(filePath);
  final a = begType.isEmpty ? true : fileName.startsWith("${begType.toLowerCase()}_");
  final b = endType.isEmpty ? true : fileName.endsWith(".$endType".toLowerCase());
  final c = a && b;
  return (c, fileName);
}

/// Combines multiple [pathSets] into a single set, returning all possible
/// combinations.
///
/// Note: This function is recursive and works by joining the first two sets and
/// then combining the resulting set with the next set, until all sets are
/// processed.
///
/// Example:
/// ```dart
/// final pathSets = [
///   {"path1", "path2"},
///   {"segmentA", "segmentB"},
///   {"end1", "end2"},
/// ];
/// final combinedPaths = combineSets(pathSets);
/// print(combinedPaths);
/// ```
///
/// Output:
/// ```
/// {path1/segmentA/end1, path1/segmentA/end2, path1/segmentB/end1, path1/segmentB/end2, path2/segmentA/end1, path2/segmentA/end2, path2/segmentB/end1, path2/segmentB/end2}
/// ```
Set<String> combinePathSets(List<Set<String>> pathSets) {
  late Set<String> output;
  final input = List.of(pathSets).where((e) => e.isNotEmpty).toList();
  if (input.isEmpty) {
    output = {};
  } else if (input.length == 1) {
    output = input[0];
  } else {
    final first = input[0];
    final second = input[1];
    final joined = <String>{};
    for (final a in first) {
      for (final b in second) {
        if (b.isEmpty) {
          joined.add(a);
        } else if (a.isEmpty) {
          joined.add(b);
        } else {
          joined.add(p.join(a, b));
        }
      }
    }
    output = combinePathSets([
      joined,
      ...input.skip(2),
    ]);
  }
  return output.map((e) => e.toLowerCase()).toSet();
}
