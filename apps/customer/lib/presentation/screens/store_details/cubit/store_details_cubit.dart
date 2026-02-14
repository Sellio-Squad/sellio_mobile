import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/store_repository.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store_rating.dart';
import '../../../../core/error/result.dart';
import 'store_details_state.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  final StoreRepository _repository;
  String? _lastStoreId;

  StoreDetailsCubit(this._repository) : super(const StoreDetailsInitial());

  Future<void> loadStoreDetails(String storeId) async {
    _lastStoreId = storeId;
    emit(const StoreDetailsLoading());

    final storeResult = await _repository.getStoreDetails(storeId);
    
    if (storeResult is! Success) {
      final errorMessage = storeResult is ResultFailure 
          ? storeResult.failure.message 
          : '';
      emit(StoreDetailsError(message: errorMessage, failedCall: 'store_details'));
     
      return;
    }

    final ratingResult = await _repository.getStoreRating(storeId);
    StoreRating? rating;
    rating = ratingResult is Success ? ratingResult.data : null;

    final productsResult = await _repository.getStoreProducts(storeId: storeId);
    List<Product>? products;
    products = productsResult is Success ? productsResult.data : null;

    final featuredProductsResult = await _repository.getStoreFeaturedProducts(storeId: storeId);
    List<Product>? featuredProducts;
    featuredProducts = featuredProductsResult is Success ? featuredProductsResult.data : null;

    emit(StoreDetailsLoaded(
      store: storeResult.data,
      products: products,
      featuredProducts: featuredProducts,
      rating: rating,
    ));
  }

  Future<void> retry() async {
    if (_lastStoreId != null) {
      await loadStoreDetails(_lastStoreId!);
    }
  }
}
