//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// 🇽🇾🇿 & Dev
//
// Licencing details are in the LICENSE file in the root directory.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

part of '../location_utils_package.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

enum LocationUtilsPackageRadius {
  //
  //
  //

  EARTH(6371e3),
  EARTH_MOON(1737.4e3),
  MARS(3389.5e3);

  //
  //
  //

  final double radius;

  //
  //
  //

  const LocationUtilsPackageRadius(this.radius);

  //
  //
  //

  double get inMetres => radius;
  double get inKilometres => radius / 1000;
  double get inMiles => radius / 1609.34;
  double get inNauticalMiles => radius / 1852;
  double get inFeet => radius * 3.28084;
  double get inYards => radius * 1.09361;
  double get inAstronomicalUnits => radius / 149597870700;
}
