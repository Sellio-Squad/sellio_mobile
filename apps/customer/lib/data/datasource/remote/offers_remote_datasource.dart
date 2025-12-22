import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/offer_model.dart';
import '../../models/special_offer_model.dart';

abstract class OffersRemoteDataSource {
  Future<List<SpecialOfferModel>> getSpecialOffers();

  Future<SpecialOfferModel> getOfferById(String offerId);

  Future<List<SpecialOfferModel>> getDiscountsByStore(String storeId);

  Future<List<SpecialOfferModel>> getDiscountsByCategory(String categoryId);

  Future<List<SpecialOfferModel>> getDiscountsByProduct(String productId);

  Future<List<OfferModel>> getActiveOffers();
}

class OffersRemoteDataSourceImpl implements OffersRemoteDataSource {
  final ApiClient _httpClient;

  OffersRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<SpecialOfferModel>> getSpecialOffers() async {
    final response = await _httpClient.get(ApiEndpoints.discounts);
    final offers = (response.data['data'] as List)
        .map((json) => SpecialOfferModel.fromJson(json))
        .toList();
    return offers;
  }

  @override
  Future<SpecialOfferModel> getOfferById(String offerId) async {
    final response = await _httpClient.get(ApiEndpoints.discountById(offerId));
    return SpecialOfferModel.fromJson(response.data);
  }

  @override
  Future<List<SpecialOfferModel>> getDiscountsByStore(String storeId) async {
    final response =
        await _httpClient.get(ApiEndpoints.discountsByStore(storeId));
    final offers = (response.data['data'] as List)
        .map((json) => SpecialOfferModel.fromJson(json))
        .toList();
    return offers;
  }

  @override
  Future<List<SpecialOfferModel>> getDiscountsByCategory(
      String categoryId) async {
    final response =
        await _httpClient.get(ApiEndpoints.discountsByCategory(categoryId));
    final offers = (response.data['data'] as List)
        .map((json) => SpecialOfferModel.fromJson(json))
        .toList();
    return offers;
  }

  @override
  Future<List<SpecialOfferModel>> getDiscountsByProduct(
      String productId) async {
    final response =
        await _httpClient.get(ApiEndpoints.discountsByProduct(productId));
    final offers = (response.data['data'] as List)
        .map((json) => SpecialOfferModel.fromJson(json))
        .toList();
    return offers;
  }

  @override
  Future<List<OfferModel>> getActiveOffers() async {
    final response = await _httpClient.get(ApiEndpoints.offers);
    final offers = (response.data as List)
        .map((json) => OfferModel.fromJson(json))
        .toList();
    return offers;
  }
}
