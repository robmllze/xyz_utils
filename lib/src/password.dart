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
  final length = garbage.length;

  // Check that the length of the garbage list is greater than 1.
  assert(length > 1);
  final half = length ~/ 2;

  // Choose a random range for the subset of garbage to use for the password.
  final range = Random(seed).nextInt(half) + half; // half >= range <= garbage length
  final subset = garbage.sublist(0, range);

  // Map the subset to hashCodes.
  final hashCodes = subset.map((final element) => element.hashCode).toList();

  // Encode the hashCodes using a deterministic formula.
  final encoded = hashCodes
      .map((final code) => (Random(seed).nextInt(range) * code * seed * length) % range)
      .toList();

  // Convert the character codes to a string to obtain the final password.
  final password = String.fromCharCodes(encoded);
  return password;
}
