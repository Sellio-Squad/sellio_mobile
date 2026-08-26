import 'package:get_it/get_it.dart';
import 'package:seller/data/datasource/fake/fake_create_product_datasource.dart';
import 'package:seller/presentation/screen/create_product/cubit/create_product_cubit.dart';
import 'package:seller/presentation/screen/main/cubit/store_cubit.dart';
import 'package:seller/presentation/screen/orders/cubit/seller_orders_cubit.dart';
import 'package:seller/presentation/screen/products/cubit/product_list_cubit.dart';

void initCubitDI(GetIt sl) {
  sl.registerFactory(() => SellerOrdersCubit(sl()));
  sl.registerFactory(() => ProductListCubit(sl()));
  sl.registerLazySingleton(() => StoreCubit(sl(), sl()));
  sl.registerFactory(
    () => CreateProductCubit(
      productRepository: sl(),
      storeRepository: sl(),
      authCubit: sl(),
      metadataDataSource: sl<FakeCreateProductDataSource>(),
    ),
  );
}
