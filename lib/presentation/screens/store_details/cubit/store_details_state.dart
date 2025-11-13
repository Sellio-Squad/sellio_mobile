import 'package:equatable/equatable.dart';
import '../../../../../../../domain/entities/store.dart';
import '../../../../../../../domain/entities/product.dart';
import '../../../../domain/entities/StoreRating.dart';


sealed class StoreDetailsState extends Equatable {
  const StoreDetailsState();

  @override
  List<Object?> get props => [];
}

class StoreDetailsInitial extends StoreDetailsState {
  const StoreDetailsInitial();
}

class StoreDetailsLoading extends StoreDetailsState {
  const StoreDetailsLoading();
}

class StoreDetailsLoaded extends StoreDetailsState {
  final Store store;
  final List<Product> products;
  final List<Product> featuredProducts;
  final StoreRating rating;

  const StoreDetailsLoaded({
    required this.store,
    required this.products,
    required this.featuredProducts,
    required this.rating,
  });

  StoreDetailsLoaded copyWith({
    Store? store,
    List<Product>? products,
    List<Product>? featuredProducts,
    StoreRating? rating,
  }) {
    return StoreDetailsLoaded(
      store: store ?? this.store,
      products: products ?? this.products,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [store, products, featuredProducts, rating];
}

class StoreDetailsError extends StoreDetailsState {
  final String message;

  const StoreDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
