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
      )
    );
  }
}
