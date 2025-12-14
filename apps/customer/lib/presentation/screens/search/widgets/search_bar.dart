import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/search/cubit/search_cubit.dart';
import '../../home/sections/search/widgets/search_bar_widget.dart';

class SearchBarSection extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBarSection({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SearchBarWithFilter(
          controller: searchController,
          onFilterIconClicked: () {},
          onTextSubmitted: cubit.search,
        ),
      ),
    );
  }
}
