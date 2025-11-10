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
        imageUrl: 'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg?semt=ais_hybrid&w=740&q=80',
        title: 'Get 10% off on your first order',
        discount: '25% OFF',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '2',
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
        title: 'Get 10% off on your first order',
        discount: '30% OFF',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '3',
        imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
        title: 'Get 10% off on your first order',
        discount: '20% OFF',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '4',
        imageUrl: 'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg?semt=ais_hybrid&w=740&q=80',
        title: 'Get 10% off on your first order',
        discount: '15% OFF',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '5',
        imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
        title: 'Get 10% off on your first order',
        discount: '35% OFF',
        description: 'Get up to 50% off',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
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