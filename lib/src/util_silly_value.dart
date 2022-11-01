// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

class _Empty {
  _Empty._();
  static final instance = _Empty._();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class _SillyValue<T> {
  //
  //
  //

  static final _finalizer = Finalizer<void Function()>((final a) => a());
  static final _values = <dynamic>[];
  static var _i = 0;

  //
  //
  //

  int? _key;

  //
  //
  //

  T get value {
    return _values[this._key!];
  }

  //
  //
  //

  set value(T value) {
    _values[this._key!] = value;
  }

  //
  //
  //

  void dispose() {
    _SillyValue._values[this._key!] = _Empty.instance;
  }

  //
  //
  //

  bool get idDisposed {
    return _SillyValue._values[this._key!] == _Empty.instance;
  }

  //
  //
  //

  _SillyValue get pass;
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class SillyValue<T> extends _SillyValue<T> {
  //
  //
  //

  factory SillyValue(T value) {
    _SillyValue._values.add(value);
    return SillyValue._(_SillyValue._i++);
  }

  //
  //
  //

  SillyValue._(int key) {
    this._key = key;
  }

  //
  //
  //

  @override
  SillyValue<T> get pass {
    return SillyValue<T>._(this._key!);
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class SillyValueAuto<T> extends _SillyValue<T> {
  //
  //
  //

  factory SillyValueAuto(T value) {
    _SillyValue._values.add(value);
    return SillyValueAuto._(_SillyValue._i++);
  }

  //
  //
  //

  SillyValueAuto._(int key) {
    this._key = key;
    _SillyValue._finalizer.attach(
      this,
      () {
        _SillyValue._values[key] = _Empty.instance;
      },
      detach: this,
    );
  }

  //
  //
  //

  @override
  SillyValueAuto<T> get pass {
    final a = SillyValueAuto<T>._(this._key!);
    _SillyValue._finalizer.detach(this);
    return a;
  }
}
