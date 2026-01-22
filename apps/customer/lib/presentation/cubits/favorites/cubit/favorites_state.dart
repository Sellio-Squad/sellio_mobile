import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/store.dart';

abstract class FavoritesState extends Equatable {
  final Set<String> productIds;
  final Set<String> storeIds;
  final List<Product>? favoriteProducts;
  final List<Store>? favoriteStores;
  /// Set of product IDs that are currently being toggled (loading state)
  final Set<String> loadingProductIds;
  /// Set of store IDs that are currently being toggled (loading state)
  final Set<String> loadingStoreIds;

  const FavoritesState({
    this.productIds = const {},
    this.storeIds = const {},
    this.favoriteProducts,
    this.favoriteStores,
    this.loadingProductIds = const {},
    this.loadingStoreIds = const {},
  });

  @override
  List<Object?> get props =>
      [productIds, storeIds, favoriteProducts, favoriteStores, loadingProductIds, loadingStoreIds];
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
    super.loadingProductIds,
    super.loadingStoreIds,
  });
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({
    required super.productIds,
    required super.storeIds,
    super.favoriteProducts,
    super.favoriteStores,
    super.loadingProductIds,
    super.loadingStoreIds,
  });

  FavoritesLoaded copyWith({
    Set<String>? productIds,
    Set<String>? storeIds,
    List<Product>? favoriteProducts,
    List<Store>? favoriteStores,
    Set<String>? loadingProductIds,
    Set<String>? loadingStoreIds,
  }) {
    return FavoritesLoaded(
      productIds: productIds ?? this.productIds,
      storeIds: storeIds ?? this.storeIds,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteStores: favoriteStores ?? this.favoriteStores,
      loadingProductIds: loadingProductIds ?? this.loadingProductIds,
      loadingStoreIds: loadingStoreIds ?? this.loadingStoreIds,
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
    super.loadingProductIds,
    super.loadingStoreIds,
  });

  @override
  List<Object?> get props =>
      [message, productIds, storeIds, favoriteProducts, favoriteStores, loadingProductIds, loadingStoreIds];
}