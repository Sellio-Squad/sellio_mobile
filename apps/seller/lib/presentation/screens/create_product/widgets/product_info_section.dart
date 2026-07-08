import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellioTextField(
              hintText: 'Product name',
              prefixIcon: SvgPicture.asset(
                AppImages.package,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
                  BlendMode.srcIn,
                ),
              ),
              onChanged: (value) =>
                  context.read<CreateProductCubit>().updateTitle(value),
            ),
            const Gap(16),
            SellioTextField(
              hintText: 'Description',
              isParagraph: true,
              maxLine: 6,
              onChanged: (value) =>
                  context.read<CreateProductCubit>().updateDescription(value),
            ),
          ],
        );
      },
    );
  }
}
