// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// MAPPING
//
// Contains functions that map integers to other integers (exclusively) in
// creative ways. It's useful for encryption.
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'format.dart' show roundAt;

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

double basically(final double x) => roundAt(x, 10000000);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP SWAP
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). Uses Swap method. To unmap (J -> I),
/// just use [mapSwap] again.
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative.
///
/// **Example 1:**
///
/// If [i] equals `0, 1, 2, 3, 4 or 5` where [end] = 5,
///
/// then returns  `1, 0, 3, 2, 5 or 4` respectively.
///
/// **Example 2:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5 or 6` where [end] = 6,
///
/// then returns  `1, 0, 3, 2, 5, 4 or 6` respectively.
///
/// **Example 3:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6 or 7` where [end] = 7,
///
/// then returns  `1, 0, 3, 2, 5, 4, 7 or 6` respectively.
///
/// **Example 4:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6, 7 or 8` where [end] = 8,
///
/// then returns  `1, 0, 3, 2, 5, 4, 7, 6 or 8` respectively.
int mapSwap(
  final int i,
  final int end,
) {
  assert(end >= 0);
  assert(end >= i);
  assert(i >= 0);
  return (i & 1 == 1) ? (i == end ? end - 1 : i - 1) : (i == end ? end + 0 : i + 1);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP FLIP
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (inclusive). Uses Flip method. To unmap (J -> I),
/// just use [mapFlip] again.
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative. To maximise speed, there is no input validation either.
///
/// **Example:**
///
/// If [i] equals `0, 1, 2, 3, 4 or 5` where [end] = 5,
///
/// then returns  `5, 4, 3, 2, 1 or 0` respectively.
int mapFlip(
  final int i,
  final int end,
) {
  assert(end >= 0);
  assert(end >= i);
  assert(i >= 0);
  return end - i;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP REVERSE 1
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). Uses Reverse method. To unmap (J -> I),
/// just use [mapReverse2] again.
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative.
///
/// **Example 1:**
///
/// If [i] equals `12, 345, 678, 91011, 121314, or 151617`
///
/// then returns  `21, 543, 876, 11019, 413121, or 716151` respectively.
///
/// **Example 2:**
///
/// If [i] equals `0, 10, 100, 1000, 11, 101, 111 or 12300`
///
/// then returns  `0, 10, 100, 1000, 11, 101, 111 or 12300` respectively.
///
/// **Example 1:**
///
/// If [i] equals `1, 2, 3, 4, 5, 6, 7 or 8`
///
/// then returns  `1, 2, 3, 4, 5, 6, 7 or 8` respectively.
int mapReverse1(final int i) {
  assert(i >= 0);
  // Make sure 10, 100, 1000, etc. don't all map to 1 but instead to -10, -100,
  // -1000, etc.
  double test = i.toDouble();
  while (test > 10) {
    test /= 10;
  }
  if (test == 10.0) {
    return i;
  }
  // Get the reverse using strings.
  final s = String.fromCharCodes(i.toString().codeUnits.reversed);
  // If [i] ends with a 0, return [i], otherwise return the reverse. Numbers
  // ending with 0 can only map to themselves, e.g. 20, 2020, 20020, etc.
  if (s.startsWith("0")) {
    return i;
  } else {
    return int.parse(s);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP REVERSE 2 (SLOWER)
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). Uses Reverse method. To unmap (J -> I),
/// just use [mapReverse2] again.
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative. Also, [mapReverse2] does the same as [mapReverse1] but is
/// slightly slower so don't use this one. This one ist just cooler under the
/// hood.
///
/// **Example 1:**
///
/// If [i] equals `12, 345, 678, 91011, 121314, or 151617`
///
/// then returns  `21, 543, 876, 11019, 413121, or 716151` respectively.
///
/// **Example 2:**
///
/// If [i] equals `0, 10, 100, 1000, 11, 101, 111 or 12300`
///
/// then returns  `0, 10, 100, 1000, 11, 101, 111 or 12300` respectively.
///
/// **Example 1:**
///
/// If [i] equals `1, 2, 3, 4, 5, 6, 7 or 8`
///
/// then returns  `1, 2, 3, 4, 5, 6, 7 or 8` respectively.
int mapReverse2(final int i) {
  assert(i >= 0);
  // STEP 1:
  // 10, 100, 1000, etc. can only map to themselves.
  double c = i.toDouble();
  while (c > 10.0) {
    c /= 10.0;
  }
  if (c == 10.0) {
    return i;
  }
  // STEP 2:
  // Find maxmum weight, e.g. 123 -> 100, 1234 -> 1000, 12345 -> 10000, etc.
  double w = 1;
  while (i / w >= 10) {
    w *= 10;
  }
  // STEP 3:
  // Check if [i] ends with a 0. Numbers ending in 0 can only map to
  // themselves, e.g. 20, 2020, 20020, etc.
  // Place decimal one position to the left
  c = i / 10;
  // Get digit after decimal point multiplied by 10.
  c = 10 * (c % 1);
  // Ensure there's no rounding error that can corrupt output.
  c = basically(c).truncateToDouble();
  // Return [i] if last digit is 0.
  if (c == 0) return i;
  // STEP 4:
  // Perform first cycle.
  double sum = 0;
  sum += w * c;
  w /= 10;
  // STEP 5:
  // Perform all other cycles.
  double p = 100;
  while (true) {
    // Place decimal p positions to the left.
    c = i / p;
    // Get digit after decimal point multiplied by 10.
    c = 10 * (c % 1);
    // Ensure there's no rounding error that can corrupt output.
    c = basically(c).truncateToDouble();
    // Multiply weight w with coefficient c and add to sum.
    sum += w * c;
    // Update weight for next cycle.
    w /= 10;
    if (w < 1) break;
    // Update p for next cycle.
    p *= 10;
  }

  return sum.floor();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP REVERSE TEST
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/*
const int end = 10000000;
bool ok = true;
// Test that [mapReverse1] and [mapReverse2] always return the same result.
for (int i = 0; i <= end; i++) {
  if (mapReverse1(i) != mapReverse2(i)) {
    ok = false;
    print("i = ${i}");
  }
}
print("Same Result Test: ${ok == true ? "Success" : "Failure"}");
// Test that [mapReverse1] is reversible.
ok = true;
for (int i = 0; i <= end; i++) {
  int x = mapReverse1(i);
  x = mapReverse1(x);
  if (x != i) {
    ok = false;
    print("i = ${i}");
    print("i = ${x}");
    break;
  }
}
print("Reversibility Test 1: ${ok == true ? "Success" : "Failure"}");
// Test that [mapReverse2] is reversible.
ok = true;
for (int i = 0; i <= end; i++) {
  int x = mapReverse2(i);
  x = mapReverse2(x);
  if (x != i) {
    ok = false;
    print("i = ${i}");
    print("i = ${x}");
    break;
  }
}
print("Reversibility Test 2: ${ok == true ? "Success" : "Failure"}");
 */

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP ODD-EVEN
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). Uses Odd-even method. To unmap (J -> I),
/// use [unmapOddEven].
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative. To maximise speed, there is no input validation either.
///
/// **Example 1:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5 or 6` where [end] = 6,
///
/// then returns  `1, 3, 5, 0, 2, 4 or 6` respectively.
///
/// **Example 2:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6 or 7` where [end] = 7,
///
/// then returns  `1, 3, 5, 7, 0, 2, 4 or 6` respectively.
///
/// **Example 3:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6, 7 or 8` where [end] = 8,
///
/// then returns  `1, 3, 5, 7, 0, 2, 4, 6 or 8` respectively.
///
/// **Example 4:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6, 7, 8 or 9` where [end] = 9,
///
/// then returns  `1, 3, 5, 7, 9, 0, 2, 4, 6 or 8` respectively.
///
/// **Implementations:**
///
/// *Method Odd-even Incremental:*
///
/// `1, 3, 5, 7, 9, 0, 2, 4, 6, 8, 10`
///
/// `mapOddEven(i, end)`
///
/// *Method Odd-even Decremental:*
///
/// `9, 7, 5, 3, 1, 10, 8, 6, 4, 2, 0`
///
/// `mapFlip(mapOddEven(i, end), end)`
///
/// *Method Even-odd Incremental:*
///
/// `0, 2, 4, 6, 8, 10, 1, 3, 5, 7, 9`
///
/// `mapFlip(mapOddEven(mapFlip(i, end), end), end)`
///
/// *Method Even-odd Decremental:*
///
/// `10, 8, 6, 4, 2, 0, 9, 7, 5, 3, 1`
///
/// `mapOddEven(mapFlip(i, end), end)`
int mapOddEven(
  final int i,
  final int end,
) {
  assert(end >= 0);
  assert(end >= i);
  assert(i >= 0);
  // [jOdd] is an odd number by index [i]
  // `jOdd(i) = 1 + i * 2`
  // `jOdd(0) = 1, odd(1) = 3, odd(2) = 5, etc.`
  int jOdd = i * 2 + 1;
  if (jOdd <= end) {
    return jOdd;
  } // If jOdd > end:
  else {
    // `i * 2` is an even number by index [i].
    // If end is even `even - end` must be returned.
    // But if end is uneven `even - end - 1` must be returned.
    return i * 2 - end - (end & 1 != 1 ? 0 : 1);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// UNMAP ODD-EVEN
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (J -> I) Unmaps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). basicallyUp, it's the reverse
/// of [mapOddEven].
///
/// Note: No support for negative integers implemented so [j] and [end] must be
/// positive integers.
int unmapOddEven(
  final int j,
  final int end,
) {
  assert(end >= 0);
  assert(end >= j);
  assert(j >= 0);
  // Inspect `I(j) = j ~/ 2.0` (~/ divides and truncates).
  // I(j) represents the odd or even index of a number and [j] is the number in
  // the sequence.
  // It's the reverse of `i * 2` and `i * 2 + 1`.
  //
  // When [j] is odd: `I(1) = 0, I(3) = 1, I(5) = 2, I(j) = ...`
  // `I(j)` must be returned since all the odd numbers are all in the first
  // half of the sequence.
  //
  // And...
  //
  // When [j] is even: `I(0) = 0, I(2) = 1, I(4) = 2, I(j) = ...`
  // `I(j) + end / 2.0).ceil()` must be returned since all the even number are
  // all in the second half of the sequence.
  return (j ~/ 2.0) + (j & 1 == 1 ? 0 : (end / 2.0).ceil());
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP FORWARD
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). Uses a Forward method. To unmap (J -> I),
/// use [unmapForward].
///
/// Note: No support for negative integers implemented so [i] and [end] must
/// not be begative.
///
/// **Example 1:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5 or 6` where [end] = 6,
///
/// then returns  `0, 4, 1, 5, 2, 6 or 3` respectively.
///
/// **Example 1:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6 or 7` where [end] = 7,
///
/// then returns  `0, 4, 1, 5, 2, 6, 3 or 7` respectively.
///
/// **Example 3:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6, 7 or 8` where [end] = 8,
///
/// then returns  `0, 5, 1, 6, 2, 7, 3, 8 or 4` respectively.
///
/// **Example 4:**
///
/// If [i] equals `0, 1, 2, 3, 4, 5, 6, 7, 8 or 9` where [end] = 9,
///
/// then returns  `0, 5, 1, 6, 2, 7, 3, 8, 4 or 9` respectively.
///
/// **Implementations:**
///
/// *Method Forward:*
///
/// `Forward(i, end)`
///
/// *Method Backward:*
///
/// `mapFlip(Forward(i, end), end)`
int mapForward(
  final int i,
  final int end,
) {
  assert(end >= 0);
  assert(end >= i);
  assert(i >= 0);
  // 1. If [i] is even, return `i / 2.0` (reverse of `i * 2.0` that represents an
  // even number of index [i]).
  // 2. If [i] is odd return `i ~/ 2.0 + end ~/ 2.0 + 1`.
  // Where `end ~/ 2.0 + 1` represents the number at the first odd index i.e.
  // where [i] = 1.
  return (i & 1 != 1) ? (i ~/ 2.0) : (i ~/ 2.0 + end ~/ 2.0 + 1);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// UNMAP FORWARD
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (J -> I) Unmaps an integer in range 0-[end] (incl.) exclusively  to another
/// integer in range 0-[end] (incl.). basicallyUp, it's the reverse of
/// [mapForward].
///
/// Note: No support for negative integers implemented so [j] and [end] must
/// not be begative.
int unmapForward(
  final int j,
  final int end,
) {
  assert(end >= 0);
  assert(end >= j);
  assert(j >= 0);
  // `end ~/ 2.0 + 1` is the number at the first odd index i.e. where [i] = 1.
  // 1. `I[j] = j * 2` is the index of number j where j < j1.
  // 2. `I[j] = (j - j1) * 2 + 1` is the index of number j where j >= j1.
  int j1 = end ~/ 2.0 + 1;
  return (j < j1) ? j * 2 : (j - j1) * 2 + 1;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP SHUFFLE
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). To unmap (J -> I), use [unmapShuffle].
///
/// Note: [i] and [end] and [shuffle] must not be begative.
int mapShuffle(
  final int i,
  final int end, [
  final int shuffle = 10,
]) {
  int x = end - i;
  x = mapSwap(x, end);
  x = mapFlip(x, end);
  for (int n = 0; n < shuffle; n++) {
    x = mapForward(x, end);
    x = mapOddEven(x, end);
    x = mapOddEven(x, end);
  }
  return x;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// UNMAP SHUFFLE
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (J -> I) Unmaps an integer in range 0-[end] (incl.) exclusively  to another
/// integer in range 0-[end] (incl.). Basically, it's the reverse of
/// [mapShuffle1].
///
/// Note: [i] and [end] and [shuffle] must not be begative.
int unmapShuffle(
  final int i,
  final int end, [
  final int shuffle = 10,
]) {
  int x = end - i;
  for (int n = 0; n < shuffle; n++) {
    x = unmapOddEven(x, end);
    x = unmapOddEven(x, end);
    x = unmapForward(x, end);
  }
  x = mapFlip(x, end);
  x = mapSwap(x, end);
  return x;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// MAP SHUFFLE REVERSE
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (I -> J) Maps an integer in range 0-[end] (incl.) exclusively to another
/// integer in range 0-[end] (incl.). To unmap (J -> I), use
/// [unmapShuffleReverse].
///
/// Note: [i] and [end] and [shuffle] must not be begative.
int mapShuffleReverse(
  final int i,
  final int end, [
  final int shuffle = 10,
]) {
  return mapReverse1(mapShuffle(i, end, shuffle));
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// UNMAP SHUFFLE REVERSE
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// (J -> I) Unmaps an integer in range 0-[end] (incl.) exclusively  to another
/// integer in range 0-[end] (incl.). Basically, it's the reverse of
/// [mapShuffleReverse].
///
/// Note: [i] and [end] and [shuffle] must not be begative.
int unmapShuffleReverse(
  final int i,
  final int end, [
  final int shuffle = 10,
]) {
  return unmapShuffle(mapReverse1(i), end, shuffle);
}
