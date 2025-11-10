import 'package:equatable/equatable.dart';

import '../../../../../../domain/entities/special_offer.dart';

sealed class OffersState extends Equatable {
  const OffersState();
}

class OffersInitial extends OffersState {
  const OffersInitial();

  @override
  List<Object?> get props => [];
}

class OffersLoading extends OffersState {
  const OffersLoading();

  @override
  List<Object?> get props => [];
}

class OffersLoaded extends OffersState {
  final List<SpecialOffer> offers;
  final int currentPage;

  const OffersLoaded({
    required this.offers,
    this.currentPage = 0,
  });

  OffersLoaded copyWith({
    List<SpecialOffer>? offers,
    int? currentPage,
  }) {
    return OffersLoaded(
      offers: offers ?? this.offers,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [offers, currentPage];
}

class OffersError extends OffersState {
  final String message;

  const OffersError({required this.message});

  @override
  List<Object?> get props => [message];
}