import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class CategorySelectionSection extends StatelessWidget {
  const CategorySelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Store category',
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colors.title,
                ),
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SellioPickerField<String>(
                      hintText: 'Category',
                      items: state.categories
                          .map((cat) => SellioPickerItem(cat.id, cat.name))
                          .toList(),
                      value: state.categoryId.isEmpty ? null : state.categoryId,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<CreateProductCubit>()
                              .updateCategory(value);
                        }
                      },
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: SellioPickerField<String>(
                      hintText: 'Subcategory',
                      items: state.subcategories
                          .map((sub) => SellioPickerItem(sub.id, sub.name))
                          .toList(),
                      value: state.subCategoryIds.isEmpty
                          ? null
                          : state.subCategoryIds.first,
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<CreateProductCubit>()
                              .updateSubCategories([value]);
                        }
                      },
                      // Disable if no category selected or still loading
                      enabled: state.categoryId.isNotEmpty &&
                          !state.isLoadingMetadata,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
