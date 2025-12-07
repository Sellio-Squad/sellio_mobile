import '../../core/error/failure.dart';

abstract class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is ResultFailure<T>;

  T get data {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    throw Exception('Cannot get data from Failure result');
  }

  Failure get failure {
    if (this is ResultFailure<T>) {
      return (this as ResultFailure<T>).error;
    }
    throw Exception('Cannot get failure from Success result');
  }

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

  Result<R> map<R>(R Function(T value) transform) {
    if (this is Success<T>) {
      return Success(transform((this as Success<T>).value));
    } else {
      return ResultFailure((this as ResultFailure<T>).error);
    }
  }

  Result<T> mapFailure(Failure Function(Failure failure) transform) {
    if (this is ResultFailure<T>) {
      return ResultFailure(transform((this as ResultFailure<T>).error));
    } else {
      return this;
    }
  }

  Result<T> onSuccess(void Function(T value) action) {
    if (this is Success<T>) {
      action((this as Success<T>).value);
    }
    return this;
  }

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
