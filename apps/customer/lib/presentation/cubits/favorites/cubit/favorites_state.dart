import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/store.dart';

abstract class FavoritesState extends Equatable {
  final Set<String> productIds;
  final Set<String> storeIds;
  final List<Product>? favoriteProducts;
  final List<Store>? favoriteStores;

  const FavoritesState({
    this.productIds = const {},
    this.storeIds = const {},
    this.favoriteProducts,
    this.favoriteStores,
  });

  @override
  List<Object?> get props =>
      [productIds, storeIds, favoriteProducts, favoriteStores];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading({
    super.productIds,
    super.storeIds,
    super.favoriteProducts,
    super.favoriteStores,
  });
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({
    required super.productIds,
    required super.storeIds,
    super.favoriteProducts,
    super.favoriteStores,
  });

  FavoritesLoaded copyWith({
    Set<String>? productIds,
    Set<String>? storeIds,
    List<Product>? favoriteProducts,
    List<Store>? favoriteStores,
  }) {
    return FavoritesLoaded(
      productIds: productIds ?? this.productIds,
      storeIds: storeIds ?? this.storeIds,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteStores: favoriteStores ?? this.favoriteStores,
    );
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({
    required this.message,
    super.productIds,
    super.storeIds,
    super.favoriteProducts,
    super.favoriteStores,
  });

  @override
  List<Object?> get props =>
      [message, productIds, storeIds, favoriteProducts, favoriteStores];
}