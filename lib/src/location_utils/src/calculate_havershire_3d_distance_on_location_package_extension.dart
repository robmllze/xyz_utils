//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:math';

import 'location_utils.dart';
import 'celestial_radius.dart';
import 'distance_unit.dart';
import 't_location_components.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension CalculateHavershire3DDistanceOnLocationPackageExtension on LocationUtils {
  /// Calculate the distance between two locations using the Haversine formula
  /// and optionally the elevation difference.
  ///
  /// The Haversine formula calculates the shortest distance between two points
  /// on a sphere.
  ///
  /// The formula is:
  ///
  /// ```txt
  /// a = sin²(Δlat/2) + cos(lat1) * cos(lat2) * sin²(Δlon/2)
  /// c = 2 * atan2(√a, √(1−a))
  /// d = r * c
  /// ```
  ///
  /// The altitude is factored in by taking the square root of the sum of the
  /// square of the flat distance and the square of the altitude difference.
  ///
  /// **Parameters:**
  ///
  /// - `location1` - The first location.
  /// - `location2` - The second location.
  /// - `unit` - The unit of distance to return. Default is `LocationPackageDistanceUnit.METRES`.
  /// - `radius` - The radius of the sphere. Default is `LocationPackageSphereRadius.EARTH`.
  double calculateHavershire3DDistance({
    required TLocationComponents location1,
    required TLocationComponents location2,
    DistanceUnit unit = DistanceUnit.METRES,
    CelestialRadius radius = CelestialRadius.EARTH,
  }) {
    final lat1 = location1.latitude;
    final lon1 = location1.longitude;
    final alt1 = location1.altitude;
    final lat2 = location2.latitude;
    final lon2 = location2.longitude;
    final alt2 = location2.altitude;
    final r = radius.radius;

    // Convert latitude and longitude from degrees to radians.
    final radLat1 = lat1 * pi / 180;
    final radLat2 = lat2 * pi / 180;
    final deltaLat = (lat2 - lat1) * pi / 180;
    final deltaLon = (lon2 - lon1) * pi / 180;

    // Calculate the horizontal distance using the Haversine formula.
    final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(radLat1) * cos(radLat2) * sin(deltaLon / 2) * sin(deltaLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final d = r * c;

    // Calculate the difference in altitude.
    final deltaAlt = alt2 - alt1;

    // Calculate the total 3D distance.
    final d3d = sqrt(d * d + deltaAlt * deltaAlt);

    // Convert the distance based on the requested unit.
    return d3d * unit.conversion;
  }
}
