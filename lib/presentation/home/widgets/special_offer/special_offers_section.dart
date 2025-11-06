import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/indicator.dart';
import 'package:sellio_mobile/core/design_system/widgets/section_header.dart';

import 'special_offer_card.dart';

class SpecialOffersSection extends StatefulWidget {
  final List<SpecialOfferModel> offers;
  final Function(String offerId)? onOfferTap;
  final VoidCallback? onSeeAllTap;

  const SpecialOffersSection({
    super.key,
    required this.offers,
    this.onOfferTap,
    this.onSeeAllTap,
  });

  @override
  State<SpecialOffersSection> createState() => _SpecialOffersSectionState();
}

class _SpecialOffersSectionState extends State<SpecialOffersSection> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        SectionHeader(
          title: 'Special Offers',
          onTap: widget.onSeeAllTap,
          trailing: Indicator(
            pages: widget.offers.length,
            currentPage: _currentPage,
          ),
        ),

        const SizedBox(height: 12),

        // Offers PageView
        SizedBox(
          height: 144,
          width: double.infinity,
          child: PageView.builder(
            pageSnapping: true,
            controller: _pageController,
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.offers[index];
              return
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SpecialOfferCard(
                  imageUrl: offer.imageUrl,
                  onTap: () => widget.onOfferTap?.call(offer.id),
                                ),
                );
            },
          ),
        ),
        const SizedBox(height: 12),
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
