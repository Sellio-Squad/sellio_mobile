import 'package:equatable/equatable.dart';
import '../../../../../../domain/entities/product.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
  @override
  List<Object?> get props => [];
}

class ProductDetailsLoading extends ProductDetailsState {
  final String productId;
  final Product product;
  final int productCount;
  final bool isFavorite;
  final String note;
  final String? cartMessage;


  const ProductDetailsLoading({
    required this.productId,
    required this.product,
    this.productCount =0,
    this.isFavorite = false,
    this.note = '',
    this.cartMessage,
  });

  ProductDetailsLoading copyWith({
    String? productId,
    Product? product,
    bool? isFavorite,
    int? productCount,
    String? note,
    String? cartMessage,
  }) {
    return ProductDetailsLoading(
      productId: productId ?? this.productId,
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
      productCount: productCount ?? this.productCount,
      note: note ?? this.note,
      cartMessage: cartMessage ?? this.cartMessage,
    );
  }

  @override
  List<Object?> get props => [product, productCount, isFavorite, note , cartMessage];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  const ProductDetailsError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ProductDetailsAddToCartSuccess extends ProductDetailsLoading {
  const ProductDetailsAddToCartSuccess({
    required super.productId,
    required super.product,
    required super.productCount,
    required super.isFavorite,
    required super.note,
    required super.cartMessage,
  });
}