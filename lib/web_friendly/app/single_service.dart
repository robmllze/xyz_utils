//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:async';
import 'package:meta/meta.dart';

import '/web_friendly/all_web_friendly_g.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class SingleService {
  //
  //
  //

  final SingleServiceCreator creator;
  final void Function(Object?)? onError;

  //
  //
  //

  const SingleService({
    required this.creator,
    required this.onError,
  });

  //
  //
  //

  Future<void> init() async {}

  //
  //
  //

  Future<void> dispose();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class SingleServiceCreator<T extends SingleService> {
  //
  //
  //

  final String? id;
  late final void Function(Object?)? onError;
  T? _instance;

  //
  //
  //

  SingleServiceCreator({
    this.id,
    required void Function(Object?)? onError,
  }) {
    this.onError = onError ??
        (e) {
          // Handle error silently.
          Here().debugLogError(e);
        };
  }

  //
  //
  //

  @mustCallSuper
  Future<void> createService(T? instance) async {
    await (this._instance = instance)?.init();
    Here().debugLog("Created service of type $T${this.id != null ? " for ${this.id}" : ""}");
  }

  //
  //
  //

  Future<T> getService() async {
    if (this._instance == null) {
      await createService(null);
    }
    return this._instance!;
  }

  //
  //
  //

  Future<void> dispose() async {
    await this._instance?.dispose();
    this._instance = null;
    Here().debugLog("Disposed service of type $T${this.id != null ? " for ${this.id}" : ""}");
  }
}
