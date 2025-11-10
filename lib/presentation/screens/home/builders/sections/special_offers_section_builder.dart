import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/offers/cubit/offers_cubit.dart';
import '../../cubits/offers/cubit/offers_state.dart';
import '../../widgets/special_offer/special_offers_section.dart';

SliverToBoxAdapter buildSpecialOffersSection() {
  return SliverToBoxAdapter(
    child: BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        if (state is OffersLoading) {
          return const _LoadingWidget();
        }

        if (state is! OffersLoaded || state.offers.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: SpecialOffersSection(
            offers: state.offers,
            currentPage: state.currentPage,
            onPageChanged: (page) {
              context.read<OffersCubit>().setCurrentPage(page);
            },
            onOfferTap: (offerId) {
              // TODO: Navigate to offer details
            },
          ),
        );
      },
    ),
  );
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}