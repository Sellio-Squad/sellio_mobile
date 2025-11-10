import '../core/result.dart';
import '../entities/address.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  /// Create new order
  Future<Result<Order>> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  });

  /// Get all user orders
  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  });

  /// Get order details by ID
  Future<Result<Order>> getOrderById(String orderId);

  /// Cancel order
  Future<Result<Order>> cancelOrder(String orderId);
}