import 'package:sellio_mobile/data/mappers/order_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl({
    required OrderRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<Order>> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  }) async {
    return RepositoryCallHandler.call<Order>(() async {
      final orderItems = items
          .map((item) => OrderItemModel(
        id: item.id,
        productId: item.productId,
        productName: item.productName,
        productImage: item.productImage,
        price: item.price,
        quantity: item.quantity,
      ))
          .toList();

      final orderModel = await _remoteDataSource.createOrder(
        storeId: storeId,
        items: orderItems,
        addressId: deliveryAddress.id,
        note: note,
      );

      return orderModel.toEntity();
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
        status: status,
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data
          .map((model) => model.toEntity())
          .toList();
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