import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/store.dart';

sealed class StoresState extends Equatable {
  const StoresState();
}

class StoresInitial extends StoresState {
  const StoresInitial();

  @override
  List<Object?> get props => [];
}

class StoresLoading extends StoresState {
  const StoresLoading();

  @override
  List<Object?> get props => [];
}

class StoresLoaded extends StoresState {
  final List<Store> stores;

  const StoresLoaded({
    required this.stores,
  });

  StoresLoaded copyWith({
    List<Store>? stores,
  }) {
    return StoresLoaded(
      stores: stores ?? this.stores,
    );
  }

  @override
  List<Object?> get props => [stores];
}

class StoresError extends StoresState {
  final String message;

  const StoresError({required this.message});

  @override
  List<Object?> get props => [message];
}