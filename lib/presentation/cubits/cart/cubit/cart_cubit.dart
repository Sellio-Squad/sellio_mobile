import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/result.dart';
import '../../../../domain/entities/cart.dart';
import '../../../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(const CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading(
      cart: state.cart,
      productCounts: state.productCounts,
    ));

    final Result<Cart> result = await repository.getCart();

    if (result.isSuccess) {
      final Cart cart = result.data;

      emit(
        CartLoaded(
          cart: cart,
          productCounts: {
            for (final item in cart.items) item.productId: item.quantity,
          },
        ),
      );
    } else {
      emit(
        CartError(
          message: _extractError(result),
          cart: state.cart,
          productCounts: state.productCounts,
        ),
      );
    }
  }

  Future<void> incrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final int currentQty = currentState.productCounts[productId] ?? 0;

    final Result<Cart> result =
    await repository.updateQuantity(productId, currentQty + 1);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(CartError(
        message: _extractError(result),
        cart: currentState.cart,
        productCounts: currentState.productCounts,
      ));
      // Restore state after showing error
      emit(currentState);
    }
  }

  Future<void> decrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final int currentQty = currentState.productCounts[productId] ?? 0;
    if (currentQty <= 1) return;

    final Result<Cart> result =
    await repository.updateQuantity(productId, currentQty - 1);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(CartError(
        message: _extractError(result),
        cart: currentState.cart,
        productCounts: currentState.productCounts,
      ));
      // Restore state after showing error
      emit(currentState);
    }
  }

  Future<void> addToCart(String productId) async {
    final Result<Cart> result = await repository.addToCart(
      productId: productId,
      quantity: 1,
    );

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(CartError(
        message: _extractError(result),
        cart: state.cart,
        productCounts: state.productCounts,
      ));

      // If we had a loaded state, restore it
      if (state.cart != null) {
        emit(CartLoaded(
          cart: state.cart!,
          productCounts: state.productCounts,
        ));
      }
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final Result<Cart> result = await repository.removeFromCart(cartItemId);

    if (result.isSuccess) {
      _syncCart(result.data);
    } else {
      emit(CartError(
        message: _extractError(result),
        cart: currentState.cart,
        productCounts: currentState.productCounts,
      ));
      // Restore state after showing error
      emit(currentState);
    }
  }

  void _syncCart(Cart cart) {
    emit(
      CartLoaded(
        cart: cart,
        productCounts: {
          for (final item in cart.items) item.productId: item.quantity,
        },
      ),
    );
  }

  String _extractError(Result result) {
    return result.failure.message;
  }
}