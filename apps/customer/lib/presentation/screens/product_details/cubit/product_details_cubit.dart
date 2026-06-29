import 'package:core/error/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import '../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../cubits/favorites/cubit/favorites_state.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;
  final CartCubit _cartCubit;
  final FavoritesCubit _favoritesCubit;

  ProductDetailsCubit(
    this._repository,
    this._cartCubit,
    this._favoritesCubit,
  ) : super(const ProductDetailsInitial());

  final TextEditingController noteController = TextEditingController();

  Future<void> loadProductDetails(String productId) async {
    debugPrint('Loading product details for productId: $productId');
    emit(ProductDetailsLoading(productId: productId));

    final productResult = await _repository.getProductById(productId);

    productResult.fold(
      onSuccess: (product) {
        final product = productResult.data;
        final cartState = _cartCubit.state;
        final count = cartState.productCounts[productId] ?? 0;

        final favState = _favoritesCubit.state;
        final isFavorite = favState is FavoritesLoaded &&
            favState.favoriteProductIds.contains(productId);

        emit(ProductDetailsLoaded(
          product: product,
          isFavorite: isFavorite,
          productCount: count,
          note: noteController.text,
        ));
      },
      onFailure: (error) => {
        emit(ProductDetailsError(
          message: error.message,
        )),
      },
    );
  }

  void updateNote(String newNote) {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    noteController.text = newNote;
    emit(currentState.copyWith(note: newNote));
  }

  void toggleFavorite() async {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    final result = await _favoritesCubit.toggleFavorite(
        currentState.product.id, FavoriteType.product);
    if (!result) return;

    final updatedFavorite = !currentState.isFavorite;
    emit(currentState.copyWith(isFavorite: updatedFavorite));
  }

  void addToCart() {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    final product = currentState.product;
    final productImage = product.images.isNotEmpty ? product.images.first : '';

    _cartCubit.addToCart(
      productId: product.id,
      productName: product.title,
      productImage: productImage,
      price: product.minPrice,
      currency: product.currency,
      quantity: 1,
    );

    emit(const ProductDetailsAddToCartSuccess(
      message: 'Product added successfully',
    ));

    emit(currentState.copyWith(productCount: currentState.productCount + 1));
  }

  String _extractErrorMessage(List results) {
    for (final result in results) {
      if (result is! Success) {
        return "Something went wrong";
      }
    }
    return 'Something went wrong';
  }

  @override
  Future<void> close() {
    noteController.dispose();
    return super.close();
  }
}
