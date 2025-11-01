import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/ui/screens/customize_your_product_screen/widgets/GridProduct.dart';

import '../../../core/design_system/widgets/chip_category.dart';

class CustomizeYourProductScreen extends StatefulWidget {
  const CustomizeYourProductScreen({super.key});

  @override
  State<CustomizeYourProductScreen> createState() =>
      _CustomizeYourProductScreenState();
}

class _CustomizeYourProductScreenState
    extends State<CustomizeYourProductScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Clothes",
      "Accessories & Gifts",
      "Home & Decore",
      "Tech Accessories",
      "Business & Branding",
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(138),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customize your product",
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Choose a product to customize it",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/ic_package_process.svg',
                          height: 28,
                          width: 28,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (BuildContext context, int index) {
                        final isSelected = _selectedCategoryIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChipCategory(
                            label: categories[index],
                            selected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(slivers: [GridProduct()]),
    );
  }
}
