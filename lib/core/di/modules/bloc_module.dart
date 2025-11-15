import 'package:get_it/get_it.dart';

import '../../../presentation/cubits/cart/cubit/cart_cubit.dart';
import '../../../presentation/cubits/favorites/cubit/favorites_cubit.dart';
import '../../../presentation/cubits/user/cubit/user_cubit.dart';
import '../../../presentation/screens/home/cubits/categories/cubit/home_categories_cubit.dart';
import '../../../presentation/screens/home/cubits/offers/cubit/home_special_offers_cubit.dart';
import '../../../presentation/screens/home/cubits/products/cubit/home_trending_products_cubit.dart';
import '../../../presentation/screens/home/cubits/stores/cubit/home_top_stores_cubit.dart';
import '../../../presentation/screens/order_history/cubit/order_history_cubit.dart';

class BlocModule {
  static void register(GetIt sl) {
    sl.registerFactory(() => CartCubit(sl())..loadCart());
    sl.registerFactory(() => FavoritesCubit(sl())..loadFavorites());
    sl.registerFactory(() => UserCubit(sl())..loadUserInfo());
    sl.registerFactory(() => OrderHistoryCubit(sl())..loadOrders());
    sl.registerFactory(() => HomeCategoriesCubit(sl()));
    sl.registerFactory(() => HomeTrendingProductsCubit(sl()));
    sl.registerFactory(() => HomeTopStoresCubit(sl()));
    sl.registerFactory(() => HomeSpecialOffersCubit(sl()));
  }
}
