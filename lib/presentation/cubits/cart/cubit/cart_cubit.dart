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
    final currentCount = state.productCounts[productId] ?? 0;
    final updatedCounts = Map<String, int>.from(state.productCounts);
    updatedCounts[productId] = currentCount + 1;

    emit(state.copyWith(productCounts: updatedCounts));

    try {
      await repository.updateQuantity(productId, updatedCounts[productId]!);
    } catch (e) {
      emit(state);
      print('Error incrementing product: $e');
    }
  }

  // ============================
  // DECREMENT PRODUCT QUANTITY
  // ============================
  Future<void> decrementProduct(String productId) async {
    final currentCount = state.productCounts[productId] ?? 0;
    if (currentCount <= 0) return;

    final updatedCounts = Map<String, int>.from(state.productCounts);
    final newCount = currentCount - 1;

    if (newCount == 0) {
      updatedCounts.remove(productId);
    } else {
      updatedCounts[productId] = newCount;
    }

    emit(state.copyWith(productCounts: updatedCounts));

    try {
      if (newCount == 0) {
        await repository.removeFromCart(productId);
      } else {
        await repository.updateQuantity(productId, newCount);
      }
    } catch (e) {
      emit(state);
      print('Error decrementing product: $e');
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