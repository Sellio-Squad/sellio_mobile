import 'package:equatable/equatable.dart';

import '../../../../domain/entities/cart.dart';

abstract class CartState extends Equatable {
  final Cart? cart;
  final Map<String, int> productCounts;

  const CartState({
    this.cart,
    this.productCounts = const {},
  });

  @override
  List<Object?> get props => [cart, productCounts];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading({
    super.cart,
    super.productCounts,
  });
}

class CartLoaded extends CartState {
  const CartLoaded({
    required Cart super.cart,
    required super.productCounts,
  });

  CartLoaded copyWith({
    Cart? cart,
    Map<String, int>? productCounts,
  }) {
    return CartLoaded(
      cart: cart ?? this.cart!,
      productCounts: productCounts ?? this.productCounts,
    );
  }
}
class CartError extends CartState {
  final String message;
  final int errorId;

  CartError({
    required this.message,
    super.cart,
    super.productCounts,
  }) : errorId = DateTime.now().microsecondsSinceEpoch;

  @override
  List<Object?> get props => [
    message,
    errorId,
    cart,
    productCounts,
  ];
}

class CartOrderSuccess extends CartState {
  final String message;
  final List<String> orderIds;

  const CartOrderSuccess({
    required this.message,
    required this.orderIds,
    super.cart,
    super.productCounts,
  });

  @override
  List<Object?> get props => [
    message,
    orderIds,
    cart,
    productCounts,
  ];
}

class CartUserNotLoggedIn extends CartState {
  const CartUserNotLoggedIn();
}
