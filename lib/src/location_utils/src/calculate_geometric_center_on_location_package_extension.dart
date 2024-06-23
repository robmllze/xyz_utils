//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'location_utils.dart';
import 't_location_components.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension CalculateGeometricCentereOnLocationPackageExtension on LocationUtils {
  /// Calculates the geometric center of a set of locations.
  TLocationComponents calculateGeometricCenter(
    Set<TLocationComponents> locations,
  ) {
    if (locations.isEmpty) {
      return (
        altitude: 0.0,
        latitude: 0.0,
        longitude: 0.0,
      );
    }
    var sumLat = 0.0;
    var sumLng = 0.0;
    for (final marker in locations) {
      sumLat += marker.latitude;
      sumLng += marker.longitude;
    }
    return (
      latitude: sumLat / locations.length,
      longitude: sumLng / locations.length,
      altitude: 0.0,
    );
  }
}
