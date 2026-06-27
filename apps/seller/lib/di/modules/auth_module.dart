import 'package:authentication/authentication.dart';
import 'package:get_it/get_it.dart';
import '../../data/core/api/seller_auth_configuration.dart';

class AuthModule {
  static void register(GetIt sl) {
    AuthPackage.init(
      sl: sl,
      configuration: SellerAuthConfiguration(),
    );
  }
}
