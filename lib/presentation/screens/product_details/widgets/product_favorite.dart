import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';import '../../../../core/design_system/constants/assets.dart';

Widget productFavorite(BuildContext context, String productId) {
  return BlocBuilder<FavoritesCubit, FavoritesState>(
    builder: (context, favoritesState) {
      final isFavorite = favoritesState.productIds.contains(productId);

      return IconButton(
        icon: SvgPicture.asset(
          isFavorite ? Assets.favorite : Assets.unselectedFavorite,
        ),
        onPressed: () async {
          await context.read<FavoritesCubit>().toggleProductFavorite(productId);
        },
      );
    },
  );
}