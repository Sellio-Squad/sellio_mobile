import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  final Set<String> productIds;
  final Set<String> storeIds;

  const FavoritesState({
    this.productIds = const {},
    this.storeIds = const {},
  });

  @override
  List<Object?> get props => [productIds, storeIds];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading({
    super.productIds,
    super.storeIds,
  });
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({
    required super.productIds,
    required super.storeIds,
  });

  FavoritesLoaded copyWith({
    Set<String>? productIds,
    Set<String>? storeIds,
  }) {
    return FavoritesLoaded(
      productIds: productIds ?? this.productIds,
      storeIds: storeIds ?? this.storeIds,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({
    required this.message,
    super.productIds,
    super.storeIds,
  });

  @override
  List<Object?> get props => [message, productIds, storeIds];
}
