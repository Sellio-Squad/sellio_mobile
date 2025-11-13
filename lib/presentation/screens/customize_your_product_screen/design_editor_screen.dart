import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import 'widgets/product_image.dart';
import 'widgets/price_quantity_row.dart';
import 'widgets/color_selector.dart';
import 'widgets/size_selector.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/upload_logo_section.dart';

class DesignEditorScreen extends StatefulWidget {
  const DesignEditorScreen({super.key});

  @override
  State<DesignEditorScreen> createState() => _DesignEditorScreenState();
}

class _DesignEditorScreenState extends State<DesignEditorScreen> {
  int quantity = 1;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  File? overlayImage;

  final List<Color> colors = [
    Colors.black,
    Colors.grey[300]!,
    Colors.red[300]!,
    Colors.green[300]!,
    Colors.pink[300]!,
    Colors.yellow[300]!,
    Colors.blue[300]!,
  ];

  final List<String> sizes = ['S', 'M', 'L', 'XL', '2XL', '3XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        showBackButton: true,
        title: context.local.design_editor,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImage(overlayImage: overlayImage),
                  const SizedBox(height: 16),
                  PriceQuantityRow(
                    price: 12.99,
                    oldPrice: 16.99,
                    quantity: quantity,
                    onIncrease: () => setState(() => quantity++),
                    onDecrease: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                  ),

                  const SizedBox(height: 24),
                  ColorSelector(
                    colors: colors,
                    selectedIndex: selectedColorIndex,
                    onSelect: (index) =>
                        setState(() => selectedColorIndex = index),
                  ),
                  const SizedBox(height: 24),
                  SizeSelector(
                    sizes: sizes,
                    selectedIndex: selectedSizeIndex,
                    onSelect: (index) =>
                        setState(() => selectedSizeIndex = index),
                  ),
                  const SizedBox(height: 24),
                  UploadLogoSection(
                    onImageSelected: (image) {
                      setState(() {
                        overlayImage = image;
                      });
                    },
                    selectedImage: overlayImage,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          BottomButtons(
            onAddToCart: () {},
            onReset: () => setState(() {
              quantity = 1;
              selectedColorIndex = 0;
              selectedSizeIndex = 0;
              overlayImage = null;
            }),
          ),
        ],
      ),
    );
  }
}
