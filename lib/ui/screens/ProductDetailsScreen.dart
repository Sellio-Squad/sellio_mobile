import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/textField.dart';

void main() {
  runApp(
    SellioThemeProvider(brightness: Brightness.light, child: MyPreviewApp()),
  );
}

class MyPreviewApp extends StatelessWidget {
  const MyPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductDetailsScreen(),
    );
  }
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;
  int productCount = 1;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SellioAppBar(
        leading: IconButton(
          icon: SvgPicture.asset(Assets.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
          padding: EdgeInsets.zero,
        ),
        centerWidget: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Fresh Lemon Cake',
            style: context.theme.typography.textTheme.titleMedium.copyWith(
              color: context.theme.colors.title,
            ),
          ),
        ),
        trailing: IconButton(
          icon: SvgPicture.asset(
            _isFavorite ? Assets.favorite : Assets.unselectedFavorite,
            width: 28,
            height: 28,
          ),
          onPressed: _toggleFavorite,
          padding: EdgeInsets.zero,
        ),
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
                      '\$16.99',
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
                        '\$12.99',
                        style: context.theme.typography.textTheme.titleSmall
                            .copyWith(color: context.theme.colors.primary),
                      ),
                    ),
                    const Expanded(child: Spacer()),
                    GestureDetector(
                      onTap: null,
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
                        '01',
                        style: context.theme.typography.textTheme.labelMedium
                            .copyWith(color: context.theme.colors.title),
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'A soft, fluffy cake with a refreshing lemon flavor, baked '
                            'daily using 100% natural ingredients and premium butter '
                            'for a rich, balanced flavor.\n It\'s topped with a light'
                            ' layer of whipped lemon cream, combining sweetness with '
                            'refreshing tartness in every bite.',
                        style: context.theme.typography.textTheme.bodyMedium
                            .copyWith(color: context.theme.colors.body),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SellioTextField(
              isParagraph: true,
              hintText: "Note  (Optional)",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SellioButton(
          text: "Add to cart",
          onTap: () {},
          suffixSvgPath: Assets.cart,
        ),
      ),
    );
  }
}
