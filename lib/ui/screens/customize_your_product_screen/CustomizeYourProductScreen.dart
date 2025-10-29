import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/ui/screens/customize_your_product_screen/GridProduct.dart';
import '../../../core/design_system/constants/assets.dart';
import 'category.dart';

class CustomizeYourProductScreen extends StatefulWidget {
  const CustomizeYourProductScreen({super.key});

  @override
  State<CustomizeYourProductScreen> createState() =>
      _CustomizeYourProductScreenState();
}

class _CustomizeYourProductScreenState
    extends State<CustomizeYourProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SellioAppBar(
        title: "Customize Your Product ",
        showLeading: false,
        subtitle: "Choose a product to customize it ",
        actionIcon: Assets.orderIcon,
      ),
      body: CustomScrollView(
          slivers: [
            CategoryWidget(),
            GridProduct()
          ]
      ),
    );
  }
}
