import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/cart.dart';
import '../../../domain/repositories/cart_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockCartRepositoryImpl implements CartRepository {
  Cart _cart = MockDataGenerator.generateCart(itemCount: 0);

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _recalculateTotal() {
    final total = _cart.items.fold<double>(
      0,
          (sum, item) => sum + item.totalPrice,
    );
    _cart = _cart.copyWith(totalPrice: total);
  }

  @override
  Future<Result<Cart>> getCart() async {
    await _simulateDelay();
    return Success(_cart);
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    await _simulateDelay();

    if (quantity <= 0) {
      return const ResultFailure(
        ValidationFailure(message: 'Quantity must be greater than 0'),
      );
    }

    // Check if product already exists in cart
    final existingIndex = _cart.items.indexWhere(
          (item) => item.productId == productId,
    );

    if (existingIndex != -1) {
      // Update quantity
      final updatedItems = List<CartItem>.from(_cart.items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
      _cart = _cart.copyWith(items: updatedItems);
    } else {
      // Add new item
      final product = MockDataGenerator.generateProduct(
        index: int.tryParse(productId.replaceAll('product_', '')) ?? 0,
      );

      final newItem = CartItem(
        id: 'cart_item_${DateTime.now().millisecondsSinceEpoch}',
        productId: productId,
        productName: product.name,
        productImage: product.images.first,
        price: product.price,
        quantity: quantity,
        currency: product.currency,
      );

      _cart = _cart.copyWith(
        items: [..._cart.items, newItem],
      );
    }

    _recalculateTotal();
    return Success(_cart);
  }

  @override
  Future<Result<Cart>> removeFromCart(String cartItemId) async {
    await _simulateDelay();

    final updatedItems = _cart.items
        .where((item) => item.id != cartItemId)
        .toList();

    if (updatedItems.length == _cart.items.length) {
      return const ResultFailure(
        NotFoundFailure(message: 'Cart item not found'),
      );
    }

    _cart = _cart.copyWith(items: updatedItems);
    _recalculateTotal();

    return Success(_cart);
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    await _simulateDelay();

    if (quantity < 0) {
      return const ResultFailure(
        ValidationFailure(message: 'Quantity cannot be negative'),
      );
    }

    final itemIndex = _cart.items.indexWhere(
          (item) => item.productId == productId,
    );

    if (itemIndex == -1) {
      return const ResultFailure(
        NotFoundFailure(message: 'Product not found in cart'),
      );
    }

    if (quantity == 0) {
      // Remove item if quantity is 0
      final updatedItems = List<CartItem>.from(_cart.items)..removeAt(itemIndex);
      _cart = _cart.copyWith(items: updatedItems);
    } else {
      // Update quantity
      final updatedItems = List<CartItem>.from(_cart.items);
      updatedItems[itemIndex] = updatedItems[itemIndex].copyWith(
        quantity: quantity,
      );
      _cart = _cart.copyWith(items: updatedItems);
    }

    _recalculateTotal();
    return Success(_cart);
  }
}