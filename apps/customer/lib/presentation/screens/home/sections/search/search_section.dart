import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search/search_screen.dart';
import '../trending_products/cubit/home_trending_products_cubit.dart';
import 'widgets/search_bar_widget.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SearchBarWithFilter(
          isReadOnly: true,
          onTextFiledClicked: (){
            _navigateToSearch(context);
          },
          onFilterIconClicked: () {
            // TODO: Show filter dialog
          },
          onTextSubmitted: (text) {
            context.read<HomeTrendingProductsCubit>().searchProducts(text);
          },
        ),
      ),
    );
  }
  void _navigateToSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      ),
    );
  }
}
