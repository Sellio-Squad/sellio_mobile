import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../cubits/search/cubit/search_cubit.dart';

class RecentSearchSection extends StatelessWidget {
  final List<String> recentSearches;
  final TextEditingController searchController;

  const RecentSearchSection({
    super.key,
    required this.recentSearches,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.local.recent_searches),
              GestureDetector(
                onTap: cubit.clearRecent,
                child: Text(
                  context.local.clear_all,
                  style: TextStyle(color: context.theme.colors.primary),
                ),
              ),
            ],
          ),
          const Gap(12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: recentSearches.map((text) {
              return SellioChip(
                label: text,
                selected: false,
                onTap: () {
                  searchController.text = text;
                  cubit.selectRecent(text);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
