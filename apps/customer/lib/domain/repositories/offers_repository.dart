import '../entities/special_offer.dart';

abstract class OffersRepository {
  Future<List<SpecialOffer>> getSpecialOffers();

  Future<SpecialOffer> getOfferById(String offerId);

  Future<List<SpecialOffer>> getActiveOffers();
}
