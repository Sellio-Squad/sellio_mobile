import 'package:get_it/get_it.dart';
import 'package:seller/presentation/screens/orders/cubit/seller_orders_cubit.dart';

void initCubitDI() {
  final sl = GetIt.instance;
  sl.registerFactory(() => SellerOrdersCubit(sl()));
}
