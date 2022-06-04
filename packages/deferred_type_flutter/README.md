# deferred_type_flutter for Dart

[![Pub Version](https://img.shields.io/pub/v/deferred_type_flutter?label=dart%20package&logo=dart&style=for-the-badge)](https://pub.dev/packages/deferred_type_flutter)
![GitHub](https://img.shields.io/github/license/arafatamim/deferred_type?logo=git&style=for-the-badge)

Packages for Flutter based on the library [deferred_type](https://pub.dev/packages/deferred_type).

## FutureBuilder2

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

Detailed API documentation can be found on [pub.dev](https://pub.dev/documentation/deferred_type_flutter/latest/deferred_type_flutter/deferred_type_flutter-library.html).

## Possible to-do
- Come up with a better name for the FutureBuilder.

## License
This project is [MIT licensed](https://github.com/arafatamim/deferred_type/blob/main/LICENSE).
