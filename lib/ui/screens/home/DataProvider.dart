import 'widgets/special_offer/special_offers_section.dart';
import 'widgets/top_stores/top_stores_section.dart';

class DataProvider {
  static final List<SpecialOfferModel> specialOffers = [
    SpecialOfferModel(
      id: '1',
      imageUrl: 'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg?semt=ais_hybrid&w=740&q=80',
      title: 'Get 10% off on your first order',
      discount: '25% OFF',
    ),
    SpecialOfferModel(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
      title: 'Get 10% off on your first order',
      discount: '30% OFF',
    ),
    SpecialOfferModel(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
      title: 'Get 10% off on your first order',
      discount: '20% OFF',
    ),
    SpecialOfferModel(
      id: '4',
      imageUrl: 'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg?semt=ais_hybrid&w=740&q=80',
      title: 'Get 10% off on your first order',
      discount: '15% OFF',
    ),
    SpecialOfferModel(
      id: '5',
      imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2VhJTIwYmFja2dyb3VuZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&q=60&w=600',
      title: 'Get 10% off on your first order',
      discount: '35% OFF',
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