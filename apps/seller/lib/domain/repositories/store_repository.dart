import 'package:core/core.dart';

import '../../data/models/store/create_store_request.dart';
import '../entity/store_seller.dart';

abstract class StoreRepository {
  Future<Result<StoreSeller>> createStore(CreateStoreRequest request);
}
