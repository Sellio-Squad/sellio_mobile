import 'package:equatable/equatable.dart';
import '../../../../../../domain/entities/product.dart';

sealed class HomeTrendingProductsState extends Equatable {
  const HomeTrendingProductsState();
}

class HomeTrendingProductsInitial extends HomeTrendingProductsState {
  const HomeTrendingProductsInitial();
  @override
  List<Object?> get props => [];
}

class HomeTrendingProductsLoading extends HomeTrendingProductsState {
  const HomeTrendingProductsLoading();
  @override
  List<Object?> get props => [];
}

class HomeTrendingProductsSearching extends HomeTrendingProductsState {
  final String query;
  const HomeTrendingProductsSearching({required this.query});
  @override
  List<Object?> get props => [query];
}

class HomeTrendingProductsLoaded extends HomeTrendingProductsState {
  final List<Product> products;
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