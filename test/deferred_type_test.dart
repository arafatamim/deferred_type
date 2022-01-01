import 'package:test/test.dart';
import 'package:deferred_type/deferred.dart';

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
}
