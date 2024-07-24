//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Copyright Ⓒ Robert Mollentze
//
// Licensing details can be found in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

extension ParseDurationOnStringExtension on String {
  //
  //
  //

  /// Tries to parse the string as a duration in the format `HH:MM:SS.SSS`.
  Duration? tryParseDuration() {
    final a = this.split(':');
    if (a.length != 3) return null;
    final b = a[2].split('.');
    if (b.length != 2) return null;
    final c = [...a.sublist(0, 2), ...b];
    if (c.length != 4) return null;
    final hours = int.tryParse(c[0]);
    if (hours == null) return null;
    final minutes = int.tryParse(c[1]);
    if (minutes == null) return null;
    final seconds = int.tryParse(c[2]);
    if (seconds == null) return null;
    final microseconds = int.tryParse(c[3]);
    if (microseconds == null) return null;
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );
  }

  //
  //
  //

  /// Parses the string as a duration in the format `HH:MM:SS.SSS`.
  Duration parseDuration() {
    final duration = this.tryParseDuration();
    if (duration == null) {
      throw ArgumentError('Invalid duration string: $this');
    }

    return duration;
  }
}
