//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'celestial_radius.dart';
import 'distance_unit.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

final class LocationUtils {
  //
  //
  //

  static LocationUtils? _instance;

  const LocationUtils._();

  /// The singleton instance of this package.
  LocationUtils get instance => LocationUtils();

  /// The singleton instance of this package.
  factory LocationUtils() {
    return _instance ??= const LocationUtils._();
  }

  //
  //
  //

  // These static consts allows us to completely contain the package within the
  // LocationUtilsPackage class. This means that the package can be imported
  // without polluting the global namespace.

  /// The distance unit of miles.
  static const DISTANCE_MILES = DistanceUnit.MILES;

  /// The distance unit of kilometres.
  static const DISTANCE_KILOMETRES = DistanceUnit.KILOMETRES;

  /// The distance unit of metres.
  static const DISTANCE_METRES = DistanceUnit.METRES;

  /// The distance unit of nautical miles.
  static const DISTANCE_NAUTICAL_MILES = DistanceUnit.NAUTICAL_MILES;

  /// The distance unit of feet.
  static const DISTANCE_FEET = DistanceUnit.FEET;

  /// The distance unit of yards.
  static const DISTANCE_YARDS = DistanceUnit.YARDS;

  /// The distance unit of astronomical units.
  static const DISTANCE_ASTRONOMICAL_UNITS = DistanceUnit.ASTRONOMICAL_UNITS;

  /// The radius of the Earth.
  static const RADIUS_EARTH = CelestialRadius.EARTH;

  /// The radius of the Moon.
  static const RADIUS_EARTH_MOON = CelestialRadius.EARTH_MOON;

  /// The radius of Mars.
  static const RADIUS_MARS = CelestialRadius.MARS;
}
