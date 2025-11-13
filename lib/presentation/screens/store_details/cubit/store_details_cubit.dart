import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/store_repository.dart';
import '../../../../../../domain/core/result.dart';
import 'store_details_state.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  final StoreRepository _repository;

  StoreDetailsCubit(this._repository) : super(const StoreDetailsInitial());

  Future<void> loadStoreDetails(String storeId) async {
    emit(const StoreDetailsLoading());

    final storeResult = await _repository.getStoreById(storeId);
    final ratingResult = await _repository.getStoreRating(storeId);
    final productsResult = await _repository.getStoreProducts(storeId: storeId);
    final featuredProductsResult = await _repository.getStoreFeaturedProducts(storeId: storeId);

    if (storeResult is Success &&
        ratingResult is Success &&
        productsResult is Success &&
        featuredProductsResult is Success) {
      emit(StoreDetailsLoaded(
        store: storeResult.data,
        products: productsResult.data,
        featuredProducts: featuredProductsResult.data,
        rating: ratingResult.data,
      ));
    } else {
      final errorMessage = _extractErrorMessage(
        [storeResult, ratingResult, productsResult, featuredProductsResult],
      );
      emit(StoreDetailsError(message: errorMessage));
    }
  }

  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        return r.failure.message;
      }
    }
    return 'Something went wrong';
  }
}
