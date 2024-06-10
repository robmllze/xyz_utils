//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

library;

import 'dart:math';

part 'src/_calculate_best_center.dart';
part 'src/_calculate_geometric_center.dart';
part 'src/_calculate_havershire_3d_distance.dart';
part 'src/_calculate_zoom_to_fit.dart';
part 'src/_distance_unit.dart';
part 'src/_sphere_radius.dart';
part 'src/_t_location.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final class LocationUtilsPackage {
  //
  //
  //

  static LocationUtilsPackage? _instance;

  const LocationUtilsPackage._();

  /// The singleton instance of this package.
  LocationUtilsPackage get instance => LocationUtilsPackage();

  /// The singleton instance of this package.
  factory LocationUtilsPackage() {
    return _instance ??= const LocationUtilsPackage._();
  }

  //
  //
  //

  // These static consts allows us to completely contain the package within the
  // LocationUtilsPackage class. This means that the package can be imported
  // without polluting the global namespace.

  /// The distance unit of miles.
  static const DISTANCE_MILES = LocationUtilsPackageDistanceUnit.MILES;

  /// The distance unit of kilometres.
  static const DISTANCE_KILOMETRES =
      LocationUtilsPackageDistanceUnit.KILOMETRES;

  /// The distance unit of metres.
  static const DISTANCE_METRES = LocationUtilsPackageDistanceUnit.METRES;

  /// The distance unit of nautical miles.
  static const DISTANCE_NAUTICAL_MILES =
      LocationUtilsPackageDistanceUnit.NAUTICAL_MILES;

  /// The distance unit of feet.
  static const DISTANCE_FEET = LocationUtilsPackageDistanceUnit.FEET;

  /// The distance unit of yards.
  static const DISTANCE_YARDS = LocationUtilsPackageDistanceUnit.YARDS;

  /// The distance unit of astronomical units.
  static const DISTANCE_ASTRONOMICAL_UNITS =
      LocationUtilsPackageDistanceUnit.ASTRONOMICAL_UNITS;

  /// The radius of the Earth.
  static const RADIUS_EARTH = LocationUtilsPackageRadius.EARTH;

  /// The radius of the Moon.
  static const RADIUS_EARTH_MOON = LocationUtilsPackageRadius.EARTH_MOON;

  /// The radius of Mars.
  static const RADIUS_MARS = LocationUtilsPackageRadius.MARS;
}
