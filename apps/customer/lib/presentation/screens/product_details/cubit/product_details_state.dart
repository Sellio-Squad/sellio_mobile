import 'package:equatable/equatable.dart';
import '../../../../../../domain/entities/product.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  final String productId;

  const ProductDetailsLoading({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class ProductDetailsLoaded extends ProductDetailsState {
  final Product product;
  final int productCount;
  final bool isFavorite;
  final String note;
  final String? cartMessage;

  const ProductDetailsLoaded({
    required this.product,
    this.productCount = 0,
    this.isFavorite = false,
    this.note = '',
    this.cartMessage,
  });

  ProductDetailsLoaded copyWith({
    Product? product,
    int? productCount,
    bool? isFavorite,
    String? note,
    String? cartMessage,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      productCount: productCount ?? this.productCount,
      isFavorite: isFavorite ?? this.isFavorite,
      note: note ?? this.note,
      cartMessage: cartMessage ?? this.cartMessage,
    );
  }

  @override
  List<Object?> get props => [product, productCount, isFavorite, note, cartMessage];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductDetailsAddToCartSuccess extends ProductDetailsLoaded {
  const ProductDetailsAddToCartSuccess({
    required super.product,
    required super.productCount,
    required super.isFavorite,
    required super.note,
    required super.cartMessage,
  });
}
