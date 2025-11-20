import '../../core/error/result.dart';
import '../entities/address.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Result<Order>> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  });

  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  });

  Future<Result<Order>> getOrderById(String orderId);

  Future<Result<Order>> cancelOrder(String orderId);
}