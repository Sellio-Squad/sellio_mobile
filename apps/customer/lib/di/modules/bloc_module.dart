import 'package:get_it/get_it.dart';
import 'package:sellio_mobile/presentation/screens/account/cubit/account_cubit.dart';
import '../../../presentation/cubits/cart/cubit/cart_cubit.dart';
import '../../../presentation/cubits/favorites/cubit/favorites_cubit.dart';
import '../../../presentation/screens/home/sections/special_offers/cubit/home_special_offers_cubit.dart';
import '../../../presentation/screens/home/sections/top_stores/cubit/home_top_stores_cubit.dart';
import '../../../presentation/screens/home/sections/trending_products/cubit/home_trending_products_cubit.dart';
import '../../../presentation/screens/notification/cubits/notifications/cubit/notification_cubit.dart';
import '../../../presentation/screens/order_history/cubit/order_history_cubit.dart';
import '../../presentation/screens/home/sections/categories/cubit/categories_cubit.dart';
import '../../presentation/screens/product_details/cubit/product_details_cubit.dart';

import '../../../presentation/screens/home/cubit/home_sections_cubit.dart';

class BlocModule {
  static void register(GetIt sl) {
    sl.registerFactory(() => HomeSectionsCubit(sl()));

    sl.registerFactory(() => CartCubit(
          cartRepository: sl(),
          orderRepository: sl(),
          authenticationCubit: sl(),
        ));
    sl.registerFactory(() => FavoritesCubit(sl(), sl()));
    sl.registerFactory(() => OrderHistoryCubit(sl()));
    sl.registerFactory(() => HomeTrendingProductsCubit(sl(), sl()));
    sl.registerFactory(() => HomeTopStoresCubit(sl()));
    sl.registerFactory(() => HomeSpecialOffersCubit(sl()));
    sl.registerFactory(() => NotificationCubit(sl()));
    sl.registerFactory(() => ProductDetailsCubit(sl(), sl(), sl()));
    sl.registerFactory(() => AccountCubit(sl(), sl()));
    sl.registerFactory(() => CategoriesCubit(sl()));
  }
}
