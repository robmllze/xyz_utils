//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~


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