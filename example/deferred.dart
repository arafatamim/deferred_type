import "package:deferred_type/deferred_type.dart";

final state = Deferred.success("that");

String getData() {
  // transform the value contained in the success state (for some reason)
  final number = state.mapSuccess((result) {
    if (result == "this") {
      return 1;
    } else if (result == "that") {
      return 0;
    } else {
      return -1;
    }
  });
  final folded = number.when(
    success: (a) => "Success! The number is: $a",
    error: (error, stackTrace) => "Uh-oh! Found an error: $error",
    inProgress: () => "Waiting for result...",
    idle: () => "Nothing to do!",
  );
  return folded;
}
