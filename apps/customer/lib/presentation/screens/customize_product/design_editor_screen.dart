import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'cubit/design_editor_cubit.dart';
import 'cubit/design_editor_state.dart';
import 'widgets/product_image.dart';
import 'widgets/price_quantity_row.dart';
import 'widgets/color_selector.dart';
import 'widgets/size_selector.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/upload_logo_section.dart';

class DesignEditorScreen extends StatelessWidget {
  const DesignEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DesignEditorCubit(),
      child: const _DesignEditorView(),
    );
  }
}

class _DesignEditorView extends StatelessWidget {
  const _DesignEditorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: const SellioAppBar(
        showBackButton: true,
        title: 'Design editor',
        centerTitle: false,
      ),
      body: BlocConsumer<DesignEditorCubit, DesignEditorState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(overlayImage: state.overlayImage),
                      const SizedBox(height: 16),
                      PriceQuantityRow(
                        price: state.price,
                        oldPrice: state.oldPrice.toDouble(),
                        quantity: state.quantity,
                        onIncrease: () => context.read<DesignEditorCubit>().increaseQuantity(),
                        onDecrease: () => context.read<DesignEditorCubit>().decreaseQuantity(),
                      ),
                      const SizedBox(height: 24),
                      ColorSelector(
                        colors: state.availableColors,
                        selectedIndex: state.selectedColorIndex,
                        onSelect: (index) => context.read<DesignEditorCubit>().selectColor(index),
                      ),
                      const SizedBox(height: 24),
                      SizeSelector(
                        sizes: state.availableSizes,
                        selectedIndex: state.selectedSizeIndex,
                        onSelect: (index) => context.read<DesignEditorCubit>().selectSize(index),
                      ),
                      const SizedBox(height: 24),
                      UploadLogoSection(
                        onImageSelected: (image) {
                          context.read<DesignEditorCubit>().setOverlayImage(image!);
                        },
                        selectedImage: state.overlayImage,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              BottomButtons(
                onAddToCart: () => context.read<DesignEditorCubit>().addToCart(),
                onReset: () => context.read<DesignEditorCubit>().reset(),
              ),
            ],
          );
        },
      ),
    );
  }
}
