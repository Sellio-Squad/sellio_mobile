import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;
  final CartCubit _cartCubit;

  ProductDetailsCubit(
      this._repository,
      this._cartCubit,
      ) : super(const ProductDetailsInitial());

  final TextEditingController noteController = TextEditingController();

  // ---------------------------------------------------------
  // LOAD PRODUCT DETAILS
  // ---------------------------------------------------------
  Future<void> loadProductDetails(String productId) async {
    debugPrint('Loading product details for productId: $productId');
    emit(ProductDetailsLoading(productId: productId));

    final productResult = await _repository.getProductById(productId);
    final favoriteResult = await _repository.isFavorite(productId);

    debugPrint('Product result: $productResult');
    debugPrint('Favorite result: $favoriteResult');

    if (productResult is Success) {
      // If favorites check fails, default to false - it shouldn't block product loading
      final isFavorite = favoriteResult is Success ? favoriteResult.data : false;
      
      final cartState = _cartCubit.state;
      final count = cartState.productCounts[productId] ?? 0;

      debugPrint('Cart count for productId $productId: $count');

      emit(ProductDetailsLoaded(
        product: productResult.data,
        isFavorite: isFavorite,
        productCount: count,
        note: noteController.text,
      ));

      debugPrint('ProductDetailsLoaded emitted with product: ${productResult.data}');
    } else {
      final errorMessage = _extractErrorMessage([productResult]);
      debugPrint('Error loading product details: $errorMessage');
      emit(ProductDetailsError(message: errorMessage));
    }
  }

  // ---------------------------------------------------------
  // UPDATE NOTE
  // ---------------------------------------------------------
  void updateNote(String newNote) {
    debugPrint('Updating note to: $newNote');
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    noteController.text = newNote;
    emit(currentState.copyWith(note: newNote));
    debugPrint('Note updated, new state: $currentState');
  }

  // ---------------------------------------------------------
  // ADD TO CART
  // ---------------------------------------------------------
  void addToCart() {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;

    final product = currentState.product;
    debugPrint('Adding product to cart: ${product.title}');

    // Get product image, use empty string if no images available
    final productImage = product.images.isNotEmpty ? product.images.first : '';

    _cartCubit.addToCart(
      productId: product.id,
      productName: product.title,
      productImage: productImage,
      price: product.price,
      currency: product.currency,
      quantity: 1,
    );

    // 🔥 1) Emit SIDE EFFECT
    emit(const ProductDetailsAddToCartSuccess(
      message: 'Product added successfully',
    ));
    debugPrint('ProductDetailsAddToCartSuccess emitted');

    // 🔥 2) Re-emit UI state to keep screen stable
    emit(currentState.copyWith(
      productCount: currentState.productCount + 1,
    ));
    debugPrint('Product count incremented, new state: $currentState');
  }

  // ---------------------------------------------------------
  // ERROR HANDLING
  // ---------------------------------------------------------
  String _extractErrorMessage(List<Result> results) {
    for (final result in results) {
      if (result is ResultFailure) {
        debugPrint('Error result: ${result.failure.message}');
        return result.failure.message;
      }
    }
    return 'Something went wrong';
  }

  @override
  Future<void> close() {
    debugPrint('Closing ProductDetailsCubit');
    noteController.dispose();
    return super.close();
  }
}
