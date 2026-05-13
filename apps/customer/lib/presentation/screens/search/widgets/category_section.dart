import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../cubit/search_cubit.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SellioChip(
                label: context.local.products,
                assetIcon: AppImages.product,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  8,
                  6,
                  12,
                  6,
                ),
                selected: state.selectedType == SearchType.products,
                onTap: () => cubit.selectTab(SearchType.products),
              ),
              const Gap(8),
              SellioChip(
                label: context.local.stores,
                assetIcon: AppImages.storeIcon,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  8,
                  6,
                  12,
                  6,
                ),
                selected: state.selectedType == SearchType.stores,
                onTap: () => cubit.selectTab(SearchType.stores),
              ),
            ],
          ),
        );
      },
    );
  }
}
