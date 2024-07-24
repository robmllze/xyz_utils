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

import 'dart:math';

import 'location_utils.dart';
import 't_location_components.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension CalculateZoomToFitOnLocationPackageExtension on LocationUtils {
  /// Calculates the zoom level to fit all the [locations] on a map. The [factor]
  /// is a multiplier to adjust the zoom level. The [minZoom] and [maxZoom] are
  /// the minimum and maximum zoom levels to clamp the result.
  double calculateZoomToFit(
    Iterable<TLocationComponents> locations, {
    double factor = 1.0,
    double minZoom = 10.0,
    double maxZoom = 20.0,
  }) {
    if (locations.isEmpty) {
      return 10.0;
    }
    var minLat = locations.first.latitude;
    var maxLat = locations.first.latitude;
    var minLng = locations.first.longitude;
    var maxLng = locations.first.longitude;
    for (final marker in locations) {
      if (marker.latitude < minLat) minLat = marker.latitude;
      if (marker.latitude > maxLat) maxLat = marker.latitude;
      if (marker.longitude < minLng) minLng = marker.longitude;
      if (marker.longitude > maxLng) maxLng = marker.longitude;
    }
    final lngDelta = maxLng - minLng;
    // Estimate zoom level based on longitude span.
    final estimate =
        max(0.0, 1.0 - log(lngDelta) / log(2.0) + (log(360) / log(2.0)) - 1);
    // Apply the factor and clamp the zoom level.
    final zoom = max(minZoom, min(maxZoom, estimate)) * factor;
    return zoom;
  }
}
