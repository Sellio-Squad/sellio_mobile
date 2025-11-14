import 'package:equatable/equatable.dart';
import '../../../../domain/entities/cart.dart';

class CartState extends Equatable {
  final Cart? cart;
  final Map<String, int> productCounts;
  final bool loading;
  final String? error;

  const CartState({
    this.cart,
    required this.productCounts,
    this.loading = false,
    this.error,
  });

  factory CartState.initial() {
    return const CartState(
      cart: null,
      productCounts: {},
      loading: false,
      error: null,
    );
  }

  CartState copyWith({
    Cart? cart,
    Map<String, int>? productCounts,
    bool? loading,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      productCounts: productCounts ?? this.productCounts,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [cart, productCounts, loading, error];
}
