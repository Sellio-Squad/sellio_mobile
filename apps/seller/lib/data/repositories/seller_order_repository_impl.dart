import 'package:core/core.dart';

import '../../domain/entities/seller_order.dart';
import '../../domain/repositories/seller_order_repository.dart';
import '../datasource/seller_order_datasource.dart';

class SellerOrderRepositoryImpl implements SellerOrderRepository {
  final SellerOrderDataSource _dataSource;

  SellerOrderRepositoryImpl({required SellerOrderDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Result<List<SellerOrder>>> getOrders({
    int page = 1,
    int limit = 20,
  }) {
    return RepositoryCallHandler.call<List<SellerOrder>>(() async {
      return _dataSource.getOrders(
        page: page,
        limit: limit,
      );
    });
  }
}
