import 'dart:io';
import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

class DesignEditorState {
  final int quantity;
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final File? overlayImage;
  final List<Color> availableColors;
  final List<ProductSize> availableSizes;
  final double price;
  final double oldPrice;
  final bool isLoading;
  final String? errorMessage;

  const DesignEditorState({
    this.quantity = 1,
    this.selectedColorIndex = 0,
    this.selectedSizeIndex = 0,
    this.overlayImage,
    required this.availableColors,
    required this.availableSizes,
    required this.price,
    required this.oldPrice,
    this.isLoading = false,
    this.errorMessage,
  });

  factory DesignEditorState.initial() {
    return DesignEditorState(
      quantity: 1,
      selectedColorIndex: 0,
      selectedSizeIndex: 0,
      overlayImage: null,
      availableColors: [
        SellioColors.productBlack,
        SellioColors.productWhite,
        SellioColors.productRed,
        SellioColors.productGreen,
        SellioColors.productPink,
        SellioColors.productYellow,
        SellioColors.productBlue,
      ],
      availableSizes: ProductSize.values,
      price: 12.99,
      oldPrice: 16.99,
      isLoading: false,
      errorMessage: null,
    );
  }

  DesignEditorState copyWith({
    int? quantity,
    int? selectedColorIndex,
    int? selectedSizeIndex,
    File? overlayImage,
    List<Color>? availableColors,
    List<ProductSize>? availableSizes,
    double? price,
    double? oldPrice,
    bool? isLoading,
    String? errorMessage,
    bool clearOverlayImage = false,
  }) {
    return DesignEditorState(
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      overlayImage: clearOverlayImage ? null : (overlayImage ?? this.overlayImage),
      availableColors: availableColors ?? this.availableColors,
      availableSizes: availableSizes ?? this.availableSizes,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Color get selectedColor => availableColors[selectedColorIndex];
  ProductSize get selectedSize => availableSizes[selectedSizeIndex];
  bool get hasOverlayImage => overlayImage != null;
  double get totalPrice => price * quantity;
}

enum ProductSize {
  S('S'),
  M('M'),
  L('L'),
  XL('XL'),
  XXL('2XL'),
  XXXL('3XL');

  const ProductSize(this.value);
  final String value;
}
