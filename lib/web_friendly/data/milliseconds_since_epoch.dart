//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class MillisecondsSinceEpoch {
  //
  //
  //

  final int value;

  //
  //
  //

  const MillisecondsSinceEpoch(this.value);

  //
  //
  //

  MillisecondsSinceEpoch.fromDateTime(DateTime dateTime) : value = dateTime.millisecondsSinceEpoch;

  //
  //
  //

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(value);

  //
  //
  //

  @override
  String toString() => this.dateTime.toString();
}
