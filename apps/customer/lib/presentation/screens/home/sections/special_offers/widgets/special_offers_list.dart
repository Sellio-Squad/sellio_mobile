import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../../domain/entities/special_offer.dart';
import 'special_offer_card.dart';

class SpecialOffersList extends StatefulWidget {
  final List<SpecialOffer> offers;
  final int currentPage;
  final Function(int page) onPageChanged;
  final Function(String offerId)? onOfferTap;
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: widget.currentPage,
    );
    _pageController.addListener(_onPageChanged);
  }

  @override
  void didUpdateWidget(SpecialOffersList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      _pageController.animateToPage(
        widget.currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != widget.currentPage) {
      widget.onPageChanged(page);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

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
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.offers[index];
              return SpecialOfferCard(
                imageUrl: offer.imageUrl,
                onTap: () => widget.onOfferTap?.call(offer.id),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
