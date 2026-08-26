import 'package:core/core.dart';

import '../entities/OrderConfirmation.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Result<OrderConfirmation>> confirmOrder({
    String? note,
  });

  Future<Result<List<Order>>> getOrderHistory({
    OrderStatus? status,
    int page = 0,
    int pageSize = 10,
    List<String> sort = const [
      'createdAt,DESC',
    ],
  });

  Future<Result<void>> cancelOrder({
    required String orderId,
  });
}