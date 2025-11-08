import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

/// Initial state before any data is loaded
class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

/// Loading state when initializing home screen
class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

/// Loaded state - home screen is ready
class HomeLoaded extends HomeState {
  const HomeLoaded();

  @override
  List<Object?> get props => [];
}

/// Error state for critical failures
class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Action states for navigation/dialogs
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