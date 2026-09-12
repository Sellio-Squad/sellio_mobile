import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/review.dart';
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
  final List<Review> reviews;
  final bool isLoadingReviews;
  final String? reviewsError;

  const AboutStoreLoaded({
    required this.store,
    required this.rating,
    this.reviews = const [],
    this.isLoadingReviews = false,
    this.reviewsError,
  });

  AboutStoreLoaded copyWith({
    Store? store,
    StoreRating? rating,
    List<Review>? reviews,
    bool? isLoadingReviews,
    String? reviewsError,
  }) {
    return AboutStoreLoaded(
      store: store ?? this.store,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      isLoadingReviews: isLoadingReviews ?? this.isLoadingReviews,
      reviewsError: reviewsError ?? this.reviewsError,
    );
  }

  @override
  List<Object?> get props => [
        store,
        rating,
        reviews,
        isLoadingReviews,
        reviewsError,
      ];
}

class AboutStoreError extends AboutStoreState {
  final String message;

  const AboutStoreError({required this.message});

  @override
  List<Object?> get props => [message];
}