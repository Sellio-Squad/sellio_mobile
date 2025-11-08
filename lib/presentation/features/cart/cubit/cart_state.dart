import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final Map<String, int> productCounts;

  const CartState({
    this.productCounts = const {},
  });

  CartState copyWith({
    Map<String, int>? productCounts,
  }) {
    return CartState(
      productCounts: productCounts ?? this.productCounts,
    );
  }

  @override
  List<Object?> get props => [productCounts];
}