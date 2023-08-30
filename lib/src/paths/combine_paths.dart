// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'package:path/path.dart' as p;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

Set<String> combinePaths(List<Set<String>> pathSets) {
  // Filter out empty sets.
  pathSets = pathSets.where((set) => set.isNotEmpty).toList();

  if (pathSets.isEmpty) return {};

  // Base case: If there's only one set, return it.
  if (pathSets.length == 1) return pathSets[0];

  // Join the first two sets and replace them with their joined set, then recursively call this function.
  final firstSet = pathSets[0];
  final secondSet = pathSets[1];
  final joinedSet = <String>{};

  for (final path1 in firstSet) {
    for (final path2 in secondSet) {
      if (path2.isEmpty) {
        joinedSet.add(path1);
      } else if (path1.isEmpty) {
        joinedSet.add(path2);
      } else {
        joinedSet.add(p.join(path1, path2));
      }
    }
  }

  // Replace the first two sets in the list with their joined set.
  return combinePaths([joinedSet, ...pathSets.skip(2)]);
}
