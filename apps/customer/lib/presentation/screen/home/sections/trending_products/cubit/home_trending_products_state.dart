import 'package:equatable/equatable.dart';

import '../models/product_summary_ui_model.dart';

abstract class HomeTrendingProductsState extends Equatable {
  const HomeTrendingProductsState();

  @override
  List<Object?> get props => [];
}

class HomeTrendingProductsInitial extends HomeTrendingProductsState {
  const HomeTrendingProductsInitial();
}

class HomeTrendingProductsLoading extends HomeTrendingProductsState {
  const HomeTrendingProductsLoading();
}

class HomeTrendingProductsSearching extends HomeTrendingProductsState {
  final String query;

  const HomeTrendingProductsSearching({required this.query});

  @override
  List<Object?> get props => [query];
}

class HomeTrendingProductsLoaded extends HomeTrendingProductsState {
  final List<ProductSummaryUIModel> products;
  final String? searchQuery;

  const HomeTrendingProductsLoaded({
    required this.products,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, searchQuery];
}

class HomeTrendingProductsError extends HomeTrendingProductsState {
  final String message;

  const HomeTrendingProductsError({required this.message});

  @override
  List<Object?> get props => [message];
}
