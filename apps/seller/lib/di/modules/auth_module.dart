import 'package:authentication/authentication.dart';
import 'package:get_it/get_it.dart';
import '../../data/core/api/seller_auth_configuration.dart';

void initAuthDI() {
  final sl = GetIt.instance;
  AuthPackage.init(
    sl: sl,
    configuration: SellerAuthConfiguration(),
  );
}
