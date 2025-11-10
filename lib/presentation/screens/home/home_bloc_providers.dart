import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/offers_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/repositories/store_repository.dart';
import 'cubits/categories/cubit/home_categories_cubit.dart';
import 'cubits/offers/cubit/offers_cubit.dart';
import 'cubits/products/cubit/products_cubit.dart';
import 'cubits/stores/cubit/stores_cubit.dart';


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
          create: (context) => HomeCategoriesCubit(
            context.read<CategoryRepository>(),
          )..loadCategories(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            context.read<ProductRepository>(),
          )..loadTrendingProducts(),
        ),
        BlocProvider(
          create: (context) => StoresCubit(
            context.read<StoreRepository>(),
          )..loadTopStores(),
        ),
        BlocProvider(
          create: (context) => OffersCubit(
            context.read<OffersRepository>(),
          )..loadSpecialOffers(),
        ),
      ],
      child: child,
    );
  }
}