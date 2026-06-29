import 'package:core/error/result.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Result<void>> createOrder({
    required List<OrderItem> items,
  });

  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  });

  Future<Result<Order>> getOrderById(String orderId);

  Future<Result<Order>> cancelOrder(String orderId);
}
