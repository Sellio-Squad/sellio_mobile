import 'package:carousel_slider/carousel_slider.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/entities/offer.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/special_offers/carouselLayout.dart';

import 'special_offer_card.dart';

class SpecialOffersList extends StatefulWidget {
  final List<Offer> offers;
  final int currentPage;
  final Function(int page) onPageChanged;
  final void Function({required String id, required OfferActionType offerType})?
      onOfferTap;
  final VoidCallback? onSeeAllTap;

  const SpecialOffersList({
    super.key,
    required this.offers,
    required this.currentPage,
    required this.onPageChanged,
    this.onOfferTap,
    this.onSeeAllTap,
  });

  @override
  State<SpecialOffersList> createState() => _SpecialOffersListState();
}

class _SpecialOffersListState extends State<SpecialOffersList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: context.local.special_offers,
          onTap: widget.onSeeAllTap,
          trailing: SellioIndicator(
            pages: widget.offers.length,
            currentPage: widget.currentPage,
          ),
        ),
        const SizedBox(height: 12),
        _buildCarousel(),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildCarousel() {
    final layout = CarouselLayout.of(context);

    return CarouselSlider(
      items: widget.offers
          .map(
            (offer) => SpecialOfferCard(
              imageUrl: offer.imageUrl,
              onTap: () => widget.onOfferTap
                  ?.call(id: offer.actionId, offerType: offer.actionType),
            ),
          )
          .toList(),
      options: CarouselOptions(
        onPageChanged: (index, reason) => widget.onPageChanged(index),
        height: layout.height,
        viewportFraction: layout.viewportFraction,
        animateToClosest: true,
        enlargeCenterPage: layout.enlargeCenterPage,
        autoPlay: true,
        enlargeStrategy: layout.strategy,
        enlargeFactor: 0.5,
        autoPlayCurve: Curves.easeInOutQuint,
        enableInfiniteScroll: true,
        initialPage: widget.currentPage,
      ),
    );
  }
}
