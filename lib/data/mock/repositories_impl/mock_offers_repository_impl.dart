import '../../../domain/entities/special_offer.dart';
import '../../../domain/repositories/offers_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockOffersRepositoryImpl implements OffersRepository {
  final List<SpecialOffer> _offers = MockDataGenerator.generateSpecialOffers(count: 10);

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<SpecialOffer>> getSpecialOffers() async {
    await _simulateDelay();
    return _offers;
  }

  @override
  Future<SpecialOffer> getOfferById(String offerId) async {
    await _simulateDelay();

    return _offers.firstWhere(
          (offer) => offer.id == offerId,
      orElse: () => MockDataGenerator.generateSpecialOffer(index: 0),
    );
  }

  @override
  Future<List<SpecialOffer>> getActiveOffers() async {
    await _simulateDelay();

    return _offers.where((offer) => offer.isValid).toList();
  }
}