import '../../domain/entities/cart.dart';

class PriceCalculator {
  static double calculateTotalPrice(List<CartItem> items) {
    return items.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  static String formatPrice(double price, {int decimals = 2}) {
    return price.toStringAsFixed(decimals);
  }

  static int getTotalItemCount(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}