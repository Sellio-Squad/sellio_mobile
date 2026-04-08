import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

import '../../../../domain/entities/cart.dart';
import '../../../../domain/entities/order.dart';
import '../../../../domain/repositories/cart_repository.dart';
import '../../../../domain/repositories/order_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;
  final AuthenticationCubit _authenticationCubit;
  late final StreamSubscription _authenticationSubscription;

  CartCubit({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
    required AuthenticationCubit authenticationCubit,
  })  : _cartRepository = cartRepository,
        _orderRepository = orderRepository,
        _authenticationCubit = authenticationCubit,
        super(const CartInitial()) {
    _authenticationSubscription =
        _authenticationCubit.stream.listen(_onAuthStateChanged);
    _onAuthStateChanged(_authenticationCubit.state);
  }

  bool get _isGuest => _authenticationCubit.state is Guest;

  Future<void> _onAuthStateChanged(AuthenticationState authState) async {
    if (authState is LoggedIn) {
      await loadCart();
      return;
    }

    if (authState is AuthenticationError) {
      _emitErrorState(authState.message);
    }
  }

  Future<void> loadCart() async {
    emit(CartLoading(
      cart: state.cart,
      productCounts: state.productCounts,
    ));

    final result = await _cartRepository.getCart();

    result.fold(
      onSuccess: _emitLoadedState,
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
    final result = await _cartRepository.addToCart(
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
    final result = await _cartRepository.removeFromCart(productId);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> incrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final currentQty = currentState.productCounts[productId] ?? 0;

    final result =
        await _cartRepository.updateQuantity(productId, currentQty + 1);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> decrementProduct(String productId) async {
    if (state is! CartLoaded) return;

    final currentState = state as CartLoaded;
    final currentQty = currentState.productCounts[productId] ?? 0;

    final result = currentQty <= 1
        ? await _cartRepository.removeFromCart(productId)
        : await _cartRepository.updateQuantity(productId, currentQty - 1);

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) => _handleError(failure.message, currentState),
    );
  }

  Future<void> confirmOrder(String? note) async {
    if (_isGuest) {
      _emitErrorState('Login required');
      return;
    }

    if (state.cart == null || state.cart!.items.isEmpty) {
      _emitErrorState('Cart is empty');
      return;
    }

    emit(CartLoading(
      cart: state.cart,
      productCounts: state.productCounts,
    ));

    final orderItems = state.cart!.items.map((cartItem) {
      return OrderItem(
        id: cartItem.id,
        productId: cartItem.productId,
        productName: cartItem.productName,
        quantity: cartItem.quantity,
        price: cartItem.price,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }).toList();

    final result = await _orderRepository.createOrder(items: orderItems);

    await result.fold(
      onSuccess: (_) async {
        await _cartRepository.clearCart();
        emit(const CartOrderSuccess());
      },
      onFailure: (failure) {
        _emitErrorState(failure.message);
      },
    );
  }

  Future<void> clearCart() async {
    final result = await _cartRepository.clearCart();

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

  @override
  Future<void> close() async {
    await _authenticationSubscription.cancel();
    return super.close();
  }
}