import 'package:flutter/material.dart';
import 'package:sellio_mobile/ui/screens/store_details/store_details_screen.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';

import 'empty_favorites_state.dart';

class StoresSection extends StatelessWidget {
  final List<dynamic> stores;

  const StoresSection({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) {
      return const SliverToBoxAdapter(child: EmptyFavoritesWidget());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: TopStoresSection(
          topStores: List<Store>.from(stores),
          onLikePressed: () {},
          onCardPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StoreDetailsScreen(
                  storeId: '123',
                  coverImage: 'assets/images/product_3.webp',
                  profileImage: 'assets/images/product_3.webp',
                  storeName: "Sweet Lovers - Pasteleria",
                  rating: 3.8,
                  discount: '40',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
