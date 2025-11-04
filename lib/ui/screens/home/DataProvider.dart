import 'widgets/special_offer/special_offers_section.dart';
import 'widgets/top_stores/top_stores_section.dart';

class DataProvider {
  static final List<SpecialOfferModel> specialOffers = [
    SpecialOfferModel(
      id: '1',
      imageUrl: 'assets/images/special_offer_1.webp',
      title: 'Get 10% off on your first order',
      discount: '25% OFF',
    ),
    SpecialOfferModel(
      id: '2',
      imageUrl: 'assets/images/special_offer_1.webp',
      title: 'Get 10% off on your first order',
      discount: '30% OFF',
    ),
    SpecialOfferModel(
      id: '3',
      imageUrl: 'assets/images/special_offer_1.webp',
      title: 'Get 10% off on your first order',
      discount: '20% OFF',
    ),
    SpecialOfferModel(
      id: '4',
      imageUrl: 'assets/images/special_offer_1.webp',
      title: 'Get 10% off on your first order',
      discount: '15% OFF',
    ),
    SpecialOfferModel(
      id: '5',
      imageUrl: 'assets/images/special_offer_1.webp',
      title: 'Get 10% off on your first order',
      discount: '35% OFF',
    ),
  ];

  static final List<Store> topStores = [
    Store(
      id: '1',
      name: 'Gold Gallery Accessories',
      imageUrl: 'assets/images/store_sweet.webp',
      discount: '25',
      isFavorite: true

    ),
    Store(
      id: '2',
      name: 'Sweet cake sweet',
      imageUrl: 'assets/images/store_sweet.webp',
      discount: '30',
      isFavorite: true
    ),
    Store(
      id: '3',
      name: 'Techno store',
      imageUrl: 'assets/images/store_sweet.webp',
      discount: null,
      isFavorite: true
    ),
  ];
}