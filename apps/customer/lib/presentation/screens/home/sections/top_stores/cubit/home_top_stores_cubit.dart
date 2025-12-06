import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/store_repository.dart';
import 'home_top_stores_state.dart';

class HomeTopStoresCubit extends Cubit<HomeTopStoresState> {
  final StoreRepository _storeRepository;

  HomeTopStoresCubit(this._storeRepository) : super(const HomeTopStoresInitial());

  Future<void> loadTopStores({int limit = 10}) async {
    emit(const HomeTopStoresLoading());
    try {
      final stores = await _storeRepository.getTopStores(limit: limit);
      emit(HomeTopStoresLoaded(stores: stores.data));
    } catch (e) {
      emit(HomeTopStoresError(message: e.toString()));
    }
  }

  Future<void> refreshStores() async {
    await loadTopStores();
  }
}
