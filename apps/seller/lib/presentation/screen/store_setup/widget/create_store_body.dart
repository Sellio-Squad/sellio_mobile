import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/sellio_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';

import '../cubit/create_store_cubit.dart';
import '../cubit/create_store_state.dart';
import 'create_store_header.dart';

class CreateStoreBody extends StatefulWidget {
  const CreateStoreBody({super.key});

  @override
  State<CreateStoreBody> createState() => _CreateStoreBodyState();
}

class _CreateStoreBodyState extends State<CreateStoreBody> {
  late final TextEditingController _storeNameController;
  late final TextEditingController _descriptionController;

  late final FocusNode _storeNameFocusNode;
  late final FocusNode _descriptionFocusNode;

  CreateStoreIdle? _lastIdleState;

  @override
  void initState() {
    super.initState();
    _storeNameController = TextEditingController();
    _descriptionController = TextEditingController();

    _storeNameFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();

    _setupListeners();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubitState = context.read<CreateStoreCubit>().state;
    if (cubitState is CreateStoreIdle && _lastIdleState == null) {
      _lastIdleState = cubitState;
    }
  }

  void _setupListeners() {
    final cubit = context.read<CreateStoreCubit>();
    _storeNameController.addListener(() {
      cubit.updateStoreName(_storeNameController.text);
    });
    _descriptionController.addListener(() {
      cubit.updateDescription(_descriptionController.text);
    });

    _storeNameFocusNode.addListener(() {
      if (!_storeNameFocusNode.hasFocus) {
        cubit.validateStoreNameOnFocusLost(_storeNameController.text);
      }
    });

    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        cubit.validateDescriptionOnFocusLost(_descriptionController.text);
      }
    });
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _storeNameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateStoreCubit, CreateStoreState>(
      builder: (context, state) {
        if (state is CreateStoreIdle) {
          _lastIdleState = state;
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CreateStoreHeader(),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildForm(state),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildFooter(state),
          ],
        );
      },
    );
  }

  Widget _buildForm(CreateStoreState state) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    final displayState = _lastIdleState;
    if (displayState == null) return const SizedBox.shrink();

    final isSubmitting = state is CreateStoreSubmitting;

    return IgnorePointer(
      ignoring: isSubmitting,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isSubmitting ? 0.6 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellioTextField(
              controller: _storeNameController,
              hintText: context.local.store_name,
              isError: displayState.nameError != null,
              errorMessage: displayState.nameError?.toLocalizedString(context),
              prefixIcon: SvgPicture.asset(
                AppImages.store,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(colors.body, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 16),
            SellioTextField(
              controller: _descriptionController,
              hintText: context.local.description,
              isParagraph: true,
              maxLine: 4,
              isError: displayState.descriptionError != null,
              errorMessage:
                  displayState.descriptionError?.toLocalizedString(context),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SellioPickerField<Country>(
                    hintText: context.local.country,
                    value: displayState.selectedCountry,
                    errorText:
                        displayState.countryError?.toLocalizedString(context),
                    prefixIcon: SvgPicture.asset(
                      AppImages.locationPin,
                      width: 24,
                      height: 24,
                      colorFilter:
                          ColorFilter.mode(colors.body, BlendMode.srcIn),
                    ),
                    items: ['IQ', 'EG', 'SY', 'PS'].map((code) {
                      final country = Country.parse(code);
                      return SellioPickerItem(country, country.name);
                    }).toList(),
                    onChanged: (country) {
                      if (country != null) {
                        context
                            .read<CreateStoreCubit>()
                            .updateSelectedCountry(country);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SellioPickerField<String>(
                    hintText: context.local.city,
                    value:
                        displayState.city.isNotEmpty ? displayState.city : null,
                    enabled: displayState.selectedCountry != null,
                    errorText:
                        displayState.cityError?.toLocalizedString(context),
                    items: displayState.cities
                        .map((city) => SellioPickerItem(city, city))
                        .toList(),
                    onChanged: (city) {
                      if (city != null) {
                        context.read<CreateStoreCubit>().updateCity(city);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              context.local.store_category,
              style: typography.textTheme.titleMedium
                  .copyWith(color: colors.title),
            ),
            const SizedBox(height: 12),
            _buildCategoryChips(displayState),
            const SizedBox(height: 24),
            Text(
              context.local.store_photo,
              style: typography.textTheme.titleMedium
                  .copyWith(color: colors.title),
            ),
            const SizedBox(height: 12),
            Center(
              child: _buildImageUpload(
                image: displayState.storeImage,
                onTap: () => context.read<CreateStoreCubit>().pickStoreImage(),
                error: displayState.imageError?.toLocalizedString(context),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.local.store_cover_image,
              style: typography.textTheme.titleMedium
                  .copyWith(color: colors.title),
            ),
            const SizedBox(height: 12),
            _buildImageUpload(
              image: displayState.coverImage,
              onTap: () => context.read<CreateStoreCubit>().pickCoverImage(),
              error: displayState.coverImageError?.toLocalizedString(context),
              isCover: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips(CreateStoreIdle state) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: state.allCategories.map((category) {
        final isSelected =
            state.selectedCategories.any((c) => c.id == category.id);
        return SellioChip(
          label: category.name,
          selected: isSelected,
          onTap: () =>
              context.read<CreateStoreCubit>().toggleCategory(category),
        );
      }).toList(),
    );
  }

  Widget _buildImageUpload({
    File? image,
    required VoidCallback onTap,
    String? error,
    bool isCover = false,
  }) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: isCover ? double.infinity : 144,
            height: 112,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: error != null ? Colors.red : colors.stroke,
                width: 1,
              ),
            ),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(image, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.upload,
                        width: 48,
                        height: 48,
                        colorFilter:
                            ColorFilter.mode(colors.body, BlendMode.srcIn),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.local.upload,
                        style: typography.textTheme.bodySmall
                            .copyWith(color: colors.body),
                      ),
                    ],
                  ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error,
            style: typography.textTheme.labelSmall.copyWith(color: Colors.red),
          ),
        ],
      ],
    );
  }

  Widget _buildFooter(CreateStoreState state) {
    final isLoading = state is CreateStoreSubmitting;
    final isEnabled = _lastIdleState?.isFormValid ?? false;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SellioButton(
          text: context.local.create_store,
          onTap: isEnabled && !isLoading
              ? () => context.read<CreateStoreCubit>().createStore()
              : null,
          isLoading: isLoading,
          isEnabled: isEnabled,
          suffixSvgPath: AppImages.arrowRight,
        ),
      ),
    );
  }
}
