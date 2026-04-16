import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/domain/entities/store.dart';

import '../../../../../../core/localization/l10n/localization_service.dart';

class StoresList extends StatelessWidget {
  final List<Store> stores;
  final Function(Store store) onLikePressed;
  final Function(Store store) onStorePressed;
  final bool Function(Store store)? isStoreFavorited; // Optional callback

  const StoresList({
    super.key,
    required this.stores,
    required this.onLikePressed,
    required this.onStorePressed,
    this.isStoreFavorited,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: context.local.top_stores,
          trailing: SvgPicture.asset(
            AppImages.arrowRight,
            width: 20,
            height: 20,
            matchTextDirection: true,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            final isFavorite = isStoreFavorited != null
                ? isStoreFavorited!(store)
                : store.isFavorite;

            return SellioStoreCard(
              imageUrl: store.coverImage,
              title: store.name,
              discountText: store.sale,
              isFavorite: isFavorite,
              onLikePressed: () => onLikePressed(store),
              onCardPressed: () => onStorePressed(store),
            );
          },
        ),
      ],
    );
  }
}
