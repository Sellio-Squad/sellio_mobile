import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/remote/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Order>> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  }) async {
    try {
      // Real implementation commented for now
      // final order = await _remoteDataSource.createOrder(
      //   storeId: storeId,
      //   items: items,
      //   deliveryAddress: deliveryAddress,
      //   note: note,
      // );
      // return Success(order.toEntity());

      // Fake order for testing
      final order = Order(
        id: 'fake123',
        userId: 'user123',
        storeId: storeId,
        storeName: 'Fake Store',
        storeImage: '',
        items: items,
        status: OrderStatus.processing,
        deliveryAddress: deliveryAddress,
        note: note,
        createdAt: DateTime.now(),
      );

      return Success(order);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Real remote call commented for now
      // final orders = await _remoteDataSource.getOrders(
      //   status: status,
      //   page: page,
      //   limit: limit,
      // );
      // return Success(orders.map((model) => model.toEntity()).toList());

      // Dummy orders for testing
      final dummyOrders = List.generate(5, (index) {
        final orderStatus = OrderStatus.values[index % OrderStatus.values.length];

        // Apply filtering if status is passed
        if (status != null && status != orderStatus) return null;

        return Order(
          id: 'order_$index',
          userId: 'user_$index',
          storeId: 'store_$index',
          storeName: 'Store $index',
          storeImage: '',
          items: List.generate(2, (itemIndex) {
            return OrderItem(
              id: 'item_${index}_$itemIndex',
              productId: 'product_$itemIndex',
              productName: 'Product $itemIndex',
              productImage: '',
              price: 10.0 + itemIndex,
              quantity: itemIndex + 1,
            );
          }),
          status: orderStatus,
          deliveryAddress: Address.dummy(index: index),
          note: 'Note $index',
          createdAt: DateTime.now().subtract(Duration(days: index)),
        );
      }).whereType<Order>().toList(); // remove nulls if filtered out

      return Success(dummyOrders);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Order>> getOrderById(String orderId) async {
    try {
      // Real implementation commented
      // final order = await _remoteDataSource.getOrderById(orderId);
      // return Success(order.toEntity());

      // Dummy order
      final order = Order(
        id: orderId,
        userId: 'user123',
        storeId: 'store123',
        storeName: 'Fake Store',
        storeImage: '',
        items: [],
        status: OrderStatus.completed,
        deliveryAddress: Address.dummy(index: 0),
        note: null,
        createdAt: DateTime.now(),
      );

      return Success(order);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Order>> cancelOrder(String orderId) async {
    try {
      // Real implementation commented
      // final order = await _remoteDataSource.cancelOrder(orderId);
      // return Success(order.toEntity());

      // Dummy cancelled order
      final order = Order(
        id: orderId,
        userId: 'user123',
        storeId: 'store123',
        storeName: 'Fake Store',
        storeImage: '',
        items: [],
        status: OrderStatus.cancelled,
        deliveryAddress: Address.dummy(index: 0),
        note: null,
        createdAt: DateTime.now(),
      );

      return Success(order);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet connection') ||
        message.contains('Connection timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }
}
