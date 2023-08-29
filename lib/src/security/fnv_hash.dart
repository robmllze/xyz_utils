// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:typed_data';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Calculates the FNV-1a hash value for the given input string.
int fnvHash(String input) {
  final data = Uint8List.fromList(input.codeUnits);
  final length = data.length;
  var hash = 0;
  for (var n = 0; n < length; n++) {
    var code = data[n];
    // Apply the FNV-1a algorithm to update the hash value.
    hash = ((hash << 5) - hash) + code;
    // Convert the hash value to a 32-bit integer using bitwise AND.
    hash = hash & hash;
  }
  // Ensure the hash value is positive by masking out the sign bit.
  return hash & 0x7fffffff;
}
