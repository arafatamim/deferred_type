abstract class Deferred<T> {
  const Deferred();
  factory Deferred.success(T result) = _Success<T>;
  factory Deferred.error(Object error, StackTrace? stackTrace) = _Error<T>;
  factory Deferred.inProgress() = _InProgress<T>;
  factory Deferred.idle() = _Idle<T>;

  /// Similar to [when], but doesn't require all states to be explicitly handled,
  /// therefore the [orElse] callback must be provided as a fallback handler.
  R maybeWhen<R>({
    R Function(T result)? success,
    R Function(Object error, StackTrace? stackTrace)? error,
    R Function()? inProgress,
    R Function()? idle,
    required R Function() orElse,
  }) {
    if (this is _InProgress) {
      if (inProgress != null) {
        return inProgress();
      } else {
        return orElse();
      }
    } else if (this is _Error) {
      final err = this as _Error;
      if (error != null) {
        return error(err.error, err.stackTrace);
      } else {
        return orElse();
      }
    } else if (this is _Success) {
      if (success != null) {
        return success((this as _Success<T>).results);
      } else {
        return orElse();
      }
    } else {
      if (idle != null) {
        return idle();
      } else {
        return orElse();
      }
    }
  }

  /// Provides several callbacks for handling common states of async data.
  /// It functions as a rudimentary form of pattern matching.
  /// - [idle] callback is used to match the initial state where the operation hasn't started yet.
  /// - [inProgress] is used to handle an ongoing async operation.
  /// - [success] is called with the finished successful result.
  /// - [error] is to be called when the operation has finished with an [Exception],
  /// with an optional [StackTrace].
  R when<R>({
    required R Function(T result) success,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function() inProgress,
    required R Function() idle,
  }) {
    if (this is _InProgress) {
      return inProgress();
    } else if (this is _Error) {
      final err = this as _Error;
      return error(err.error, err.stackTrace);
    } else if (this is _Success) {
      return success((this as _Success<T>).results);
    } else {
      return idle();
    }
  }

  /// Transforms the contained `success` value based on the result of the callback function [f].
  Deferred<R> mapSuccess<R>(
    R Function(T result) f,
  ) {
    if (this is _InProgress) {
      return Deferred.inProgress();
    } else if (this is _Error) {
      final err = this as _Error;
      return Deferred.error(err.error, err.stackTrace);
    } else if (this is _Success) {
      final success = this as _Success;
      return Deferred.success(f(success.results));
    } else {
      return Deferred.idle();
    }
  }

  /// Transforms the contained `error` value based on the result of the callback function [f].
  Deferred<T> mapError(
    Object Function(Object error) f,
  ) {
    if (this is _InProgress) {
      return Deferred.inProgress();
    } else if (this is _Error) {
      final err = this as _Error;
      return Deferred.error(f(err.error), err.stackTrace);
    } else if (this is _Success) {
      final success = this as _Success;
      return Deferred.success(success.results);
    } else {
      return Deferred.idle();
    }
  }

  /// Transforms both the contained `success` and `error` values
  /// based on the results of the callback functions [success] and [error] respectively.
  Deferred<R> mapBoth<R>({
    required R Function(T result) success,
    required Object Function(Object error) error,
  }) {
    if (this is _InProgress) {
      return Deferred.inProgress();
    } else if (this is _Error) {
      final e = this as _Error;
      return Deferred.error(error(e.error), e.stackTrace);
    } else if (this is _Success) {
      final s = this as _Success;
      return Deferred.success(success(s.results));
    } else {
      return Deferred.idle();
    }
  }

  /// Chains two [Deferred] values in sequence,
  /// using the result of callback [f] to determine the next value.
  Deferred<R> flatMap<R>(
    Deferred<R> Function(T result) f,
  ) {
    return this.when(
      success: (data) => f(data),
      error: (error, stackTrace) => _Error<R>(error, stackTrace),
      inProgress: () => _InProgress<R>(),
      idle: () => _Idle<R>(),
    );
  }

  /// Returns the `success` value if available, or the provided [defaultValue].
  T getOrElse(T defaultValue) {
    return this.maybeWhen(
      orElse: () => defaultValue,
      success: (data) => data,
    );
  }

  /// Returns the `success` value if available, or throws an exception.
  T getOrThrow() {
    if (this is _Success) {
      final success = this as _Success;
      return success.results;
    } else {
      throw Exception("getOrException() called on non-success value!");
    }
  }
}

class _Success<T> extends Deferred<T> {
  final T _results;
  T get results => _results;
  const _Success(this._results);
}

class _Idle<T> extends Deferred<T> {
  const _Idle();
}

class _InProgress<T> extends Deferred<T> {
  const _InProgress();
}

class _Error<T> extends Deferred<T> {
  final Object _error;
  final StackTrace? _stackTrace;

  Object get error => _error;
  StackTrace? get stackTrace => _stackTrace;
  const _Error(this._error, this._stackTrace);
}
