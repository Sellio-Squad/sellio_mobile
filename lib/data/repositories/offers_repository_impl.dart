import '../../domain/entities/special_offer.dart';
import '../../domain/repositories/offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  @override
  Future<List<SpecialOffer>> getSpecialOffers() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      SpecialOffer(
        id: '1',
        imageUrl: 'https://via.placeholder.com/400x150',
        title: 'Summer Sale',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)), discount: '', createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '2',
        imageUrl: 'https://via.placeholder.com/400x150',
        title: 'Flash Deal',
        description: 'Limited time offer',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)), discount: '', createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<SpecialOffer> getOfferById(String offerId) async {
    // TODO: Implement
    throw UnimplementedError();
  }

  @override
  Future<List<SpecialOffer>> getActiveOffers() async {
    // TODO: Implement
    return getSpecialOffers();
  }
}