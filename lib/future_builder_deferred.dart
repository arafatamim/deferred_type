import 'package:deferred_type/deferred.dart';
import 'package:flutter/material.dart';

typedef ResponseWidgetBuilder<T> = Widget Function(
    BuildContext context, Deferred<T> state);

class FutureBuilder2<T> extends StatefulWidget {
  /// Creates a widget that builds itself based on the latest snapshot of
  /// interaction with a [Future].
  ///
  /// The [builder] must not be null.
  const FutureBuilder2({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  final Future<T> future;

  /// The build strategy currently used by this builder.
  ///
  /// The builder's [Deferred] object comes with a [Deferred.where]
  /// method which can be used to match the following states of
  /// asynchronous data:
  ///
  ///  * [Idle]: [future] is null and has not started yet.
  ///
  ///  * [InProgress]: [future] is not null, but has not yet
  ///    completed.
  ///
  ///  * [Success]: [future] is not null, and has completed
  ///    successfully with no errors.
  ///
  ///  * [Error]: [future] is not null, but has completed with an error.
  ///
  /// This builder must only return a widget and should not have any side
  /// effects as it may be called multiple times.
  final ResponseWidgetBuilder<T> builder;

  @override
  State<FutureBuilder2<T>> createState() => _FutureBuilder2State<T>();
}

/// State for [FutureBuilder2].
class _FutureBuilder2State<T> extends State<FutureBuilder2<T>> {
  /// An object that identifies the currently active callbacks. Used to avoid
  /// calling setState from stale callbacks, e.g. after disposal of this state,
  /// or after widget reconfiguration to a new Future.
  Object? _activeCallbackIdentity;
  late Deferred<T> _result;

  @override
  void initState() {
    super.initState();
    _result = Deferred<T>.idle();
    _subscribe();
  }

  @override
  void didUpdateWidget(FutureBuilder2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future != widget.future) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _result = Deferred<T>.idle();
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _result);

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    widget.future.then<void>((T data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        setState(() {
          _result = Deferred<T>.success(data);
        });
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (_activeCallbackIdentity == callbackIdentity) {
        setState(() {
          _result = Deferred<T>.error(error, stackTrace);
        });
      }
    });
    _result = Deferred<T>.inProgress();
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}
