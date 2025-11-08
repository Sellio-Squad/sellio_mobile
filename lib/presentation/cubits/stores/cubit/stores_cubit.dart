import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/store_repository.dart';
import 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  final StoreRepository _storeRepository;

  StoresCubit(this._storeRepository) : super(const StoresInitial());

  Future<void> loadTopStores({int limit = 10}) async {
    emit(const StoresLoading());
    try {
      final stores = await _storeRepository.getTopStores(limit: limit);
      emit(StoresLoaded(stores: stores));
    } catch (e) {
      emit(StoresError(message: e.toString()));
    }
  }

  Future<void> refreshStores() async {
    await loadTopStores();
  }
}
