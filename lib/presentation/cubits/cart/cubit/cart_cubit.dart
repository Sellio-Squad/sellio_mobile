import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(const CartState());

  Future<void> loadCart() async {
    try {
      final cart = await _cartRepository.getCart();

      emit(CartState(
          productCounts: cart.data.items
              .asMap()
              .map((_, item) => MapEntry(item.productId, item.quantity))));
    } catch (e) {
      print('Error loading cart: $e');
      // Handle error
    }
  }

  Future<void> incrementProduct(String productId) async {
    final currentCount = state.productCounts[productId] ?? 0;
    final updatedCounts = Map<String, int>.from(state.productCounts);
    updatedCounts[productId] = currentCount + 1;

    // Optimistic update
    emit(state.copyWith(productCounts: updatedCounts));

    try {
      await _cartRepository.updateQuantity(
          productId, updatedCounts[productId]!);
    } catch (e) {
      // Rollback on error
      emit(state);
      print('Error incrementing product: $e');
    }
  }

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

    // Optimistic update
    emit(state.copyWith(productCounts: updatedCounts));

    try {
      if (newCount == 0) {
        await _cartRepository.removeFromCart(productId);
      } else {
        await _cartRepository.updateQuantity(productId, newCount);
      }
    } catch (e) {
      // Rollback on error
      emit(state);
      print('Error decrementing product: $e');
    }
  }

  int getProductCount(String productId) {
    return state.productCounts[productId] ?? 0;
  }
}
