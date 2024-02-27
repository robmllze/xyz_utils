//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

class ScreenCalculator {
  //
  //
  //

  late double _longest;
  double get longest => this._longest;
  late double _shortest;
  double get shortest => this._shortest;
  late ScreenSize _size;
  ScreenSize get size => this._size;
  double get width => this._size.width;
  double get height => this._size.height;
  late ScreenSize _sizeVerticalBias;
  ScreenSize get sizeVerticalBias => this._sizeVerticalBias;
  late ScreenSize _sizeHorizontalBias;
  ScreenSize get sizeHorizontalBias => this._sizeHorizontalBias;
  late bool _isHorizontal;
  bool get isHorizontal => this._isHorizontal;
  late bool _isVertical;
  bool get isVertical => this._isVertical;
  late bool _isNeitherHorizontalNorVertical;
  bool get isNeitherHorizontalNorVertical =>
      this._isNeitherHorizontalNorVertical;
  bool get isAspectRatioMobile =>
      this.sizeVerticalBias.aspectRatio > MIN_MOBILE_ASPECT_RATIO;

  //
  //
  //

  ScreenCalculator(double maxWidth, double maxHeight) {
    this._longest = maxWidth >= maxHeight ? maxWidth : maxHeight;
    this._shortest = maxWidth <= maxHeight ? maxWidth : maxHeight;
    this._size = ScreenSize(maxWidth, maxHeight);
    this._sizeVerticalBias = ScreenSize(
      this._longest,
      this._shortest,
    );
    this._sizeHorizontalBias = ScreenSize(
      this._shortest,
      this._longest,
    );
    this._isHorizontal = this._size.aspectRatio > 1.0;
    this._isVertical = this._size.aspectRatio < 1.0;
    this._isNeitherHorizontalNorVertical = this._size.aspectRatio == 1.0;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class ScreenSize {
  final double width, height;
  const ScreenSize(this.width, this.height);
  double get aspectRatio {
    if (height != 0.0) return width / height;
    if (width > 0.0) return double.infinity;
    if (width < 0.0) return double.negativeInfinity;
    return 0.0;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

// The smallest of the following common aspect ratios for mobile phones (4.0 / 3.0)
const MIN_MOBILE_ASPECT_RATIO = 4.0 / 3.0;
double get minMobileAspectRatio => {
      // Samsungs
      16.0 / 10.0,
      // Pixels, Samsungs
      16.0 / 9.0,
      // Pixels, most iPhones before 2018
      18.0 / 9.0,
      // Pixels
      18.5 / 9.0,
      18.7 / 9.0,
      19.0 / 10.0,
      // Pixels
      19.0 / 9.0,
      // Pixels and most iPhones after 2018
      19.5 / 9.0,
      3.0 / 2.0,
      // Old iPhones, and many tablets!
      4.0 / 3.0,
      5.0 / 3.0,
      // Samsungs
      2.10 / 1,
      20.0 / 9.0,
      193 / 90,
    }.reduce((final a, final b) => a <= b ? a : b);

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

extension IsVertical on ScreenSize {
  bool get isVertical => this.aspectRatio <= 1.0;
}

extension IsHorizontal on ScreenSize {
  bool get isHorizontal => this.aspectRatio >= 1.0;
}

extension IsNeitherHorizontalNorVertical on ScreenSize {
  bool get isNeitherHorizontalNorVerticalisVertical => this.aspectRatio == 1.0;
}
