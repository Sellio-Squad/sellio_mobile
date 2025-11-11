import '../entities/special_offer.dart';

abstract class OffersRepository {
  /// Get all special offers
  Future<List<SpecialOffer>> getSpecialOffers();

  /// Get offer by ID
  Future<SpecialOffer> getOfferById(String offerId);

  /// Get active offers
  Future<List<SpecialOffer>> getActiveOffers();
}