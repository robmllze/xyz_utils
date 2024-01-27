//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

const int _kThousand = 1000;
const int _kMillion = 1000000;
const int _kBillion = 1000000000;

void _check(bool expr, String name, int value) {
  if (!expr) {
    throw ArgumentError('Timestamp $name out of range: $value');
  }
}

/// A Timestamp represents a point in time independent of any time zone or calendar,
/// represented as seconds and fractions of seconds at nanosecond resolution in UTC
/// Epoch time. It is encoded using the Proleptic Gregorian Calendar which extends
/// the Gregorian calendar backwards to year one. It is encoded assuming all minutes
/// are 60 seconds long, i.e. leap seconds are "smeared" so that no leap second table
/// is needed for interpretation. Range is from 0001-01-01T00:00:00Z to
/// 9999-12-31T23:59:59.999999999Z. By restricting to that range, we ensure that we
/// can convert to and from RFC 3339 date strings.
///
/// For more information, see [the reference timestamp definition](https://github.com/google/protobuf/blob/master/src/google/protobuf/timestamp.proto)

class FirestoreTimestamp implements Comparable<FirestoreTimestamp> {
  /// Creates a [FirestoreTimestamp]
  FirestoreTimestamp(this._seconds, this._nanoseconds) {
    _validateRange(_seconds, _nanoseconds);
  }

  /// Create a [FirestoreTimestamp] fromMillisecondsSinceEpoch
  factory FirestoreTimestamp.fromMillisecondsSinceEpoch(int milliseconds) {
    var seconds = (milliseconds / _kThousand).floor();
    final nanoseconds = (milliseconds - seconds * _kThousand) * _kMillion;
    return FirestoreTimestamp(seconds, nanoseconds);
  }

  /// Create a [FirestoreTimestamp] fromMicrosecondsSinceEpoch
  factory FirestoreTimestamp.fromMicrosecondsSinceEpoch(int microseconds) {
    final seconds = microseconds ~/ _kMillion;
    final nanoseconds = (microseconds - seconds * _kMillion) * _kThousand;
    return FirestoreTimestamp(seconds, nanoseconds);
  }

  /// Create a [FirestoreTimestamp] from [DateTime] instance
  factory FirestoreTimestamp.fromDate(DateTime date) {
    return FirestoreTimestamp.fromMicrosecondsSinceEpoch(
      date.microsecondsSinceEpoch,
    );
  }

  // ignore: unused_element
  /// Create a [FirestoreTimestamp] from [DateTime].now()
  factory FirestoreTimestamp.now() {
    return FirestoreTimestamp.fromMicrosecondsSinceEpoch(
      DateTime.now().microsecondsSinceEpoch,
    );
  }

  final int _seconds;
  final int _nanoseconds;

  static const int _kStartOfTime = -62135596800;
  static const int _kEndOfTime = 253402300800;

  // ignore: public_member_api_docs
  int get seconds => _seconds;

  // ignore: public_member_api_docs
  int get nanoseconds => _nanoseconds;

  // ignore: public_member_api_docs
  int get millisecondsSinceEpoch =>
      seconds * _kThousand + nanoseconds ~/ _kMillion;

  // ignore: public_member_api_docs
  int get microsecondsSinceEpoch =>
      seconds * _kMillion + nanoseconds ~/ _kThousand;

  /// Converts [FirestoreTimestamp] to [DateTime]
  DateTime toDate() {
    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }

  @override
  int get hashCode => Object.hash(seconds, nanoseconds);

  @override
  bool operator ==(Object other) =>
      other is FirestoreTimestamp &&
      other.seconds == seconds &&
      other.nanoseconds == nanoseconds;

  @override
  int compareTo(FirestoreTimestamp other) {
    if (seconds == other.seconds) {
      return nanoseconds.compareTo(other.nanoseconds);
    }

    return seconds.compareTo(other.seconds);
  }

  @override
  String toString() {
    return 'Timestamp(seconds=$seconds, nanoseconds=$nanoseconds)';
  }

  static void _validateRange(int seconds, int nanoseconds) {
    _check(nanoseconds >= 0, 'nanoseconds', nanoseconds);
    _check(nanoseconds < _kBillion, 'nanoseconds', nanoseconds);
    _check(seconds >= _kStartOfTime, 'seconds', seconds);
    _check(seconds < _kEndOfTime, 'seconds', seconds);
  }
}