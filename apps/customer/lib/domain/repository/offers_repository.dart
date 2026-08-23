import '../entities/offer.dart';
import '../entities/special_offer.dart';

abstract class OffersRepository {
  Future<SpecialOffer> getOfferById(String offerId);

  Future<List<Offer>> getActiveOffers();
}
