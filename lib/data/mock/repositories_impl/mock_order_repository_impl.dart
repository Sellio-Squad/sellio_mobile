import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockOrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 700));
  }

  @override
  Future<Result<Order>> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  }) async {
    await _simulateDelay();

    if (items.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'Order must contain at least one item'),
      );
    }

    final store = MockDataGenerator.generateStore(
      index: int.tryParse(storeId.replaceAll('store_', '')) ?? 0,
    );

    final order = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_0',
      storeId: storeId,
      storeName: store.name,
      storeImage: store.profileImage,
      items: items,
      status: OrderStatus.pending,
      deliveryAddress: deliveryAddress,
      note: note,
      createdAt: DateTime.now(),
    );

    _orders.insert(0, order);
    return Success(order);
  }

  @override
  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    // If no orders exist, generate some mock ones
    if (_orders.isEmpty) {
      _orders.addAll(MockDataGenerator.generateOrders(count: 15));
    }

    var filteredOrders = _orders;

    if (status != null) {
      filteredOrders = _orders
          .where((order) => order.status == status)
          .toList();
    }

    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, filteredOrders.length);

    if (startIndex >= filteredOrders.length) {
      return const Success([]);
    }

    final paginatedOrders = filteredOrders.sublist(startIndex, endIndex);
    return Success(paginatedOrders);
  }

  @override
  Future<Result<Order>> getOrderById(String orderId) async {
    await _simulateDelay();

    final order = _orders.firstWhere(
          (o) => o.id == orderId,
      orElse: () => MockDataGenerator.generateOrder(index: 0),
    );

    return Success(order);
  }

  @override
  Future<Result<Order>> cancelOrder(String orderId) async {
    await _simulateDelay();

    final orderIndex = _orders.indexWhere((o) => o.id == orderId);

    if (orderIndex == -1) {
      return const ResultFailure(
        NotFoundFailure(message: 'Order not found'),
      );
    }

    final order = _orders[orderIndex];

    if (!order.canBeCancelled) {
      return const ResultFailure(
        ValidationFailure(message: 'Order cannot be cancelled'),
      );
    }

    final cancelledOrder = order.copyWith(status: OrderStatus.cancelled);
    _orders[orderIndex] = cancelledOrder;

    return Success(cancelledOrder);
  }
}