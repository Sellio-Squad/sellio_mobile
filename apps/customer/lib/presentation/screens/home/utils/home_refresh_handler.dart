import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cart/cubit/cart_cubit.dart';
import '../cubit/home_sections_cubit.dart';
import '../sections/special_offers/cubit/home_special_offers_cubit.dart';
import '../sections/top_stores/cubit/home_top_stores_cubit.dart';
import '../sections/trending_products/cubit/home_trending_products_cubit.dart';
import '../sections/categories/cubit/categories_cubit.dart';

Future<void> handleHomeRefresh(BuildContext context) async {
  await Future.wait([
    context.read<HomeSectionsCubit>().loadSections(),
    context.read<HomeTrendingProductsCubit>().loadTrendingProducts(),
    context.read<HomeTopStoresCubit>().loadTopStores(),
    context.read<HomeSpecialOffersCubit>().loadSpecialOffers(),
    context.read<CategoriesCubit>().fetchCategories(),
    context.read<CartCubit>().loadCart(),
  ]);
}
