import 'package:get_it/get_it.dart';
import 'package:seller/presentation/screen/create_product/cubit/create_product_cubit.dart';
import 'package:seller/presentation/screen/orders/cubit/seller_orders_cubit.dart';

import '../../data/datasource/fake/fake_create_product_datasource.dart';

class BlocModule {
  static void register(GetIt sl) {
    sl.registerFactory(() => SellerOrdersCubit(sl()));
    sl.registerFactory(() => CreateProductCubit(
          productRepository: sl(),
          authCubit: sl(),
          metadataDataSource: sl<FakeCreateProductDataSource>(),
        ));
  }
}
