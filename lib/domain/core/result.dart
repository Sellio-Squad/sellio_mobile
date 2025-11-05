import 'failure.dart';

/// A Result type for handling success and failure cases
abstract class Result<T> {
  const Result();

  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is ResultFailure<T>;

  /// Get data if success, throws if failure
  T get data {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    throw Exception('Cannot get data from Failure result');
  }

  /// Get failure if failure, throws if success
  Failure get failure {
    if (this is ResultFailure<T>) {
      return (this as ResultFailure<T>).error;
    }
    throw Exception('Cannot get failure from Success result');
  }

  /// Fold the result into a single value
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).value);
    } else {
      return onFailure((this as ResultFailure<T>).error);
    }
  }

  /// Map the success value
  Result<R> map<R>(R Function(T value) transform) {
    if (this is Success<T>) {
      return Success(transform((this as Success<T>).value));
    } else {
      return ResultFailure((this as ResultFailure<T>).error);
    }
  }

  /// Map the failure value
  Result<T> mapFailure(Failure Function(Failure failure) transform) {
    if (this is ResultFailure<T>) {
      return ResultFailure(transform((this as ResultFailure<T>).error));
    } else {
      return this;
    }
  }

  /// Execute action if success
  Result<T> onSuccess(void Function(T value) action) {
    if (this is Success<T>) {
      action((this as Success<T>).value);
    }
    return this;
  }

  /// Execute action if failure
  Result<T> onFailure(void Function(Failure failure) action) {
    if (this is ResultFailure<T>) {
      action((this as ResultFailure<T>).error);
    }
    return this;
  }
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  String toString() => 'Success(value: $value)';
}

class ResultFailure<T> extends Result<T> {
  final Failure error;

  const ResultFailure(this.error);

  @override
  String toString() => 'ResultFailure(error: $error)';
}