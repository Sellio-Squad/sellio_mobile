import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/offers_repository.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepository _offersRepository;

  OffersCubit(this._offersRepository) : super(const OffersInitial());

  Future<void> loadSpecialOffers() async {
    emit(const OffersLoading());
    try {
      final offers = await _offersRepository.getSpecialOffers();
      emit(OffersLoaded(offers: offers));
    } catch (e) {
      emit(OffersError(message: e.toString()));
    }
  }

  void setCurrentPage(int page) {
    if (state is OffersLoaded) {
      emit((state as OffersLoaded).copyWith(currentPage: page));
    }
  }

  Future<void> refreshOffers() async {
    await loadSpecialOffers();
  }
}