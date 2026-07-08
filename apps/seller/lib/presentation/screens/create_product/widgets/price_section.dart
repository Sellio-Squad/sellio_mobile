import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        final prefixTextStyle =
            context.theme.typography.textTheme.titleMedium.copyWith(
          color: context.theme.colors.body,
          fontWeight: FontWeight.bold,
        );

        const double prefixWidth = 24.0;
        const prefixPadding = EdgeInsets.only(left: 16, right: 10);

        return Row(
          children: [
            Expanded(
              child: SellioTextField(
                hintText: 'Price',
                inputType: TextInputType.number,
                prefixIcon: const SizedBox(
                  width: prefixWidth,
                  child: Center(
                    child: Icon(
                      Icons.payments_outlined,
                      size: 20,
                    ),
                  ),
                ),
                prefixIconPadding: prefixPadding,
                onChanged: (value) {
                  final price = double.tryParse(value) ?? 0.0;
                  context.read<CreateProductCubit>().updatePrice(price);
                },
              ),
            ),
            const Gap(12),
            Expanded(
              child: SellioTextField(
                hintText: 'Stock Quant..',
                inputType: TextInputType.number,
                prefixIcon: SizedBox(
                  width: prefixWidth,
                  child: Center(
                    child: Text(
                      '#',
                      style: prefixTextStyle,
                    ),
                  ),
                ),
                prefixIconPadding: prefixPadding,
                onChanged: (value) {
                  final stock = int.tryParse(value) ?? 0;
                  context.read<CreateProductCubit>().updateStock(stock);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
