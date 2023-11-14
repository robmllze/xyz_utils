//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:math' show Random;

/// Generates a deterministic password based on the provided input values.
///
/// The length of the generated password may be anywhere between half of the
/// length [garbage] (inclusive) and the length of [garbage] (exclusive).
///
/// Therefore, the length of [garbage] must be 2 or greater.
///
/// The [seed] is used for deterministic randomness. This may be any positive
/// or negative integer.
///
/// The values of the character codes of the generated password will be between
/// 0 (inclusive) and [charCodeRange] (exclusive).
///
/// Therefore, [charCodeRange] must be greater than 0.
String generateDeterministicPassword(
  List<Object?> garbage,
  int seed, [
  int charCodeRange = 256,
]) {
  // Check that the range of the character codes is greater than 0.
  assert(charCodeRange > 0);

  // Check that the length of the garbage list is greater than 0.
  final length = garbage.length;
  assert(length > 1);
  final half = length ~/ 2;

  // Create a random number generator with the provided seed.
  final random = Random(seed);

  // Choose a random range for the subset of garbage to use for the password.
  final range = random.nextInt(half) + half; // half >= range <= garbage length
  final subset = garbage.sublist(0, range);

  // Map the subset to hashCodes.
  final hashCodes = subset.map((final element) => element.hashCode).toList();

  // Encode the hashCodes using a deterministic formula.
  final encoded = hashCodes
      .map((final code) => (random.nextInt(range) * code * seed * length) % charCodeRange)
      .toList();

  // Convert the character codes to a string to obtain the final password.
  final password = String.fromCharCodes(encoded);
  return password;
}
