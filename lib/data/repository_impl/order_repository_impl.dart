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
      final order = await _remoteDataSource.createOrder(
        storeId: storeId,
        items: items,
        deliveryAddress: deliveryAddress,
        note: note,
      );

      return Success(order.toEntity());
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
      final orders = await _remoteDataSource.getOrders(
        status: status,
        page: page,
        limit: limit,
      );

      return Success(orders.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Order>> getOrderById(String orderId) async {
    try {
      final order = await _remoteDataSource.getOrderById(orderId);
      return Success(order.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Order>> cancelOrder(String orderId) async {
    try {
      final order = await _remoteDataSource.cancelOrder(orderId);
      return Success(order.toEntity());
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
