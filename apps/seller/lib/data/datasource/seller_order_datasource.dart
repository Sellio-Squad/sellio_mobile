import '../../domain/entity/seller_order.dart';

abstract class SellerOrderDataSource {
  Future<List<SellerOrder>> getOrders({
    int page = 1,
    int limit = 20,
  });
}
