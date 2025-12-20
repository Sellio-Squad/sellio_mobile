import 'package:design_system/widgets/cards/sellio_product_vertical_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/category_section.dart';
import '../cubit/search_cubit.dart';

class SuccessSearch extends StatelessWidget {
  const SuccessSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySection(),
        GridProductsSection(),
      ],
    );
  }
}

class GridProductsSection extends StatelessWidget {
  const GridProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is! SearchSuccess) return const SizedBox();

        final products = state.products;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 170 / 272,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return SellioProductVerticalCard(
              imageUrl: product.images.isNotEmpty ? product.images.first : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNK7-n-r_w_qCEIjsnu8VXMBamUkSmLUr9Eg&s',
              title: product.name,
              price: "${product.currency}${product.price}",
              count: 0,
              isFavorite: false,
              onIncrement: () {},
              onDecrement: () {},
              onFavorite: () {},
            );
          },
        );
      },
    );
  }
}
