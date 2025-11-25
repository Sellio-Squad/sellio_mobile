import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';


class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;
  final CartCubit _cartCubit;

  ProductDetailsCubit(this._repository, this._cartCubit)
      : super(const ProductDetailsInitial());

  final TextEditingController noteController = TextEditingController();

  Future<void> loadProductDetails(String productId) async {
    emit(ProductDetailsLoading(productId: productId));

    final productResult = await _repository.getProductById(productId);
    final favoriteResult = await _repository.isFavorite(productId);

    if (productResult is Success && favoriteResult is Success) {

      final cartState = _cartCubit.state;
      int count = 0;
      count = cartState.productCounts[productId] ?? 0;

      emit(ProductDetailsLoaded(
        product: productResult.data,
        isFavorite: favoriteResult.data,
        productCount: count,
      ));
    } else {
      final errorMessage = _extractErrorMessage([productResult, favoriteResult]);
      emit(ProductDetailsError(message: errorMessage));
    }
  }

  // ---------------------------------------------------------
  // UPDATE NOTE
  // ---------------------------------------------------------
  void updateNote(String newNote) {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    noteController.text = newNote;
    emit(currentState.copyWith(note: newNote));
  }

  // ---------------------------------------------------------
  // ADD TO CART
  // ---------------------------------------------------------
  void addToCart() {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    final productId = currentState.product.id;

    _cartCubit.addToCart(productId);

    emit(ProductDetailsAddToCartSuccess(
      product: currentState.product,
      productCount: currentState.productCount + 1,
      isFavorite: currentState.isFavorite,
      note: currentState.note,
      cartMessage: "Product added successfully",
    ));
  }

  // ---------------------------------------------------------
  // ERROR HANDLING
  // ---------------------------------------------------------
  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        return r.failure.message;
      }
    }
    return 'Something went wrong';
  }
}
