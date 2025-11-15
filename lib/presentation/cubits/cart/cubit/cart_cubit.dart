import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/core/result.dart';
import '../../../../domain/entities/cart.dart';
import '../../../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(CartState.initial());

  // ============================
  // LOAD CART
  // ============================
  Future<void> loadCart() async {
    emit(state.copyWith(loading: true));

    final Result<Cart> result = await repository.getCart();

    if (result.isSuccess) {
      final Cart cart = result.data;

      emit(
        state.copyWith(
          cart: cart,
          productCounts: {
            for (final item in cart.items) item.productId: item.quantity,
          },
          loading: false,
          error: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loading: false,
          error: _extractError(result),
        ),
      );
    }
  }

  // ============================
  // INCREMENT PRODUCT QUANTITY
  // ============================
  Future<void> incrementProduct(String productId) async {
    final int currentQty = state.productCounts[productId] ?? 0;

    final Result<Cart> result =
    await repository.updateQuantity(productId, currentQty + 1);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(state.copyWith(error: _extractError(result)));
    }
  }

  // ============================
  // DECREMENT PRODUCT QUANTITY
  // ============================
  Future<void> decrementProduct(String productId) async {
    final int currentQty = state.productCounts[productId] ?? 0;
    if (currentQty <= 1) return;

    final Result<Cart> result =
    await repository.updateQuantity(productId, currentQty - 1);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(state.copyWith(error: _extractError(result)));
    }
  }

  // ============================
  // ADD TO CART
  // ============================
  Future<void> addToCart(String productId) async {
    final Result<Cart> result = await repository.addToCart(
      productId: productId,
      quantity: 1,
    );

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(state.copyWith(error: _extractError(result)));
    }
  }

  // ============================
  // REMOVE ITEM
  // ============================
  Future<void> removeFromCart(String cartItemId) async {
    final Result<Cart> result = await repository.removeFromCart(cartItemId);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(state.copyWith(error: _extractError(result)));
    }
  }

  // ============================
  // INTERNAL SYNC
  // ============================
  void _syncCart(Cart cart) {
    emit(
      state.copyWith(
        cart: cart,
        productCounts: {
          for (final item in cart.items) item.productId: item.quantity,
        },
        loading: false,
        error: null,
      ),
    );
  }

  // ============================
  // ERROR EXTRACTOR (CORRECT!)
  // ============================
  String _extractError(Result result) {
    return result.failure.message;
  }
}
