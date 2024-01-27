//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class Version {
  //
  //
  //

  /// Compares two versions formatted <MAJOR.MINOR.PATCH+BUILD>, e.g. 0.1.2+3.
  /// Returns 1 if version1 is higher, -1 if version2 is higher, 0 if both are
  /// equal.
  static int compareVersionsMMPB(Version version1, Version version2) {
    final v1 = version1.components;
    final v2 = version2.components;
    for (var i = 0; i < 4; i++) {
      if (v1[i] > v2[i]) {
        return 1; // version1 is higher
      } else if (v1[i] < v2[i]) {
        return -1; // version2 is higher
      }
    }
    return 0; // both versions are equal
  }

  //
  //
  //

  final int major, minor, patch, build;

  //
  //
  //

  const Version({
    this.major = 0,
    this.minor = 0,
    this.patch = 0,
    this.build = 0,
  });

  //
  //
  //

  factory Version.parse(String input) {
    final components = input.split(RegExp(r"[\.\+]"));
    int p(i) => i < components.length ? (int.tryParse(components[i]) ?? 0) : 0;
    return Version(
      major: p(0),
      minor: p(1),
      patch: p(2),
      build: p(3),
    );
  }

  //
  //
  //

  /// Changes the version by the given amounts.
  Version change({
    int? major,
    int? minor,
    int? patch,
    int? build,
  }) {
    return Version(
      major: major ?? this.major,
      minor: minor ?? this.minor,
      patch: patch ?? this.patch,
      build: build ?? this.build,
    );
  }

  //
  //
  //

  /// Increases the version by the given amounts.
  Version increase({
    int major = 0,
    int minor = 0,
    int patch = 0,
    int build = 0,
  }) {
    return Version(
      major: this.major + major,
      minor: this.minor + minor,
      patch: this.patch + patch,
      build: this.build + build,
    );
  }

  //
  //
  //

  /// Decreases the version by the given amounts.
  Version decrease({
    int major = 0,
    int minor = 0,
    int patch = 0,
    int build = 0,
  }) {
    return Version(
      major: this.major - major,
      minor: this.minor - minor,
      patch: this.patch - patch,
      build: this.build - build,
    );
  }

  //
  //
  //

  /// Returns the version components as a list.
  List<int> get components => [this.major, this.minor, this.patch, this.build];

  //
  //
  //

  /// Returns true if this version is higher than the given version.
  bool isHigherThan(Version other) => this._compareTo(other) == 1;

  /// Returns true if this version is lower than the given version.
  bool isLowerThan(Version other) => this._compareTo(other) == -1;

  /// Returns true if this version is equal to the given version.
  bool isEqualTo(Version other) => this._compareTo(other) == 0;

  //
  //
  //

  int _compareTo(Version other) => compareVersionsMMPB(this, other);

  //
  //
  //

  @override
  int get hashCode => this.toString().hashCode;

  //
  //
  //

  @override
  bool operator ==(Object other) =>
      other is Version ? this.isEqualTo(other) : false;

  //
  //
  //

  @override
  String toString() =>
      "${this.major}.${this.minor}.${this.patch}+${this.build}";
}