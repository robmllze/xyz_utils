// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

// ignore_for_file: library_private_types_in_public_api

class ScreenCalculator {
  late double _longest;
  double get longest => this._longest;
  late double _shortest;
  double get shortest => this._shortest;
  late _Size _size;
  _Size get size => this._size;
  double get width => this._size.width;
  double get height => this._size.height;
  late _Size _sizeVerticalBias;
  _Size get sizeVerticalBias => this._sizeVerticalBias;
  late _Size _sizeHorizontalBias;
  _Size get sizeHorizontalBias => this._sizeHorizontalBias;
  late bool _isHorizontal;
  bool get isHorizontal => this._isHorizontal;
  late bool _isVertical;
  bool get isVertical => this._isVertical;
  late bool _isNeitherHorizontalNorVertical;
  bool get isNeitherHorizontalNorVertical => this._isNeitherHorizontalNorVertical;
  bool get isAspectRatioMobile => this.sizeVerticalBias.aspectRatio > MIN_MOBILE_ASPECT_RATIO;

  ScreenCalculator(double maxWidth, double maxHeight) {
    this._longest = maxWidth >= maxHeight ? maxWidth : maxHeight;
    this._shortest = maxWidth <= maxHeight ? maxWidth : maxHeight;
    this._size = _Size(maxWidth, maxHeight);
    this._sizeVerticalBias = _Size(
      this._longest,
      this._shortest,
    );
    this._sizeHorizontalBias = _Size(
      this._shortest,
      this._longest,
    );
    this._isHorizontal = this._size.aspectRatio > 1.0;
    this._isVertical = this._size.aspectRatio < 1.0;
    this._isNeitherHorizontalNorVertical = this._size.aspectRatio == 1.0;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class _Size {
  final double width, height;
  const _Size(this.width, this.height);
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

extension IsVertical on _Size {
  bool get isVertical => this.aspectRatio <= 1.0;
}

extension IsHorizontal on _Size {
  bool get isHorizontal => this.aspectRatio >= 1.0;
}

extension IsNeitherHorizontalNorVertical on _Size {
  bool get isNeitherHorizontalNorVerticalisVertical => this.aspectRatio == 1.0;
}
