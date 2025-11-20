import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/injection_container.dart';
import 'sections/categories/cubit/home_categories_cubit.dart';
import 'sections/special_offers/cubit/home_special_offers_cubit.dart';
import 'sections/trending_products/cubit/home_trending_products_cubit.dart';
import 'sections/top_stores/cubit/home_top_stores_cubit.dart';

class HomeBlocProviders extends StatelessWidget {
  final Widget child;

  const HomeBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HomeCategoriesCubit>()..loadCategories(),
        ),
        BlocProvider(
          create: (_) => sl<HomeTrendingProductsCubit>()..loadTrendingProducts(),
        ),
        BlocProvider(
          create: (_) => sl<HomeTopStoresCubit>()..loadTopStores(),
        ),
        BlocProvider(
          create: (_) => sl<HomeSpecialOffersCubit>()..loadSpecialOffers(),
        ),
      ],
      child: child,
    );
  }
}