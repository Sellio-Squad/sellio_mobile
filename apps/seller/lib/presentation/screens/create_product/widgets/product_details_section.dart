import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Details (Optional)',
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colors.title,
              ),
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: SellioPickerField<String>(
                    hintText: 'Color',
                    items: state.colors
                        .map((c) => SellioPickerItem(c['id']!, c['name']!))
                        .toList(),
                    value: state.colorId.isEmpty ? null : state.colorId,
                    onChanged: (value) => context
                        .read<CreateProductCubit>()
                        .updateColor(value ?? ''),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: SellioPickerField<String>(
                    hintText: 'Size',
                    items: state.sizes
                        .map((s) => SellioPickerItem(s['id']!, s['name']!))
                        .toList(),
                    value: state.sizeId.isEmpty ? null : state.sizeId,
                    onChanged: (value) => context
                        .read<CreateProductCubit>()
                        .updateSize(value ?? ''),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: SellioTextField(
                    hintText: 'Weight (g)',
                    inputType: TextInputType.number,
                    onChanged: (value) {
                      final weight = int.tryParse(value) ?? 0;
                      context.read<CreateProductCubit>().updateWeight(weight);
                    },
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: SellioPickerField<String>(
                    hintText: 'Discount',
                    items: state.discounts
                        .map((d) => SellioPickerItem(d['id']!, d['name']!))
                        .toList(),
                    value: state.discountId.isEmpty ? null : state.discountId,
                    onChanged: (value) => context
                        .read<CreateProductCubit>()
                        .updateDiscount(value ?? ''),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
