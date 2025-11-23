import 'package:get_it/get_it.dart';
import '../../data/mock/repositories_impl/mock_auth_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_cart_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_category_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_favorites_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_notification_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_offers_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_order_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_product_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_store_repository_impl.dart';
import '../../data/mock/repositories_impl/mock_user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/repositories/offers_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/store_repository.dart';
import '../../domain/repositories/user_repository.dart';

class MockRepositoryModule {
  static void register(GetIt sl) {
    sl.registerLazySingleton<AuthRepository>(() => MockAuthRepositoryImpl());
    sl.registerLazySingleton<ProductRepository>(() => MockProductRepositoryImpl());
    sl.registerLazySingleton<StoreRepository>(() => MockStoreRepositoryImpl());
    sl.registerLazySingleton<CartRepository>(() => MockCartRepositoryImpl());
    sl.registerLazySingleton<OrderRepository>(() => MockOrderRepositoryImpl());
    sl.registerLazySingleton<CategoryRepository>(() => MockCategoryRepositoryImpl());
    sl.registerLazySingleton<FavoritesRepository>(() => MockFavoritesRepositoryImpl());
    sl.registerLazySingleton<OffersRepository>(() => MockOffersRepositoryImpl());
    sl.registerLazySingleton<NotificationRepository>(() => MockNotificationRepositoryImpl());
  }
}