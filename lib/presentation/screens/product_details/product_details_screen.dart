import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/text_field.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../core/design_system/widgets/sellio_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productCount;
  final String productDescription;
  final double productPrice;

  final double? productPriceBeforeDiscount;

  const ProductDetailsScreen({
    super.key,
    required this.productCount,
    required this.productDescription,
    required this.productPrice,
    this.productPriceBeforeDiscount,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;
  late int productCount = widget.productCount;
  String noteText = '';

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void incrementProduct() {
    setState(() {
      productCount++;
    });
  }

  void decrementProduct() {
    setState(() {
      if (productCount > 0) {
        productCount--;
      }
    });
  }

  void productNote() {
    setState(() {
      noteText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        showBackButton: true,
        title: 'Fresh Lemon Cake',
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              _isFavorite ? Assets.favorite : Assets.unselectedFavorite,
              width: 28,
              height: 28,
            ),
            onPressed: _toggleFavorite,
            padding: EdgeInsets.zero,
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey[200],
                        child: Image.asset(
                          'assets/images/lemon_popsicle.jpg',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 110,
                        height: 110,
                        color: Colors.grey[200],
                        child: Image.asset(
                          'assets/images/lemon_cheesecake.jpg',
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 224,
                      color: Colors.grey[200],
                      child: Image.asset(
                        'assets/images/lemon_cake_main.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      widget.productPriceBeforeDiscount == null
                          ? ''
                          : '\$${widget.productPriceBeforeDiscount}',
                      style: context.theme.typography.textTheme.titleSmall
                          .copyWith(
                            color: context.theme.colors.hint,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: context.theme.colors.hint,
                          ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        '\$${widget.productPrice}',
                        style: context.theme.typography.textTheme.titleSmall
                            .copyWith(color: context.theme.colors.primary),
                      ),
                    ),
                    const Expanded(child: Spacer()),
                    GestureDetector(
                      onTap: decrementProduct,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: context.theme.colors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.remove,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                context.theme.colors.body,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 8,
                      ),
                      child: Text(
                        productCount < 10 ? '0$productCount' : '$productCount',
                        style: context.theme.typography.textTheme.labelMedium
                            .copyWith(color: context.theme.colors.title),
                      ),
                    ),
                    GestureDetector(
                      onTap: incrementProduct,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: context.theme.colors.primaryVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.add,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                context.theme.colors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    widget.productDescription,
                    style: context.theme.typography.textTheme.bodyMedium
                        .copyWith(color: context.theme.colors.body),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SellioTextField(
              isParagraph: true,
              hintText: context.local.note_optional,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        child: SellioButton(
          text: context.local.add_to_cart,
          onTap: () {},
          suffixSvgPath: Assets.cart,
        ),
      ),
    );
  }
}
