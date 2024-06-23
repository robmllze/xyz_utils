//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'calculate_geometric_center_on_location_package_extension.dart';
import 'calculate_havershire_3d_distance_on_location_package_extension.dart';
import 'distance_unit.dart';
import 'location_utils.dart';
import 't_location_components.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension CalculateBestCentereOnLocationPackageExtension on LocationUtils {
  /// Calculates the best center for a set of [locations]. This is the geometric
  /// center unless the distance to the closest marker is greater than the
  /// [threshold], then the closest marker is used. The [distanceUnit] is the unit of
  /// the threshold.
  TLocationComponents calculateBestCenter({
    required Set<TLocationComponents> locations,
    required double threshold,
    required DistanceUnit distanceUnit,
  }) {
    if (locations.isEmpty) {
      return (
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0.0,
      );
    }
    var center = calculateGeometricCenter(locations);
    var closestMarker = locations.first;
    var minDistance = calculateHavershire3DDistance(
      location1: center,
      location2: closestMarker,
      unit: distanceUnit,
    );
    for (final marker in locations.skip(1)) {
      final distance = calculateHavershire3DDistance(
        location1: center,
        location2: marker,
        unit: distanceUnit,
      );
      if (distance < minDistance) {
        closestMarker = marker;
        minDistance = distance;
      }
    }
    if (minDistance > threshold) {
      center = closestMarker;
    }
    return center;
  }
}
