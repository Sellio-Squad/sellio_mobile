import 'package:get_it/get_it.dart';
import 'package:seller/presentation/screens/orders/cubit/seller_orders_cubit.dart';

class BlocModule {
  static void register(GetIt sl) {
    sl.registerFactory(() => SellerOrdersCubit(sl()));
  }
}
