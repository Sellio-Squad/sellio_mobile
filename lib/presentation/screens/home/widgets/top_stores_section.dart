import 'package:flutter/cupertino.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/sellio_store_card.dart';

class Store {
  final String id;
  final String name;
  final String imageUrl;
  final String? discount;
  final String? coverImage;
  final String? profileImage;
  final double? rating;
  bool isFavorite;

  Store({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.discount,
    this.coverImage,
    this.profileImage,
    this.rating,
    this.isFavorite = false,
  });
}

class TopStoresSection extends StatelessWidget {
  final List<Store> topStores;
  final void Function(String)? onLikePressed;
  final void Function(String)? onCardPressed;

  final String? sectionTitle;
  final bool showHeader;

  const TopStoresSection({
    super.key,
    required this.topStores,
    this.onLikePressed,
    this.onCardPressed,
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
            return SellioStoreCard(
              imageUrl: store.imageUrl,
              title: store.name,
              discountText: store.discount,
              onLikePressed: onLikePressed != null
                  ? () => onLikePressed!(store.id)
                  : null,
              onCardPressed: onCardPressed != null
                  ? () => onCardPressed!(store.id)
                  : null,
            );
          },
        ),
      ],
    );
  }
}