import 'package:equatable/equatable.dart';

import '../../../../../../domain/entities/product.dart';
import '../../../../../../domain/entities/product_review.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

// -------------------- UI STATES --------------------

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
  final List<ProductReview> reviews;
  final bool isLoadingReviews;
  final String? reviewsError;

  const ProductDetailsLoaded({
    required this.product,
    this.productCount = 0,
    this.isFavorite = false,
    this.note = '',
    this.reviews = const [],
    this.isLoadingReviews = false,
    this.reviewsError,
  });

  ProductDetailsLoaded copyWith({
    Product? product,
    int? productCount,
    bool? isFavorite,
    String? note,
    List<ProductReview>? reviews,
    bool? isLoadingReviews,
    String? reviewsError,
  }) {
    return ProductDetailsLoaded(
      product: product ?? this.product,
      productCount: productCount ?? this.productCount,
      isFavorite: isFavorite ?? this.isFavorite,
      note: note ?? this.note,
      reviews: reviews ?? this.reviews,
      isLoadingReviews: isLoadingReviews ?? this.isLoadingReviews,
      reviewsError: reviewsError ?? this.reviewsError,
    );
  }

  @override
  List<Object?> get props => [
        product,
        productCount,
        isFavorite,
        note,
        reviews,
        isLoadingReviews,
        reviewsError,
      ];
}

// -------------------- SIDE EFFECT STATES --------------------

class ProductDetailsAddToCartSuccess extends ProductDetailsState {
  final String message;

  const ProductDetailsAddToCartSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}