import 'dart:io';

import 'package:core/core.dart';

import '../entity/store_seller.dart';

abstract class StoreRepository {
  Future<Result<StoreSeller>> createStore({
    required String name,
    required String description,
    required String city,
    required String country,
    required File profileImage,
    required File coverImage,
  });
}
