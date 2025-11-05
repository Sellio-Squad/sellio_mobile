import '../entities/order.dart';
import '../entities/address.dart';

abstract class OrderRepository {
  /// Create new order
  Future<Order> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  });

  /// Get all user orders
  Future<List<Order>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  });

  /// Get order details by ID
  Future<Order> getOrderById(String orderId);

  /// Cancel order
  Future<Order> cancelOrder(String orderId);
}