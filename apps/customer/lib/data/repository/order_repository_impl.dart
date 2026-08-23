import 'package:core/core.dart';

import '../../domain/entities/OrderConfirmation.dart';
import '../../domain/entities/order.dart';
import '../../domain/repository/order_repository.dart';
import '../datasource/remote/order_remote_datasource.dart';
import '../mappers/order_mapper.dart';

class OrderRepositoryImpl
    implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl({
    required OrderRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  String? _statusToString(
      OrderStatus? status,
      ) {
    switch (status) {
      case OrderStatus.processing:
        return 'PROCESSING';

      case OrderStatus.completed:
        return 'COMPLETED';

      case OrderStatus.cancelled:
        return 'CANCELLED';

      case null:
        return null;
    }
  }

  @override
  Future<Result<OrderConfirmation>> confirmOrder({
    String? note,
  }) {
    return RepositoryCallHandler.call<
        OrderConfirmation>(() async {
      final response =
      await _remoteDataSource.confirmOrder(
        note: note,
      );

      return response.toEntity();
    });
  }

  @override
  Future<Result<List<Order>>> getOrderHistory({
    OrderStatus? status,
    int page = 0,
    int pageSize = 10,
    List<String> sort = const [
      'createdAt,DESC',
    ],
  }) {
    return RepositoryCallHandler.call<
        List<Order>>(() async {
      final response =
      await _remoteDataSource.getOrderHistory(
        status: _statusToString(status),
        page: page,
        pageSize: pageSize,
        sort: sort,
      );

      return response.data
          .map(
            (model) => model.toEntity(),
      )
          .toList();
    });
  }

  @override
  Future<Result<void>> cancelOrder({
    required String orderId,
  }) {
    return RepositoryCallHandler.call<void>(() async {
      await _remoteDataSource.cancelOrder(
        orderId: orderId,
      );

      return;
    });
  }
}