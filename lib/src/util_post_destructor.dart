// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Utils
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

/// Used to check when an object got destructed.
///
/// Example:
///
/// ```dart
/// final object = <dynamic, dynamic>{};
/// final postDestructor = PostDestructor(object, (){
///   print("object has been destructed/no longer exists");
/// });
/// ```
class PostDestructor {
  //
  //
  //

  static final _finalizer = Finalizer<void Function()>((final a) => a());

  //
  //
  //

  PostDestructor(Object object, void Function() onPostDestruct) {
    PostDestructor._finalizer.attach(
      object,
      onPostDestruct,
      detach: object,
    );
  }
}
