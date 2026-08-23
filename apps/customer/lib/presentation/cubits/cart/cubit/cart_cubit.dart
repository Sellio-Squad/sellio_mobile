import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cart.dart';
import '../../../../domain/repository/cart_repository.dart';
import '../../../../domain/repository/order_repository.dart';
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
  bool get _isLoggedIn => _authenticationCubit.state is LoggedIn;

  Future<void> _onAuthStateChanged(
      AuthenticationState authState,
      ) async {
    if (authState is LoggedIn) {
      await loadCart();
      return;
    }

    if (authState is Guest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    if (authState is AuthenticationError) {
      _emitErrorState(authState.message);
    }
  }

  Future<void> loadCart() async {
    if (!_isLoggedIn) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    emit(
      CartLoading(
        cart: state.cart,
        productCounts: state.productCounts,
      ),
    );

    final result = await _cartRepository.getCart();

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) {
        _emitErrorState(failure.message);
      },
    );
  }

  Future<bool> addToCart({
    required String productId,
    int quantity = 1,
  }) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return false;
    }

    if (quantity < 1) {
      _emitErrorState(
        'Quantity must be at least 1',
      );
      return false;
    }

    final result = await _cartRepository.addToCart(
      productId: productId,
      quantity: quantity,
    );

    return result.fold(
      onSuccess: (cart) {
        _emitLoadedState(cart);
        return true;
      },
      onFailure: (failure) {
        _emitErrorState(failure.message);
        return false;
      },
    );
  }

  Future<void> removeFromCart({
    required String itemId,
  }) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    final previousState = _currentLoadedState;

    final result = await _cartRepository.removeFromCart(
      itemId: itemId,
    );

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) {
        _handleError(
          failure.message,
          previousState,
        );
      },
    );
  }

  Future<void> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    if (quantity <= 0) {
      await removeFromCart(
        itemId: itemId,
      );
      return;
    }

    final previousState = _currentLoadedState;

    final result = await _cartRepository.updateQuantity(
      itemId: itemId,
      quantity: quantity,
    );

    result.fold(
      onSuccess: _emitLoadedState,
      onFailure: (failure) {
        _handleError(
          failure.message,
          previousState,
        );
      },
    );
  }

  Future<void> incrementProduct(
      String productId,
      ) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    final item = _findItemByProductId(
      productId,
    );

    if (item == null) {
      await addToCart(
        productId: productId,
      );
      return;
    }

    await updateQuantity(
      itemId: item.id,
      quantity: item.quantity + 1,
    );
  }

  Future<void> decrementProduct(
      String productId,
      ) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    final item = _findItemByProductId(
      productId,
    );

    if (item == null) {
      return;
    }

    if (item.quantity <= 1) {
      await removeFromCart(
        itemId: item.id,
      );
      return;
    }

    await updateQuantity(
      itemId: item.id,
      quantity: item.quantity - 1,
    );
  }

  Future<void> confirmOrder(
      String? note,
      ) async {
    if (_isGuest) {
      emit(const CartUserNotLoggedIn());
      return;
    }

    final currentCart = state.cart;

    if (currentCart == null ||
        currentCart.items.isEmpty) {
      _emitErrorState('Cart is empty');
      return;
    }

    emit(
      CartLoading(
        cart: currentCart,
        productCounts: state.productCounts,
      ),
    );

    final result = await _orderRepository.confirmOrder(
      note: note?.trim(),
    );

    await result.fold(
      onSuccess: (confirmation) async {
        // Backend confirms the order and owns cart state.
        // Refresh cart directly from backend.
        final cartResult =
        await _cartRepository.getCart();

        cartResult.fold(
          onSuccess: (updatedCart) {
            emit(
              CartOrderSuccess(
                message: confirmation.message,
                orderIds: confirmation.orderIds,
                cart: updatedCart,
                productCounts:
                _buildProductCountsMap(
                  updatedCart.items,
                ),
              ),
            );
          },
          onFailure: (_) {
            // Order confirmation succeeded.
            // A cart refresh failure should not turn the
            // successful order into an error.
            emit(
              CartOrderSuccess(
                message: confirmation.message,
                orderIds: confirmation.orderIds,
              ),
            );
          },
        );
      },
      onFailure: (failure) async {
        _emitErrorState(failure.message);
      },
    );
  }

  CartItem? _findItemByProductId(
      String productId,
      ) {
    final cart = state.cart;

    if (cart == null) {
      return null;
    }

    for (final item in cart.items) {
      if (item.productId == productId) {
        return item;
      }
    }

    return null;
  }

  CartLoaded? get _currentLoadedState {
    final currentState = state;

    if (currentState is CartLoaded) {
      return currentState;
    }

    final cart = currentState.cart;

    if (cart == null) {
      return null;
    }

    return CartLoaded(
      cart: cart,
      productCounts: currentState.productCounts,
    );
  }

  void _emitLoadedState(
      Cart cart,
      ) {
    emit(
      CartLoaded(
        cart: cart,
        productCounts:
        _buildProductCountsMap(
          cart.items,
        ),
      ),
    );
  }

  void _emitErrorState(
      String message,
      ) {
    emit(
      CartError(
        message: message,
        cart: state.cart,
        productCounts: state.productCounts,
      ),
    );
  }

  void _handleError(
      String message,
      CartLoaded? previousState,
      ) {
    emit(
      CartError(
        message: message,
        cart: previousState?.cart ?? state.cart,
        productCounts:
        previousState?.productCounts ??
            state.productCounts,
      ),
    );

    if (previousState != null) {
      emit(previousState);
    }
  }

  Map<String, int> _buildProductCountsMap(
      List<CartItem> items,
      ) {
    return {
      for (final item in items)
        item.productId: item.quantity,
    };
  }

  @override
  Future<void> close() async {
    await _authenticationSubscription.cancel();
    return super.close();
  }
}