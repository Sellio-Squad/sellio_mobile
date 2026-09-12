import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/review_card.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating.dart';

class ReviewItemData {
  final String userName;
  final String? userImage;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  const ReviewItemData({
    required this.userName,
    this.userImage,
    required this.rating,
    this.comment,
    required this.createdAt,
  });
}

class ReviewsSection extends StatelessWidget {
  final String title;
  final List<ReviewItemData> reviews;
  final bool isLoading;
  final String? errorMessage;
  final bool showAddButton;
  final Future<void> Function()? onAddReview;
  final VoidCallback? onRetry;

  const ReviewsSection({
    super.key,
    required this.title,
    this.reviews = const [],
    this.isLoading = false,
    this.errorMessage,
    this.showAddButton = true,
    this.onAddReview,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
            ),
            if (showAddButton && onAddReview != null)
              _buildAddButton(context),
          ],
        ),
        const SizedBox(height: LayoutConstants.paddingMedium),
        _buildContent(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return TextButton.icon(
      onPressed: onAddReview,
      icon: Icon(
        Icons.add,
        size: 18,
        color: context.theme.colors.primary,
      ),
      label: Text(
        context.local.add_review,
        style: context.theme.typography.textTheme.labelMedium.copyWith(
          color: context.theme.colors.primary,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(0, 32),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState(context);
    }

    if (errorMessage != null) {
      return _buildErrorState(context);
    }

    if (reviews.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      children: [
        for (var i = 0; i < reviews.length; i++) ...[
          ReviewCard(
            userName: reviews[i].userName,
            userImage: reviews[i].userImage,
            rating: reviews[i].rating,
            comment: reviews[i].comment,
            createdAt: reviews[i].createdAt,
          ),
          if (i < reviews.length - 1)
            const SizedBox(height: LayoutConstants.itemSpacing),
        ],
      ],
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: LayoutConstants.itemSpacing),
          child: Container(
            height: 88,
            decoration: BoxDecoration(
              color: context.theme.colors.surface,
              borderRadius:
                  BorderRadius.circular(LayoutConstants.borderRadiusLarge),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadiusLarge),
      ),
      child: Column(
        children: [
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: context.theme.typography.textTheme.bodySmall.copyWith(
              color: context.theme.colors.body,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: LayoutConstants.paddingMedium),
            SellioButton(
              text: context.local.try_again,
              fullWidth: false,
              verticalPadding: 8,
              horizontalPadding: 24,
              onTap: onRetry,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.theme.colors.surface,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadiusLarge),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 40,
            color: context.theme.colors.hint,
          ),
          const SizedBox(height: LayoutConstants.paddingSmall),
          Text(
            context.local.no_reviews_yet,
            textAlign: TextAlign.center,
            style: context.theme.typography.textTheme.bodyMedium.copyWith(
              color: context.theme.colors.hint,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewRatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const ReviewRatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(LayoutConstants.paddingLarge),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadiusLarge),
        border: Border.all(color: colors.stroke, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            averageRating.toStringAsFixed(1),
            style: textTheme.headlineSmall.copyWith(color: colors.title),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StarRating(rating: averageRating, size: 16),
              const SizedBox(height: 4),
              Text(
                context.local.total_reviews(totalReviews),
                style: textTheme.labelXSmall.copyWith(color: colors.hint),
              ),
            ],
          ),
        ],
      ),
    );
  }
}