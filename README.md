# deferred_type for Dart

![Pub Version](https://img.shields.io/pub/v/deferred_type?label=dart%20package&logo=dart&style=for-the-badge)
![GitHub](https://img.shields.io/github/license/arafatamim/deferred_type?logo=git&style=for-the-badge)

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
  builder: (context, state) => state.maybeWhen<Widget>(
    inProgress: () => const CircularProgressIndicator(),
    success: (data) => SomeWidget(data),
    error: (error, _stacktrace) => SomeErrorWidget(error),
    // handle fallback cases, must be provided
    // if all states are not handled.
    orElse: () => const FallbackWidget(),
  );
);
```

## API Reference

Detailed API documentation can be found on [pub.dev](https://pub.dev/documentation/deferred_type/latest/deferred_type/deferred_type-library.html).

## Possible to-do

- Version with [fpdart](https://github.com/SandroMaglione/fpdart) integration.
- Come up with a better name for the FutureBuilder.

## Other resources

- Comprehensive functional programming library for Dart: https://github.com/SandroMaglione/fpdart.
- Datum library for TypeScript compatible with fp-ts: https://github.com/nullpub/datum.
- Alternative, similar package on pub.dev: https://pub.dev/packages/remote_state.

## License
This project is [MIT licensed](https://github.com/arafatamim/deferred_type/blob/main/LICENSE).

