import '../models/response/favorite_product_response.dart';
import '../models/response/favorite_store_response.dart';

class FavoriteMapper {
  // Product mapping
  static List<String> toProductIdList(FavoriteProductsListResponse response) {
    return response.data.map((item) => item.productId).toList();
  }

  static List<String> toProductIdListFromJson(Map<String, dynamic> json) {
    final response = FavoriteProductsListResponse.fromJson(json);
    return toProductIdList(response);
  }

  // Store mapping
  static List<String> toStoreIdList(FavoriteStoresListResponse response) {
    return response.data.map((item) => item.storeId).toList();
  }

  static List<String> toStoreIdListFromJson(Map<String, dynamic> json) {
    final response = FavoriteStoresListResponse.fromJson(json);
    return toStoreIdList(response);
  }
}
