// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'package:meta/meta.dart';

import '../data/data.dart';
import 'here.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class DisposableService {
  //
  //
  //

  /// Creator for async instances.
  final AsyncServiceCreator creator;

  //
  //
  //

  const DisposableService(this.creator);

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

abstract class AsyncServiceCreator<T extends DisposableService> {
  //
  //
  //

  String id;

  AsyncServiceCreator(this.id);

  T? _instance;

  //
  //
  //

  @mustCallSuper
  Future<void> createInstance(T? instance) async {
    await (this._instance = instance)?.init();
    Here().debugLog("Created service of type $T for ${this.id}");
  }

  //
  //
  //

  Future<T> getInstance() async {
    if (this._instance == null) {
      await createInstance(null);
    }
    return this._instance!;
  }

  //
  //
  //

  Future<void> dispose() async {
    await this._instance?.dispose();
    this._instance = null;
    Here().debugLog("Disposed service of type $T for ${this.id}");
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Manages a collection of [DisposableService] instances, each associated with
/// a key.
abstract class CollectiveService<T extends DisposableService> {
  //
  //
  //

  final allServices = <String, T>{};

  //
  //
  //

  CollectiveService();

  //
  //
  //

  Set<String> get keys => this.allServices.keys.toSet();
  Iterable<T> get values => this.allServices.values;

  //
  //
  //

  Future<void> update(Set<String> oldKeys, Set<String> newKeys) async {
    final addedKeys = getSetDifference(oldKeys, newKeys);
    final removedKeys = getSetDifference(newKeys, oldKeys);
    await Future.forEach(addedKeys, (final key) async {
      final temp = await this.addService(key);
      if (temp != null) this.allServices[key] = temp;
    });
    await this.removeServices(removedKeys);
  }

  //
  //
  //

  Future<T?> addService(String key);

  //
  //
  //

  Future<void> removeServices(Iterable<String> keys) async {
    await Future.forEach(keys, (String key) async => await this.allServices[key]?.dispose());
    this.allServices.removeWhere((final key, _) => keys.contains(key));
  }

  //
  //
  //

  Future<void> dispose() => this.removeServices(this.allServices.keys);
}
