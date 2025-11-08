import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/product.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
  @override
  List<Object?> get props => [];
}

class ProductsSearching extends ProductsState {
  final String query;
  const ProductsSearching({required this.query});
  @override
  List<Object?> get props => [query];
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final String? searchQuery;

  const ProductsLoaded({
    required this.products,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, searchQuery];
}

class ProductsError extends ProductsState {
  final String message;
  const ProductsError({required this.message});
  @override
  List<Object?> get props => [message];
}