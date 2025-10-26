import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/widgets/indicator.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offer_card.dart';

class SpecialOffersSection extends StatefulWidget {
  final List<SpecialOfferModel> offers;
  final Function(String offerId)? onOfferTap;

  const SpecialOffersSection({
    super.key,
    required this.offers,
    this.onOfferTap,
  });

  @override
  State<SpecialOffersSection> createState() => _SpecialOffersSectionState();
}

class _SpecialOffersSectionState extends State<SpecialOffersSection> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
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
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Special Offers',
                style: textTheme.titleLarge.copyWith(
                  color: colors.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all offers
                },
                child: Text(
                  'See All',
                  style: textTheme.labelMedium.copyWith(
                    color: colors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Offers PageView
        SizedBox(
          height: 144,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.offers[index];
              return SpecialOfferCard(
                imageUrl: offer.imageUrl,
                title: offer.title,
                discount: offer.discount,
                onTap: () => widget.onOfferTap?.call(offer.id),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Page Indicator
        Center(
          child: Indicator(
            pages: widget.offers.length,
            currentPage: _currentPage,
          ),
        ),
      ],
    );
  }
}

// Model class for Special Offers
class SpecialOfferModel {
  final String id;
  final String imageUrl;
  final String title;
  final String discount;

  SpecialOfferModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.discount,
  });
}