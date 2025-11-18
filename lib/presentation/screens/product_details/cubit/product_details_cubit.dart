import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';

import '../../../../domain/entities/product.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductRepository _repository;
  CartCubit _cartCubit;

  ProductDetailsCubit(this._repository, this._cartCubit) : super(ProductDetailsInitial());

  Future<void> loadProductDetails(String productId) async {
    emit(ProductDetailsLoading(productId: productId, product: Product.dummy()));
    final productResult = await _repository.getProductById(productId);
    final favoriteResult = await _repository.isFavorite(productId);

    if (productResult is Success && favoriteResult is Success) {
      emit(ProductDetailsLoading(
          product: productResult.data, isFavorite: favoriteResult.data, productId: productId));
    } else {
      final errorMessage = _extractErrorMessage([productResult]);
      emit(ProductDetailsError(message: errorMessage));
    }
  }
  final TextEditingController noteController = TextEditingController();
  void updateNote(String newNote) {
    final currentState = state;
    if (currentState is! ProductDetailsLoading) return;
    noteController.text = newNote;
    emit(currentState.copyWith(note: newNote));
  }

  void addToCart() {
    final currentState = state;
    if (currentState is! ProductDetailsLoading) return;

    final productId = currentState.product.id;
    _cartCubit.addToCart(productId);

    emit(ProductDetailsAddToCartSuccess(
      productId: currentState.productId,
      product: currentState.product,
      productCount: currentState.productCount,
      isFavorite: currentState.isFavorite,
      note: currentState.note,
      cartMessage: "Product added successfully",
    ));
  }

  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        return r.failure.message;
      }
    }
    return 'Something went wrong';
  }
}