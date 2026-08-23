import 'package:core/error/result.dart';

import '../entity/seller_order.dart';

abstract class SellerOrderRepository {
  Future<Result<List<SellerOrder>>> getOrders({
    int page = 1,
    int limit = 20,
  });
}
