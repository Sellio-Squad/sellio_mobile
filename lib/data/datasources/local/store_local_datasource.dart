import '../../../domain/entities/store.dart';
import '../../models/address_model.dart';
import '../../models/category_model.dart';
import '../../models/store_model.dart';

abstract class StoreLocalDataSource {
  Future<List<StoreModel>> getCachedStores();

  Future<void> cacheStores(List<StoreModel> stores);

  Future<StoreModel?> getCachedStoreById(String storeId);

  Future<void> cacheStore(StoreModel store);

  Future<void> clearStoresCache();

  Future<List<String>> getFavoriteStoreIds();

  Future<void> addFavoriteStore(String storeId);

  Future<void> removeFavoriteStore(String storeId);

  Future<bool> isFavoriteStore(String storeId);
}

class StoreLocalDataSourceImpl implements StoreLocalDataSource {
  List<StoreModel> _cachedStores = [];
  final Set<String> _favoriteStoreIds = {};

  StoreLocalDataSourceImpl() {
    // Initialize with fake stores
    _cachedStores = _getFakeStores();
  }

  @override
  Future<List<StoreModel>> getCachedStores() async {
    if (_cachedStores.isEmpty) {
      _cachedStores = _getFakeStores();
    }
    return _cachedStores;
  }

  @override
  Future<void> cacheStores(List<StoreModel> stores) async {
    _cachedStores = stores;
  }

  @override
  Future<StoreModel?> getCachedStoreById(String storeId) async {
    final stores = await getCachedStores();
    try {
      return stores.firstWhere((store) => store.id == storeId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheStore(StoreModel store) async {
    final index = _cachedStores.indexWhere((s) => s.id == store.id);
    if (index != -1) {
      _cachedStores[index] = store;
    } else {
      _cachedStores.add(store);
    }
  }

  @override
  Future<void> clearStoresCache() async {
    _cachedStores = [];
  }

  @override
  Future<List<String>> getFavoriteStoreIds() async {
    return _favoriteStoreIds.toList();
  }

  @override
  Future<void> addFavoriteStore(String storeId) async {
    _favoriteStoreIds.add(storeId);
  }

  @override
  Future<void> removeFavoriteStore(String storeId) async {
    _favoriteStoreIds.remove(storeId);
  }

  @override
  Future<bool> isFavoriteStore(String storeId) async {
    return _favoriteStoreIds.contains(storeId);
  }

  // Fake stores data
  List<StoreModel> _getFakeStores() {
    return [
      StoreModel(
        id: 'store_001',
        name: 'Tech Gadgets Store',
        description: 'Your one-stop shop for all tech gadgets and electronics',
        coverImage: 'https://via.placeholder.com/800x400',
        profileImage: 'https://via.placeholder.com/200',
        sale: '20% OFF',
        rating: 4.5,
        address: AddressModel(
          id: 'addr_store_001',
          country: 'United States',
          city: 'San Francisco',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        contactInfo: ContactInfoModel(
          provider: 'contact@techgadgets.com',
          type: ContactType.email,
        ),
        categories: [
          CategoryModel(id: 'cat_001', name: 'Electronics'),
          CategoryModel(id: 'cat_002', name: 'Computers'),
        ],
        isActive: true,
      ),
      StoreModel(
        id: 'store_002',
        name: 'Fashion Boutique',
        description: 'Trendy fashion and accessories for every occasion',
        coverImage: 'https://via.placeholder.com/800x400',
        profileImage: 'https://via.placeholder.com/200',
        rating: 4.8,
        address: AddressModel(
          id: 'addr_store_002',
          country: 'United States',
          city: 'New York',
          latitude: 40.7128,
          longitude: -74.0060,
        ),
        contactInfo: ContactInfoModel(
          provider: '+1-555-0123',
          type: ContactType.phone,
        ),
        categories: [
          CategoryModel(id: 'cat_003', name: 'Clothing'),
          CategoryModel(id: 'cat_004', name: 'Accessories'),
        ],
        isActive: true,
      ),
      StoreModel(
        id: 'store_003',
        name: 'Home & Garden',
        description: 'Everything for your home and garden needs',
        coverImage: 'https://via.placeholder.com/800x400',
        profileImage: 'https://via.placeholder.com/200',
        sale: 'Buy 2 Get 1 Free',
        rating: 4.2,
        address: AddressModel(
          id: 'addr_store_003',
          country: 'United States',
          city: 'Los Angeles',
          latitude: 34.0522,
          longitude: -118.2437,
        ),
        contactInfo: ContactInfoModel(
          provider: 'https://homegarden.com',
          type: ContactType.website,
        ),
        categories: [
          CategoryModel(id: 'cat_005', name: 'Furniture'),
          CategoryModel(id: 'cat_006', name: 'Garden'),
        ],
        isActive: true,
      ),
    ];
  }
}
