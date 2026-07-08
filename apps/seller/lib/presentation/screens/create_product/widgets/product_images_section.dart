import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/create_product_state.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final state = context.read<CreateProductCubit>().state;
      if (state is CreateProductFormState) {
        if (state.mainImagePath == null) {
          context.read<CreateProductCubit>().updateMainImage(image.path);
        } else {
          context.read<CreateProductCubit>().addAdditionalImage(image.path);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        if (state is! CreateProductFormState) return const SizedBox.shrink();

        final allImages = [
          if (state.mainImagePath != null) state.mainImagePath!,
          ...state.additionalImagePaths,
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Images',
              style: context.theme.typography.textTheme.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.colors.title,
              ),
            ),
            const Gap(4),
            Text(
              'store photo',
              style: context.theme.typography.textTheme.bodyMedium.copyWith(
                color: context.theme.colors.body,
              ),
            ),
            const Gap(16),
            Center(
              child: GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  width: 140,
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.theme.colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: context.theme.colors.stroke.withOpacity(0.5)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.imageUpload,
                        width: 48,
                        height: 48,
                        colorFilter: ColorFilter.mode(
                          context.theme.colors.title,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Upload',
                        style: context.theme.typography.textTheme.bodyMedium
                            .copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.theme.colors.title,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(24),
            if (allImages.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allImages.map((path) {
                    final isMain = path == state.mainImagePath;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: context.theme.colors.purpleVariant,
                              border: Border.all(
                                color: isMain
                                    ? context.theme.colors.primary
                                    : context.theme.colors.stroke,
                                width: isMain ? 2 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -8,
                            right: -8,
                            child: GestureDetector(
                              onTap: () {
                                if (isMain) {
                                  context
                                      .read<CreateProductCubit>()
                                      .updateMainImage('');
                                } else {
                                  context
                                      .read<CreateProductCubit>()
                                      .removeAdditionalImage(path);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: context.theme.colors.body,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }
}
