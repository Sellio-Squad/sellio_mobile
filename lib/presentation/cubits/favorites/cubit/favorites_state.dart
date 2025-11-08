import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final Set<String> productIds;
  final Set<String> storeIds;

  const FavoritesState({
    this.productIds = const {},
    this.storeIds = const {},
  });

  FavoritesState copyWith({
    Set<String>? productIds,
    Set<String>? storeIds,
  }) {
    return FavoritesState(
      productIds: productIds ?? this.productIds,
      storeIds: storeIds ?? this.storeIds,
    );
  }

  @override
  List<Object?> get props => [productIds, storeIds];
}