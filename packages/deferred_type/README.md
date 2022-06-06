# deferred_type for Dart
[![Pub Version](https://img.shields.io/pub/v/deferred_type?label=dart%20package&logo=dart&style=for-the-badge)](https://pub.dev/packages/deferred_type)
[![GitHub](https://img.shields.io/github/license/arafatamim/deferred_type?logo=git&style=for-the-badge)](https://github.com/arafatamim/deferred_type)

Modeling asynchronous data in Dart made easy. This package also provides various useful helper functions for transforming and querying the contained values.

**Flutter:** Package [deferred_type_flutter](https://pub.dev/packages/deferred_type_flutter) contains `FutureBuilder2`,
an alternative "FutureBuilder" which is simpler to use than the bundled one provided by default in Flutter.

## Examples

```dart
final Deferred<String> idle = Deferred.idle();
final Deferred<String> inProgress = Deferred.inProgress();
final Deferred<String> success = Deferred.success('DATA!');
final Deferred<String> error = Deferred.error('ERROR!');
```

**Sample MV app:**
```dart
import "package:deferred_type/deferred_type.dart";

class App {
  Deferred<String> state = Deferred.idle();

  App() {
    getStatus();
    render();
  }

  Future<void> getStatus() async {
    state = Deferred.inProgress();
    try {
      final someData = await Future.value("some data");
      state = Deferred.success(someData);
    } catch (e) {
      state = Deferred.error(e, null);
    }
    render();
  }

  String view(Deferred<String> state) {
    return state.when(
      success: (data) => "Got data: $data",
      error: (msg, stackTrace) => "Error: $msg",
      inProgress: () => "Loading...",
      idle: () => "Initializing...",
    );
  }

  String render() {
    final template = view(state);
    print(template);
    return template;
  }
}
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

