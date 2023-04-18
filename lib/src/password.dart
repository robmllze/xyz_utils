// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:math' show Random;

/// Generates a deterministic password based on the provided input values.
String generateDeterministicPassword(
  List<Object?> garbage,
  int seed, [
  int range = 256,
]) {
  final encodedList = garbage.map((final element) {
    return Random(element.hashCode).nextInt(range);
  }).toList();
  final decodedList = encodedList.map((final code) => (code - seed) % range).toList();
  final password = String.fromCharCodes(decodedList);
  return password;
}
