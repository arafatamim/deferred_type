# Deferred type for Dart

Modeling asynchronous data made easy. Comes with a `FutureBuilder2` widget for use in Flutter applications.

## Examples

```dart
final Deferred<String> idle = Deferred.idle();
final Deferred<String> inProgress = Deferred.inProgress();
final Deferred<String> success = Deferred.success('DATA!');
final Deferred<String> error = Deferred.error('ERROR!');
```

### Flutter
`FutureBuilder2`, an alternative "FutureBuilder" which is simpler to use than the bundled one provided by default in Flutter.

```dart
import "package:deferred_type/deferred_type.dart";

final futureBuilder = FutureBuilder2<String>(
  future: someFuture,
  builder: (context, state) => state.where<Widget>(
    onInProgress: () => const CircularProgressIndicator(),
    onSuccess: (data) => SomeWidget(data),
    onError: (error, _stacktrace) => SomeErrorWidget(error),
    // handle fallback cases, must be provided 
    // if all states are not handled, or it throws a runtime exception.
    orElse: () => const FallbackWidget(),
  );
);
```

## Possible to-do
- Write some tests.
- Version with [fpdart](https://github.com/SandroMaglione/fpdart) integration.
- Come up with a better name for the FutureBuilder.

## Other resources
- Comprehensive functional programming library for Dart: https://github.com/SandroMaglione/fpdart.
- Datum library for TypeScript compatible with fp-ts: https://github.com/nullpub/datum.