import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';

import '../../../../core/design_system/widgets/cards/storeCard.dart';
import '../../../../core/design_system/widgets/section_header.dart';

class Store{
  final String name;
  final String imageUrl;
  final String? discount;

  Store({required this.name, required this.imageUrl, required this.discount});
}

class TopStoresSection extends StatelessWidget {
  final List<Store> topStores;
  final VoidCallback onLikePressed;
  final VoidCallback onCardPressed;

  const TopStoresSection({super.key, required this.topStores, required this.onLikePressed, required this.onCardPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Top Stores',
          onTap: () {},
          trailing: SvgPicture.asset(Assets.arrowRight, width: 20, height: 20),
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
              onLikePressed: () {
                onLikePressed();
              },
              onCardPressed: () {
                onCardPressed();
              },
            );
          },
        )      ],
    );
  }
}
