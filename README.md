# deferred_type for Dart

[![Pub Version deferred_type](https://img.shields.io/pub/v/deferred_type?label=deferred_type&logo=dart&style=for-the-badge)](https://pub.dev/packages/deferred_type)
[![Pub Version deferred_type_flutter](https://img.shields.io/pub/v/deferred_type_flutter?label=deferred_type_flutter&logo=dart&style=for-the-badge)](https://pub.dev/packages/deferred_type_flutter) \
[![GitHub](https://img.shields.io/github/license/arafatamim/deferred_type?logo=git&style=for-the-badge)](https://github.com/arafatamim/deferred_type)

Modeling asynchronous data in Dart made easy.

## Examples

```dart
final Deferred<String> idle = Deferred.idle();
final Deferred<String> inProgress = Deferred.inProgress();
final Deferred<String> success = Deferred.success('DATA!');
final Deferred<String> error = Deferred.error('ERROR!');
```

### Flutter

Package [deferred_type_flutter](https://pub.dev/packages/deferred_type_flutter) contains `FutureBuilder2`, an alternative "FutureBuilder" which is simpler to use than the bundled one provided by default in Flutter.

```dart
import "package:deferred_type_flutter/deferred_type_flutter.dart";

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

## Other resources

- Comprehensive functional programming library for Dart: https://github.com/SandroMaglione/fpdart.
- Datum library for TypeScript compatible with fp-ts: https://github.com/nullpub/datum.
- Alternative, similar package on pub.dev: https://pub.dev/packages/remote_state.

## License
This project is [MIT licensed](https://github.com/arafatamim/deferred_type/blob/main/LICENSE).
