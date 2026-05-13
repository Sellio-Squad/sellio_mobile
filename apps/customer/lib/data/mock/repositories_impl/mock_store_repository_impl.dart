import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/review.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/store_rating.dart';
import '../../../domain/repositories/store_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockStoreRepositoryImpl implements StoreRepository {
  final Set<String> _favoriteStoreIds = {};

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<Result<List<Store>>> getStores({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final stores = MockDataGenerator.generateStores(count: limit);
    return Success(stores);
  }

  @override
  Future<Result<Store>> getStoreById(String storeId) async {
    await _simulateDelay();

    final store = MockDataGenerator.generateStore(
      index: int.tryParse(storeId.replaceAll('store_', '')) ?? 0,
    );

    return Success(store);
  }

  @override
  Future<Result<Store>> getStoreDetails(String storeId) async {
    await _simulateDelay();

    final store = MockDataGenerator.generateStore(
      index: int.tryParse(storeId.replaceAll('store_', '')) ?? 0,
    );

    return Success(store);
  }

  @override
  Future<Result<List<Store>>> getTopStores({int limit = 10}) async {
    await _simulateDelay();

    final stores = MockDataGenerator.generateStores(count: limit);
    return Success(stores);
  }

  @override
  Future<Result<List<Product>>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(
      count: limit,
      storeId: storeId,
      categoryId: categoryId,
    );

    return Success(products);
  }

  @override
  Future<Result<List<Product>>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(
      count: limit,
      storeId: storeId,
    );

    return Success(products);
  }

  @override
  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    if (query.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'Search query cannot be empty'),
      );
    }

    final stores = MockDataGenerator.generateStores(count: limit);
    return Success(stores);
  }

  @override
  Future<Result<void>> toggleFavoriteStore(String storeId) async {
    await _simulateDelay();

    if (_favoriteStoreIds.contains(storeId)) {
      _favoriteStoreIds.remove(storeId);
    } else {
      _favoriteStoreIds.add(storeId);
    }

    return const Success(null);
  }

  @override
  Future<Result<List<Store>>> getFavoriteStores() async {
    await _simulateDelay();

    final stores = _favoriteStoreIds
        .take(10)
        .map((id) => MockDataGenerator.generateStore(
              index: int.tryParse(id.replaceAll('store_', '')) ?? 0,
            ))
        .toList();

    return Success(stores);
  }

  @override
  Future<Result<bool>> isFavorite(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Success(_favoriteStoreIds.contains(storeId));
  }

  @override
  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final reviews = MockDataGenerator.generateReviews(
      count: limit,
      storeId: storeId,
    );

    return Success(reviews);
  }

  @override
  Future<Result<StoreRating>> getStoreRating(String storeId) async {
    await _simulateDelay();

    final rating = MockDataGenerator.generateStoreRating(storeId: storeId);
    return Success(rating);
  }

  @override
  Future<Result<Review>> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    await _simulateDelay();

    if (rating < 1 || rating > 5) {
      return const ResultFailure(
        ValidationFailure(message: 'Rating must be between 1 and 5'),
      );
    }

    final review = Review(
      id: 'review_${DateTime.now().millisecondsSinceEpoch}',
      storeId: storeId,
      userId: 'user_0',
      userName: 'Current User',
      userImage: 'https://i.pravatar.cc/100',
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    return Success(review);
  }
}
