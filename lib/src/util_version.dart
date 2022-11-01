// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

class Version {
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

  factory Version.fromString(String raw) {
    final parts = raw.split(RegExp("[.+]"));
    int p(i) => i < parts.length ? int.tryParse(parts[i]) ?? 0 : 0;
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

  Version change({
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

  @override
  String toString() => "${this.major}.${this.minor}.${this.patch}+${this.build}";
}
