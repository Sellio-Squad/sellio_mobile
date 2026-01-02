import 'package:sellio_mobile/data/mappers/order_mapper.dart';
import '../../core/error/result.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/order_remote_datasource.dart';
import '../models/order_create_item_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl({
    required OrderRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;


  String? _statusToString(OrderStatus? status) {
    return status?.name.toUpperCase();
  }

  @override
  Future<Result<void>> createOrder({
    required List<OrderItem> items
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      await _remoteDataSource.createOrder(
        items: items
            .map((item) => OrderCreateItemModel(
          productItemId: item.id,
          quantity: item.quantity,
        ))
            .toList(),
      );
    });
  }


  @override
  Future<Result<List<Order>>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Order>>(() async {
      final paginatedResponse = await _remoteDataSource.getOrders(
        status: _statusToString(status),
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<Order>> getOrderById(String orderId) async {
    return RepositoryCallHandler.call<Order>(() async {
      final orderModel = await _remoteDataSource.getOrderById(orderId);
      return orderModel.toEntity();
    });
  }

  @override
  Future<Result<Order>> cancelOrder(String orderId) async {
    return RepositoryCallHandler.call<Order>(() async {
      final orderModel = await _remoteDataSource.cancelOrder(orderId);
      return orderModel.toEntity();
    });
  }
}
