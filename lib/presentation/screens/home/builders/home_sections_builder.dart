import 'package:flutter/material.dart';
import 'sections/category_tabs_builder.dart';
import 'sections/products_section_builder.dart';
import 'sections/search_section_builder.dart';
import 'sections/special_offers_section_builder.dart';
import 'sections/top_stores_section_builder.dart';

List<Widget> buildHomeSections(BuildContext context) {
  return [
    buildSearchSection(context),
    buildCategoryTabs(),
    buildSpecialOffersSection(),
    buildProductsSection(),
    buildTopStoresSection(),
    const SliverToBoxAdapter(child: SizedBox(height: 24)),
  ];
}