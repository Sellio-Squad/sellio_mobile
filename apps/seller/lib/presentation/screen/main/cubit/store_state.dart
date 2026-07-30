import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {
  const StoreInitial();
}

class StoreLoading extends StoreState {
  const StoreLoading();
}

class StoreLoaded extends StoreState {
  final String storeId;

  const StoreLoaded(this.storeId);

  @override
  List<Object?> get props => [storeId];
}

class StoreNotFound extends StoreState {
  const StoreNotFound();
}

class StoreError extends StoreState {
  final String message;

  const StoreError(this.message);

  @override
  List<Object?> get props => [message];
}
