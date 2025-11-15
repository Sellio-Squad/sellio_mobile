import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../core/design_system/widgets/cards/sellio_store_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';
import '../../../../domain/entities/store.dart';

class TopStoresSection extends StatelessWidget {
  final List<Store> stores;
  final Set<String> favoriteStoreIds;
  final Function(String storeId) onLikePressed;
  final Function(Store store) onStorePressed;

  const TopStoresSection({
    super.key,
    required this.stores,
    required this.favoriteStoreIds,
    required this.onLikePressed,
    required this.onStorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: context.local.top_stores,
          onTap: () {
            // TODO: Navigate to all stores
          },
          trailing: SvgPicture.asset(Assets.arrowRight, width: 20, height: 20),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            final isFavorite = favoriteStoreIds.contains(store.id);

            return SellioStoreCard(
              imageUrl: store.coverImage,
              title: store.name,
              discountText: store.sale,
              isFavorite: isFavorite,
              onLikePressed: () => onLikePressed(store.id),
              onCardPressed: () => onStorePressed(store),
            );
          },
        ),
      ],
    );
  }
}