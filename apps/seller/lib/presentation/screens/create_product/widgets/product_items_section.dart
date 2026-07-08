import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';
import 'add_item_dialog.dart';

class ProductItemsSection extends StatelessWidget {
  const ProductItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Variants (Items)',
                  style: context.theme.typography.textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: () => _showAddItemDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                  style: TextButton.styleFrom(
                    foregroundColor: context.theme.colors.primary,
                  ),
                ),
              ],
            ),
            const Gap(8),
            if (state.items.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No items added yet.',
                    style:
                        context.theme.typography.textTheme.bodyMedium.copyWith(
                      color: context.theme.colors.neutralsHint,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                separatorBuilder: (_, __) => const Gap(8),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return Card(
                    color: context.theme.colors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: context.theme.colors.stroke),
                    ),
                    child: ListTile(
                      title: Text(
                        'Price: ${item.price} - Stock: ${item.stock}',
                        style: context.theme.typography.textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        'Color: ${item.colorId ?? 'N/A'}, Size: ${item.sizeId ?? 'N/A'}',
                        style: context.theme.typography.textTheme.labelSmall,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: context.theme.colors.semanticError,
                        ),
                        onPressed: () => context
                            .read<CreateProductCubit>()
                            .removeItem(index),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<CreateProductCubit>(),
        child: const AddItemDialog(),
      ),
    );
  }
}
