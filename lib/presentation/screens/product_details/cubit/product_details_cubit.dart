import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/core/result.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';

import '../../../../domain/entities/product.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductRepository _repository;

  ProductDetailsCubit(this._repository) : super(ProductDetailsInitial());

  Future<void> loadProductDetails(String productId) async {
    emit(ProductDetailsLoading(productId: productId, product: Product.dummy()));
    final productResult = await _repository.getProductById(productId);
    final favoriteResult = await _repository.isFavorite(productId);

    if (productResult is Success && favoriteResult is Success) {
      emit(ProductDetailsLoading(
          product: productResult.data, isFavorite: favoriteResult.data, productId: productId));
    } else {
      final errorMessage = _extractErrorMessage([productResult]);
      emit(ProductDetailsError(message: errorMessage));
    }
  }
  final TextEditingController noteController = TextEditingController();
  void updateNote(String newNote) {
    final currentState = state;
    if (currentState is! ProductDetailsLoading) return;
    noteController.text = newNote;
    emit(currentState.copyWith(note: newNote));
  }

  void addToCart() {
    final currentState = state;
    if (currentState is! ProductDetailsLoading) return;

    // TODO
  }

  String _extractErrorMessage(List<Result> results) {
    for (final r in results) {
      if (r is ResultFailure) {
        return r.failure.message;
      }
    }
    return 'Something went wrong';
  }
}


// Future<void> toggleFavorite(String productId) async {
//   final currentState = state;
//   if (currentState is! ProductDetailsLoading) return;
//
//   emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
//   final result = await _repository.toggleFavoriteProduct(productId);
//   if(result is ResultFailure){
//     emit(currentState.copyWith(isFavorite: currentState.isFavorite));
//   }
// }
//
// void incrementProduct() {
//   final currentState = state;
//   if (currentState is! ProductDetailsLoading) return;
//
//   if (currentState.productCount < currentState.product.stockQuantity) {
//     emit(currentState.copyWith(productCount: currentState.productCount + 1));
//   }
// }
//
// void decrementProduct() {
//   final currnetState = state;
//   if (currnetState is! ProductDetailsLoading) return;
//
//   if (currnetState.productCount > currnetState.product.stockQuantity) {
//     emit(currnetState.copyWith(productCount: currnetState.productCount - 1));
//   }
// }






//   ProductDetailsCubit({
//     required String productName,
//     bool? isFavorite,
//     required String productDescription,
//     required double productPrice,
//     double? productPriceBeforeDiscount,
//     required int productCount,
//     String? note,
//     Function(bool p1)? onFavoriteChanged,
//
//     /// checkkkkk
//     ///
//     ///
//     ///
//   }) : super(ProductDetailsState(
//           productName: productName,
//           productDescription: productDescription,
//           productPrice: productPrice,
//           productCount: productCount,
//           isFavorite: isFavorite,
//           productPriceBeforeDiscount: productPriceBeforeDiscount,
//           note: note,
//         ));
//
//   void toggleFavorite() {
//     emit(state.copyWith(isFavorite: !(state.isFavorite ?? false)));
//   }
//
//   void incrementProduct() {
//     emit(state.copyWith(productCount: state.productCount + 1));
//   }
//
//   void decrementProduct() {
//     if (state.productCount > 0) {
//       emit(state.copyWith(productCount: state.productCount - 1));
//     }
//   }
//
//   void updateNote() {
//     emit(state.copyWith(note: state.note));
//   }
//
//   void clearNote() {
//     emit(state.copyWith(note: ''));
//   }
//
//   void addToCart() {}
// }
