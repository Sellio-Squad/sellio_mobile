import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_snack_bar.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_cubit.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';

class ProductDetailsListener extends StatelessWidget {
  final Widget child;

  const ProductDetailsListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsAddToCartSuccess) {
            _handleSuccess(context, state);
          } else if (state is ProductDetailsError) {
            _handleError(context, state);
          }
        },
      ),
    ], child: child);
  }

  void _handleSuccess(BuildContext context, ProductDetailsAddToCartSuccess state) {
    _showSuccessSnackBar(context, 'Product added successfully');
  }
  void _handleError(BuildContext context, ProductDetailsError state) {
    _showSuccessSnackBar(context, 'Something went wrong', isError: true);
  }

  void _showSuccessSnackBar(BuildContext context, String message , {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + 26,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SellioSnackBar(
                  isError: isError,
                  message: message,
                  onCancelTap: () {
                    overlayEntry.remove();
                  },
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    }
    );
  }
}
