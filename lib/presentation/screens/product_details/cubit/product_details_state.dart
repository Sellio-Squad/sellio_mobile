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

  const ProductDetailsLoading({
    required this.productId,
    required this.product,
    this.productCount =0,
    this.isFavorite = false,
    this.note = '',
  });

  ProductDetailsLoading copyWith({
    String? productId,
    Product? product,
    bool? isFavorite,
    int? productCount,
    String? note,
  }) {
    return ProductDetailsLoading(
      productId: productId ?? this.productId,
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
      productCount: productCount ?? this.productCount,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [product, productCount, isFavorite, note];
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
  });
}


// class ProductDetailsState{
//   final String productName;
//   final bool? isFavorite;
//   final String productDescription;
//   final double productPrice;
//   final double? productPriceBeforeDiscount;
//   final int productCount;
//   final String? note;
//
//   ProductDetailsState({
//     required this.productName,
//     this.isFavorite,
//     required this.productDescription,
//     required this.productPrice,
//     this.productPriceBeforeDiscount,
//     required this.productCount,
//     this.note,
// });
//   ProductDetailsState copyWith({
//     String? productName,
//     bool? isFavorite,
//     String? productDescription,
//     double? productPrice,
//     double? productPriceBeforeDiscount,
//     int? productCount,
//     String? note,
// }){
//     return ProductDetailsState(
//       productName: productName ?? this.productName,
//       isFavorite: isFavorite ?? this.isFavorite,
//       productDescription: productDescription ?? this.productDescription,
//       productPrice: productPrice ?? this.productPrice,
//       productPriceBeforeDiscount: productPriceBeforeDiscount ?? this.productPriceBeforeDiscount,
//       productCount: productCount ?? this.productCount,
//       note: note ?? this.note,
//     );
//   }
// }