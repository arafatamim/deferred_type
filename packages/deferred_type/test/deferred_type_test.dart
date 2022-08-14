// ignore_for_file: inference_failure_on_instance_creation

import 'package:test/test.dart';
import "package:deferred_type/deferred.dart";

void main() {
  test("should handle state accordingly in when method", () {
    Deferred<String> state = Deferred.idle();
    expect(
      state.when(
        success: (a) => false,
        error: (error, stackTrace) => false,
        inProgress: () => false,
        idle: () => true,
      ),
      true,
    );

    state = Deferred.inProgress();
    expect(
      state.when(
        success: (result) => false,
        error: (error, stackTrace) => false,
        inProgress: () => true,
        idle: () => false,
      ),
      true,
    );

    state = Deferred.success("success");
    expect(
      state.when(
        success: (result) => true,
        error: (error, stackTrace) => false,
        inProgress: () => false,
        idle: () => false,
      ),
      true,
    );

    state = Deferred.error("error", null);
    expect(
      state.when(
        success: (result) => false,
        error: (error, stackTrace) => true,
        inProgress: () => false,
        idle: () => false,
      ),
      true,
    );
  });

  test('should correctly determine equality', () {
    expect(Deferred.idle(), equals(Deferred.idle()));

    expect(Deferred.inProgress(), equals(Deferred.inProgress()));

    expect(
      Deferred.success(<String>[]),
      equals(Deferred.success(<String>[])),
    );

    expect(
      Deferred.error("this is an error", null),
      equals(Deferred.error("this is an error", null)),
    );
  });

  test('should correctly equate hashCodes', () {
    expect(Deferred.idle().hashCode, equals(Deferred.idle().hashCode));

    expect(
      Deferred.inProgress().hashCode,
      equals(Deferred.inProgress().hashCode),
    );

    expect(
      Deferred.success(<String>[]),
      equals(Deferred.success(<String>[])),
    );

    expect(
      Deferred.error("this is an error", null).hashCode,
      equals(Deferred.error("this is an error", null).hashCode),
    );
  });
}
