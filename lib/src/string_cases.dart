// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

extension StringCases on String {
  //
  //
  //

  String toSnakeCase() {
    final expression = RegExp(r"(?<=[a-z])[A-Z0-9]");
    final result = this.replaceAllMapped(expression, (final l) {
      return ("_${l.group(0)}");
    }).toLowerCase();
    return result;
  }

  //
  //
  //

  String toCamelCase() {
    final expression = RegExp(r"([_])[a-zA-Z0-9]");
    final result = this.replaceAllMapped(expression, (final l) {
      return "${l.group(0)?[1].toUpperCase()}";
    });
    return result;
  }

  //
  //
  //

  String capitalize() {
    if (this.isEmpty) return this;
    var result = this[0].toUpperCase();
    if (this.length > 1) result += this.substring(1);
    return result;
  }

  //
  //
  //

  String toCamelCaseCapitalized() {
    return this.toCamelCase().capitalize();
  }

  //
  //
  //

  String lineToLength(int length) {
    return (this.length > length ? "${this.substring(0, length).trim()}..." : this);
  }

  //
  //
  //

  String paragraphToLength(int length) {
    return this.lineToLength(length).replaceAll("\n", " ");
  }
}
