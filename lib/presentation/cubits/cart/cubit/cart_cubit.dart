import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/cart.dart';
import '../../../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;

  CartCubit(this._repository) : super(const CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading(
      cart: state.cart,
      productCounts: state.productCounts,
    ));

    final result = await _repository.getCart();

    result.fold(
      onSuccess: (cart) => _emitLoadedState(cart),
      onFailure: (failure) => _emitErrorState(failure.message),
    );
  }

  Future<void> addToCart({
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required String currency,
    int quantity = 1,
  }) async {
    final result = await _repository.addToCart(
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      currency: currency,
      quantity: quantity,
    );

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _emitErrorState(failure.message),
    );
  }

  Future<void> removeFromCart(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final result = await _repository.removeFromCart(productId);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> incrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final currentQty = currentState.productCounts[productId] ?? 0;

    final result = await _repository.updateQuantity(productId, currentQty + 1);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> decrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final currentQty = currentState.productCounts[productId] ?? 0;

    if (currentQty <= 1) return;

    final result = await _repository.updateQuantity(productId, currentQty - 1);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> clearCart() async {
    final result = await _repository.clearCart();

    result.fold(
      onSuccess: (_) => loadCart(),
      onFailure: (failure) => _emitErrorState(failure.message),
    );
  }

  void _emitLoadedState(Cart cart) {
    emit(CartLoaded(
      cart: cart,
      productCounts: _buildProductCountsMap(cart.items),
    ));
  }

  void _emitErrorState(String message) {
    emit(CartError(
      message: message,
      cart: state.cart,
      productCounts: state.productCounts,
    ));
  }

  void _handleError(String message, CartLoaded previousState) {
    emit(CartError(
      message: message,
      cart: previousState.cart,
      productCounts: previousState.productCounts,
    ));
    emit(previousState);
  }

  Map<String, int> _buildProductCountsMap(List items) {
    return {
      for (final item in items) item.productId: item.quantity,
    };
  }
}