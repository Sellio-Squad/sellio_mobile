import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'special_offers_shimmer.dart';
import 'cubit/home_special_offers_cubit.dart';
import 'cubit/home_special_offers_state.dart';
import 'widgets/special_offers_list.dart';

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocConsumer<HomeSpecialOffersCubit, HomeSpecialOffersState>(
        listener: (context, state) {
          // Handle side effects
          if (state is HomeSpecialOffersError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<HomeSpecialOffersCubit>().refreshOffers();
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeSpecialOffersLoading) {
            return const _LoadingWidget();
          }

          if (state is! HomeSpecialOffersLoaded || state.offers.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: SpecialOffersList(
              offers: state.offers,
              currentPage: state.currentPage,
              onPageChanged: (page) {
                context.read<HomeSpecialOffersCubit>().setCurrentPage(page);
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
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: SpecialOffersShimmer(),
      ),
    );
  }
}
