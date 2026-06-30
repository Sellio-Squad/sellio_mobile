import '../../../domain/entities/seller_order.dart';
import '../../fake/seller_order_fake_data.dart';
import '../seller_order_datasource.dart';

class SellerOrderFakeDataSource implements SellerOrderDataSource {
  final List<SellerOrder> _orders =
      SellerOrderFakeData.generateOrders(count: 12);

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<List<SellerOrder>> getOrders({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final startIndex = (page - 1) * limit;
    if (startIndex >= _orders.length) {
      return [];
    }

    final endIndex = (startIndex + limit).clamp(0, _orders.length);
    return _orders.sublist(startIndex, endIndex);
  }
}
