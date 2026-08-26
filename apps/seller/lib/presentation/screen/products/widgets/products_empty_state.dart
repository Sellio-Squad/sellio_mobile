import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';

class ProductsEmptyState extends StatelessWidget {
  final bool isFiltered;
  final VoidCallback onRefresh;

  const ProductsEmptyState({
    super.key,
    required this.isFiltered,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isFiltered) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24.5),
                decoration: BoxDecoration(
                  color: context.theme.colors.primaryVariant,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search_off, size: 48),
              ),
              const SizedBox(height: 12),
              Text(
                context.local.no_products_found,
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  color: context.theme.colors.title,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                context.local.no_products_found_description,
                style: context.theme.typography.textTheme.bodySmall.copyWith(
                  color: context.theme.colors.body,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: EmptySection(
        icon: AppImages.product,
        title: context.local.no_products_yet,
        description: context.local.start_adding_products,
        buttonText: context.local.add_product,
        color: context.theme.colors.primaryVariant,
        onTap: () {},
      ),
    );
  }
}
