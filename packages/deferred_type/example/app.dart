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
