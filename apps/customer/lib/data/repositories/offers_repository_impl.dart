import 'package:sellio_mobile/data/datasource/remote/offers_remote_datasource.dart';
import 'package:sellio_mobile/domain/entities/offer.dart';
import 'package:sellio_mobile/domain/entities/special_offer.dart';
import 'package:sellio_mobile/domain/repositories/offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OffersRemoteDataSource _remoteDataSource;

  OffersRepositoryImpl({
    required OffersRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<SpecialOffer> getOfferById(String offerId) async {
    final offerModel = await _remoteDataSource.getOfferById(offerId);
    return offerModel.toEntity();
  }

  @override
  Future<List<Offer>> getActiveOffers() async {
    final offers = await _remoteDataSource.getActiveOffers();
    return offers.map((offer) => offer.toEntity()).toList();
  }
}
