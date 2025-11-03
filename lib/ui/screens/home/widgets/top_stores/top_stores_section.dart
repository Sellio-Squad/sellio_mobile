import 'package:flutter/cupertino.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/store_card.dart';

class Store {
  final String name;
  final String imageUrl;
  final String? discount;

  Store({
    required this.name,
    required this.imageUrl,
    this.discount,
  });
}
class TopStoresSection extends StatelessWidget {
  final List<Store> topStores;
  final VoidCallback onLikePressed;
  final VoidCallback onCardPressed;

  final String? sectionTitle;
  final bool showHeader;

  const TopStoresSection({
    super.key,
    required this.topStores,
    required this.onLikePressed,
    required this.onCardPressed,
    this.sectionTitle,
    this.showHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader && sectionTitle != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              sectionTitle!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: topStores.length,
          itemBuilder: (context, index) {
            final store = topStores[index];
            return StoreCard(
              imageUrl: store.imageUrl,
              title: store.name,
              discountText: store.discount,
              onLikePressed: onLikePressed,
              onCardPressed: onCardPressed,
            );
          },
        ),
      ],
    );
  }
}
