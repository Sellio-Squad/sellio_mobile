import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/store.dart';
import '../../../../../domain/entities/store_rating.dart';

abstract class AboutStoreState extends Equatable {
  const AboutStoreState();

  @override
  List<Object?> get props => [];
}

class AboutStoreInitial extends AboutStoreState {
  const AboutStoreInitial();
}

class AboutStoreLoading extends AboutStoreState {
  const AboutStoreLoading();
}

class AboutStoreLoaded extends AboutStoreState {
  final Store store;
  final StoreRating rating;

  const AboutStoreLoaded({
    required this.store,
    required this.rating,
  });

  AboutStoreLoaded copyWith({
    Store? store,
    StoreRating? rating,
  }) {
    return AboutStoreLoaded(
      store: store ?? this.store,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [store, rating];
}

class AboutStoreError extends AboutStoreState {
  final String message;

  const AboutStoreError({required this.message});

  @override
  List<Object?> get props => [message];
}