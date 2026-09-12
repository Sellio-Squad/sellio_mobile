import 'package:core/error/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/repository/store_repository.dart';
import 'about_store_state.dart';

class AboutStoreCubit extends Cubit<AboutStoreState> {
  final StoreRepository _repository;

  AboutStoreCubit(this._repository) : super(const AboutStoreInitial());

  String? _storeId;

  Future<void> loadStoreInfo(String storeId) async {
    _storeId = storeId;
    emit(const AboutStoreLoading());

    final storeResult = await _repository.getStoreDetails(storeId);
    final ratingResult = await _repository.getStoreRating(storeId);

    if (storeResult is Success && ratingResult is Success) {
      emit(AboutStoreLoaded(
        store: storeResult.data,
        rating: ratingResult.data,
      ));
      await loadReviews(storeId);
    } else {
      final errorMessage = _extractErrorMessage([storeResult, ratingResult]);
      emit(AboutStoreError(message: errorMessage));
    }
  }

  Future<void> loadReviews(String storeId) async {
    final current = state;
    if (current is! AboutStoreLoaded) return;

    emit(current.copyWith(isLoadingReviews: true, reviewsError: null));

    final result = await _repository.getStoreReviews(storeId: storeId);

    if (result is Success) {
      emit(current.copyWith(reviews: result.data, isLoadingReviews: false));
    } else if (result is ResultFailure) {
      emit(current.copyWith(
        isLoadingReviews: false,
        reviewsError: result.failure.message,
      ));
    } else {
      emit(current.copyWith(
        isLoadingReviews: false,
        reviewsError: 'Something went wrong',
      ));
    }
  }

  Future<bool> addReview({
    required double rating,
    String? comment,
  }) async {
    final current = state;
    final storeId = _storeId;
    if (storeId == null || current is! AboutStoreLoaded) return false;

    final result = await _repository.addStoreReview(
      storeId: storeId,
      rating: rating,
      comment: comment,
    );

    if (result is Success) {
      final updatedReviews = [result.data, ...current.reviews];
      emit(current.copyWith(reviews: updatedReviews));

      final ratingResult = await _repository.getStoreRating(storeId);
      if (ratingResult is Success) {
        emit(AboutStoreLoaded(
          store: current.store,
          rating: ratingResult.data,
          reviews: updatedReviews,
        ));
      }

      return true;
    }

    return false;
  }

  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        final error = r.failure.message;

        return error;
      }
    }

    return 'Something went wrong';
  }
}