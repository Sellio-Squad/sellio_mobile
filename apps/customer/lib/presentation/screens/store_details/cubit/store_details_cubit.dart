import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/store_repository.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store_rating.dart';
import '../../../../core/error/result.dart';
import 'store_details_state.dart';
import 'dart:developer' as developer;

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  final StoreRepository _repository;
  String? _lastStoreId;

  StoreDetailsCubit(this._repository) : super(const StoreDetailsInitial());

  Future<void> loadStoreDetails(String storeId) async {
    _lastStoreId = storeId;
    emit(const StoreDetailsLoading());

    developer.log('Loading store details for storeId: $storeId', name: 'StoreDetailsCubit');

    // Fetch store details - this is the critical one
    final storeResult = await _repository.getStoreDetails(storeId);
    
    if (storeResult is! Success) {
      final errorMessage = storeResult is ResultFailure 
          ? storeResult.failure.message 
          : 'Failed to load store details';
      developer.log('Store fetch failed: $errorMessage', name: 'StoreDetailsCubit', error: errorMessage);
      emit(StoreDetailsError(message: errorMessage, failedCall: 'Store Details'));
      return;
    }

    developer.log('Store details loaded successfully', name: 'StoreDetailsCubit');

    // Fetch rating - pass null if fails (section will be hidden)
    final ratingResult = await _repository.getStoreRating(storeId);
    StoreRating? rating;
    if (ratingResult is Success) {
      rating = ratingResult.data;
      developer.log('Store rating loaded successfully', name: 'StoreDetailsCubit');
    } else {
      developer.log('Store rating failed, section will be hidden', name: 'StoreDetailsCubit');
      rating = null;
    }

    // Fetch products - pass null if fails (section will be hidden)
    final productsResult = await _repository.getStoreProducts(storeId: storeId);
    List<Product>? products;
    if (productsResult is Success) {
      products = productsResult.data;
      developer.log('Store products loaded: ${products.length} items', name: 'StoreDetailsCubit');
    } else {
      developer.log('Store products failed, section will be hidden', name: 'StoreDetailsCubit');
      products = null;
    }

    // Fetch featured products - pass null if fails (section will be hidden)
    final featuredProductsResult = await _repository.getStoreFeaturedProducts(storeId: storeId);
    List<Product>? featuredProducts;
    if (featuredProductsResult is Success) {
      featuredProducts = featuredProductsResult.data;
      developer.log('Featured products loaded: ${featuredProducts.length} items', name: 'StoreDetailsCubit');
    } else {
      developer.log('Featured products failed, section will be hidden', name: 'StoreDetailsCubit');
      featuredProducts = null;
    }

    emit(StoreDetailsLoaded(
      store: storeResult.data,
      products: products,
      featuredProducts: featuredProducts,
      rating: rating,
    ));

    developer.log('Store details screen loaded successfully', name: 'StoreDetailsCubit');
  }

  Future<void> retry() async {
    if (_lastStoreId != null) {
      await loadStoreDetails(_lastStoreId!);
    }
  }
}
