// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

import 'dart:async';
import 'package:meta/meta.dart';

import '../data/data.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class DisposableService {
  //
  //
  //

  /// Creator for async instances.
  final AsyncInstanceCreator creator;

  //
  //
  //

  const DisposableService(this.creator);

  //
  //
  //

  Future<void> dispose();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class AsyncInstanceCreator<T extends DisposableService> {
  //
  //
  //

  String id;

  AsyncInstanceCreator(this.id);

  T? _instance;

  //
  //
  //

  @mustCallSuper
  Future<void> createInstance(T? instance) async {
    this._instance = instance;
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
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Manages a collection of [DisposableService] instances, each associated with
/// a key.
abstract class CollectiveService<T extends DisposableService> {
  //
  //
  //

  final all = <String, T>{};

  //
  //
  //

  CollectiveService();

  //
  //
  //

  Set<String> get keys => this.all.keys.toSet();
  Iterable<T> get values => this.all.values;

  //
  //
  //

  Future<void> update(Set<String> oldKeys, Set<String> newKeys) async {
    final addedKeys = getSetDifference(oldKeys, newKeys);
    final removedKeys = getSetDifference(newKeys, oldKeys);
    await Future.forEach(addedKeys, (final key) async {
      final temp = await this.addService(key);
      if (temp != null) this.all[key] = temp;
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
    await Future.forEach(keys, (String key) async => await this.all[key]?.dispose());
    this.all.removeWhere((final key, _) => keys.contains(key));
  }

  //
  //
  //

  Future<void> dispose() => this.removeServices(this.all.keys);
}
