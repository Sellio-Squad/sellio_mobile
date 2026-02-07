import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoaded extends FavoritesState {
  final Set<String> favoriteProductIds;
  final Set<String> favoriteStoreIds;

  final List<Product> favoriteProducts;
  final List<Store> favoriteStores;

  const FavoritesLoaded({
    required this.favoriteProductIds,
    required this.favoriteStoreIds,
    required this.favoriteProducts,
    required this.favoriteStores,
  });

  FavoritesLoaded copyWith({
    Set<String>? favoriteProductIds,
    Set<String>? favoriteStoreIds,
    List<Product>? favoriteProducts,
    List<Store>? favoriteStores,
  }) {
    return FavoritesLoaded(
      favoriteProductIds:
      favoriteProductIds ?? this.favoriteProductIds,
      favoriteStoreIds:
      favoriteStoreIds ?? this.favoriteStoreIds,
      favoriteProducts:
      favoriteProducts ?? this.favoriteProducts,
      favoriteStores:
      favoriteStores ?? this.favoriteStores,
    );
  }

  @override
  List<Object?> get props => [
    favoriteProductIds,
    favoriteStoreIds,
    favoriteProducts,
    favoriteStores,
  ];
}

class FavoritesActionFailure extends FavoritesState {
  final String message;

  const FavoritesActionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
