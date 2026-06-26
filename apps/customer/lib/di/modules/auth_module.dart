import 'package:authentication/authentication.dart';
import 'package:get_it/get_it.dart';
import '../../data/core/api/customer_auth_endpoints.dart';

class AuthModule {
  static void register(GetIt sl) {
    AuthPackage.init(
      sl: sl,
      configuration: CustomerAuthConfiguration(),
    );
  }
}
