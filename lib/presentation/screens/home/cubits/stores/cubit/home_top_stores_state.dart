import 'package:equatable/equatable.dart';

import '../../../../../../domain/entities/store.dart';

sealed class HomeTopStoresState extends Equatable {
  const HomeTopStoresState();
}

class HomeTopStoresInitial extends HomeTopStoresState {
  const HomeTopStoresInitial();

  @override
  List<Object?> get props => [];
}

class HomeTopStoresLoading extends HomeTopStoresState {
  const HomeTopStoresLoading();

  @override
  List<Object?> get props => [];
}

class HomeTopStoresLoaded extends HomeTopStoresState {
  final List<Store> stores;

  const HomeTopStoresLoaded({
    required this.stores,
  });

  HomeTopStoresLoaded copyWith({
    List<Store>? stores,
  }) {
    return HomeTopStoresLoaded(
      stores: stores ?? this.stores,
    );
  }

  @override
  List<Object?> get props => [stores];
}

class HomeTopStoresError extends HomeTopStoresState {
  final String message;

  const HomeTopStoresError({required this.message});

  @override
  List<Object?> get props => [message];
}