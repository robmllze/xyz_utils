// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// UTILS
//
// By Robert Mollentze / @robmllze (2021)
//
// Please see LICENSE file.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension Norm on num {
  T norm<T>(final num upper) => this - (this / upper).floor() * upper as T;
  T normRange<T>(final num lower, final num upper) =>
      lower + (this - lower).norm(upper - lower) as T;
  T normDelta<T>(final num upper, final num delta) =>
      (this + delta) - ((this + delta) / upper).floor() * upper as T;
  T normNext<T>(final num upper) => normDelta(upper, 1);
  T normPrev<T>(final num upper) => normDelta(upper, -1);
  T normRangeDelta<T>(final num lower, final num upper, final num delta) =>
      (this + delta).normRange(lower, upper);
  T normRangeNext<T>(final num lower, final num upper) => normRangeDelta(lower, upper, 1);
  T normRangePrev<T>(final num lower, final num upper) => normRangeDelta(lower, upper, -1);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Combines two hashCode values.
/// Reference: https://stackoverflow.com/questions/26648628/dart-is-xoring-two-hashcodes-always-going-to-return-a-new-unique-hashcode
int combineHashCodes(final int hash, final int value) {
  var h = 0x1fffffff & (hash + value);
  h = 0x1fffffff & (h + ((0x0007ffff & h) << 10));
  return h ^ (h >> 6);
}
