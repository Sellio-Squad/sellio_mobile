import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/domain/entities/offer.dart';

sealed class HomeSpecialOffersState extends Equatable {
  const HomeSpecialOffersState();
}

class HomeSpecialOffersInitial extends HomeSpecialOffersState {
  const HomeSpecialOffersInitial();

  @override
  List<Object?> get props => [];
}

class HomeSpecialOffersLoading extends HomeSpecialOffersState {
  const HomeSpecialOffersLoading();

  @override
  List<Object?> get props => [];
}

class HomeSpecialOffersLoaded extends HomeSpecialOffersState {
  final List<Offer> offers;
  final int currentPage;

  const HomeSpecialOffersLoaded({
    required this.offers,
    this.currentPage = 0,
  });

  HomeSpecialOffersLoaded copyWith({
    List<Offer>? offers,
    int? currentPage,
  }) {
    return HomeSpecialOffersLoaded(
      offers: offers ?? this.offers,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [offers, currentPage];
}

class HomeSpecialOffersError extends HomeSpecialOffersState {
  final String message;

  const HomeSpecialOffersError({required this.message});

  @override
  List<Object?> get props => [message];
}
