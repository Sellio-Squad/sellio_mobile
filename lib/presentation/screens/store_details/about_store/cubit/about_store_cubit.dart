import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/result.dart';
import '../../../../../domain/repositories/store_repository.dart';
import 'about_store_state.dart';

class AboutStoreCubit extends Cubit<AboutStoreState> {
  final StoreRepository _repository;

  AboutStoreCubit(this._repository) : super(const AboutStoreInitial());

  Future<void> loadStoreInfo(String storeId) async {
    emit(const AboutStoreLoading());

    final storeResult = await _repository.getStoreById(storeId);
    final ratingResult = await _repository.getStoreRating(storeId);

    if (storeResult is Success && ratingResult is Success) {
      emit(AboutStoreLoaded(
        store: storeResult.data,
        rating: ratingResult.data,
      ));
    } else {
      final errorMessage = _extractErrorMessage([storeResult, ratingResult]);
      emit(AboutStoreError(message: errorMessage));
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
