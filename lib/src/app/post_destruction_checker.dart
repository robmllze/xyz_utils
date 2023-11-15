//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

final _finalizer = Finalizer<void Function()>((final a) => a());

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Used to check when an object got destructed.
///
/// Example:
///
/// ```dart
/// final object = <dynamic, dynamic>{};
/// final checker = ObjectPostDestructionChecker(object, (){
///   print("object has been destructed/no longer exists");
/// });
/// ```
class ObjectPostDestructionChecker {
  //
  //
  //

  /// Creates an ObjectPostDestructionChecker instance.
  ///
  /// This constructor attaches a post-destruction callback to the specified [object].
  ///
  /// - [object] The object to which the post-destruction callback will be attached.
  /// - [onPostDestruct] The callback function to be executed after the [object] is destructed.
  ObjectPostDestructionChecker(Object object, void Function() onPostDestruct) {
    _finalizer.attach(
      object,
      onPostDestruct,
      detach: object,
    );
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// Used to check when an object got destructed.
///
/// Example:
///
/// ```dart
/// class YourClass extends PostDestructionChecker {
///   @override
///   void onPostDestruct() {
///     print("Your class has been destructed/no longer exists");
///   }
/// }
///
/// final yourClass = YourClass();
/// ```
abstract class PostDestructionChecker {
  PostDestructionChecker() {
    _finalizer.attach(
      this,
      this.onPostDestruct,
      detach: this,
    );
  }

  /// Implement this method to define the action to be taken when the object is
  /// destructed.
  void onPostDestruct();
}
