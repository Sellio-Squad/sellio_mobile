import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/search/widgets/search_bar_with_filter.dart';
import '../cubit/search_cubit.dart';
import '../../home/sections/search/widgets/search_bar_widget.dart';

class SearchBarSection extends StatelessWidget {
  final TextEditingController searchController;
  final bool isShowFilterIcon;
  final Function() onFilterIconClicked;

  const SearchBarSection(
      {super.key,
      required this.searchController,
      this.isShowFilterIcon = false,
       required this.onFilterIconClicked
      }
      );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: isShowFilterIcon
            ? SearchBarWithFilter(
                controller: searchController,
                onFilterIconClicked : (){
                  onFilterIconClicked();
                },
                onTextSubmitted: cubit.search,
              )
            : SearchBarWidget(
                onTextSubmitted: cubit.search,
                controller: searchController,
              ),
      ),
    );
  }
}
