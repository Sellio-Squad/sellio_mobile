import '../../domain/entities/special_offer.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/remote/offers_remote_datasource.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersRemoteDataSource _remoteDataSource;

  OffersRepositoryImpl({
    required OffersRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<SpecialOffer>> getSpecialOffers() async {
    try {
      final offerModels = await _remoteDataSource.getSpecialOffers();
      return offerModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<SpecialOffer> getOfferById(String offerId) async {
    final offerModel = await _remoteDataSource.getOfferById(offerId);
    return offerModel.toEntity();
  }

  @override
  Future<List<SpecialOffer>> getActiveOffers() async {
    final offers = await getSpecialOffers();
    return offers.where((offer) => offer.isValid).toList();
  }
}