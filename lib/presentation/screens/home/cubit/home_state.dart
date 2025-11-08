import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}


class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded();

  @override
  List<Object?> get props => [];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}


class HomeFilterRequested extends HomeState {
  const HomeFilterRequested();

  @override
  List<Object?> get props => [];
}

class HomeOfferSelected extends HomeState {
  final String offerId;

  const HomeOfferSelected({required this.offerId});

  @override
  List<Object?> get props => [offerId];
}

class HomeStoreSelected extends HomeState {
  final String storeId;

  const HomeStoreSelected({required this.storeId});

  @override
  List<Object?> get props => [storeId];
}

class HomeNotificationRequested extends HomeState {
  const HomeNotificationRequested();

  @override
  List<Object?> get props => [];
}