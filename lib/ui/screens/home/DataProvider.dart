import 'widgets/special_offer/special_offers_section.dart';
import 'widgets/top_stores/top_stores_section.dart';

class DataProvider {
  static final List<SpecialOfferModel> specialOffers = [
    SpecialOfferModel(
      id: '1',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '25% OFF',
    ),
    SpecialOfferModel(
      id: '2',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '30% OFF',
    ),
    SpecialOfferModel(
      id: '3',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '20% OFF',
    ),
  ];

  static final List<Store> topStores = [
    Store(
      name: 'Gold Gallery Accessories',
      imageUrl: 'assets/images/store_accessories.png',
      discount: '25',
    ),
    Store(
      name: 'Sweet cake sweet',
      imageUrl: 'assets/images/store_sweet.png',
      discount: '30',
    ),
    Store(
      name: 'Techno store',
      imageUrl: 'assets/images/store_techno.png',
      discount: null,
    ),
  ];
}