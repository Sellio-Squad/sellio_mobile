import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/cart/cubit/cart_cubit.dart';
import '../../../cubits/categories/cubit/categories_cubit.dart';
import '../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../cubits/offers/cubit/offers_cubit.dart';
import '../../../cubits/products/cubit/products_cubit.dart';
import '../../../cubits/stores/cubit/stores_cubit.dart';

Future<void> handleHomeRefresh(BuildContext context) async {
  await Future.wait([
    context.read<CategoriesCubit>().loadCategories(),
    context.read<ProductsCubit>().loadTrendingProducts(),
    context.read<StoresCubit>().loadTopStores(),
    context.read<OffersCubit>().loadSpecialOffers(),
    context.read<CartCubit>().loadCart(),
    context.read<FavoritesCubit>().loadFavorites(),
  ]);
}