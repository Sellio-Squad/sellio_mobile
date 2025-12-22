import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/offers_repository.dart';

import 'home_special_offers_state.dart';

class HomeSpecialOffersCubit extends Cubit<HomeSpecialOffersState> {
  final OffersRepository _offersRepository;

  HomeSpecialOffersCubit(this._offersRepository)
      : super(const HomeSpecialOffersInitial());

  Future<void> loadSpecialOffers() async {
    emit(const HomeSpecialOffersLoading());
    try {
      final offers = await _offersRepository.getActiveOffers();
      emit(HomeSpecialOffersLoaded(offers: offers));
    } catch (e) {
      emit(HomeSpecialOffersError(message: e.toString()));
    }
  }

  void setCurrentPage(int page) {
    if (state is HomeSpecialOffersLoaded) {
      emit((state as HomeSpecialOffersLoaded).copyWith(currentPage: page));
    }
  }

  Future<void> refreshOffers() async {
    await loadSpecialOffers();
  }
}
