import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'design_editor_state.dart';

class DesignEditorCubit extends Cubit<DesignEditorState> {
  DesignEditorCubit() : super(DesignEditorState.initial());

  void increaseQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }
  void decreaseQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
  void setQuantity(int quantity) {
    if (quantity >= 1) {
      emit(state.copyWith(quantity: quantity));
    }
  }
  void selectColor(int index) {
    if (index >= 0 && index < state.availableColors.length) {
      emit(state.copyWith(selectedColorIndex: index));
    }
  }
  void selectSize(int index) {
    if (index >= 0 && index < state.availableSizes.length) {
      emit(state.copyWith(selectedSizeIndex: index));
    }
  }
  void setOverlayImage(File image) {
    emit(state.copyWith(overlayImage: image));
  }
  void removeOverlayImage() {
    emit(state.copyWith(clearOverlayImage: true));
  }
  void reset() {
    emit(DesignEditorState.initial());
  }
  Future<void> addToCart() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      // TODO: Call your cart service/repository here
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add to cart: ${e.toString()}',
      ));
    }
  }
  void updatePrice(double price, {double? oldPrice}) {
    emit(state.copyWith(price: price, oldPrice: oldPrice));
  }
}
