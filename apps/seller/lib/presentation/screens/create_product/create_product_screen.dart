import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../di/injection_container.dart';
import 'cubit/create_product_cubit.dart';
import 'cubit/create_product_state.dart';
import 'widgets/category_selection_section.dart';
import 'widgets/featured_toggle_section.dart';
import 'widgets/price_section.dart';
import 'widgets/product_details_section.dart';
import 'widgets/product_images_section.dart';
import 'widgets/product_info_section.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateProductCubit>()..initForm(),
      child: const CreateProductView(),
    );
  }
}

class CreateProductView extends StatelessWidget {
  const CreateProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProductCubit, CreateProductState>(
      listener: (context, state) {
        if (state is CreateProductFormState) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product created successfully!')),
            );
            context.pop();
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: context.theme.colors.semanticError,
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: SellioAppBar(
          title: 'Add New Product',
          centerTitle: false,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppImages.arrowLeft,
              colorFilter: ColorFilter.mode(
                context.theme.colors.title,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ProductInfoSection(),
                      ),
                      const Gap(20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: PriceSection(),
                      ),
                      const Gap(24),
                      const CategorySelectionSection(),
                      const Gap(24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ProductDetailsSection(),
                      ),
                      const Gap(24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ProductImagesSection(),
                      ),
                      const Gap(24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FeaturedToggleSection(),
                      ),
                      const Gap(32),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<CreateProductCubit, CreateProductState>(
                  builder: (context, state) {
                    final isSubmitting =
                        state is CreateProductFormState && state.isSubmitting;
                    return SellioButton(
                      text: 'Save Product',
                      onTap: isSubmitting
                          ? null
                          : () => context.read<CreateProductCubit>().submit(),
                      isLoading: isSubmitting,
                      backgroundColor: context.theme.colors.primary,
                      textStyle: context.theme.typography.textTheme.titleMedium
                          .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
