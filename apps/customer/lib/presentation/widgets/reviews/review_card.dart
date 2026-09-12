import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/presentation/utils/date_format.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String? userImage;
  final double rating;
  final String? comment;
  final DateTime? createdAt;

  const ReviewCard({
    super.key,
    required this.userName,
    this.userImage,
    required this.rating,
    this.comment,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;
    final hasComment = comment != null && comment!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(LayoutConstants.borderRadiusLarge),
        border: Border.all(color: colors.stroke, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(context),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelMedium.copyWith(
                          color: colors.title,
                        ),
                      ),
                    ),
                    if (createdAt != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        formatDateToReadable(createdAt!),
                        style: textTheme.labelXSmall.copyWith(
                          color: colors.hint,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: StarRating(rating: rating, size: 13),
                ),
                if (hasComment) ...[
                  const SizedBox(height: 8),
                  Text(
                    comment!,
                    style: textTheme.bodySmall.copyWith(color: colors.body),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    if (userImage != null && userImage!.isNotEmpty) {
      return ClipOval(
        child: SellioRemoteImage.circle(
          imageUrl: userImage!,
          size: 40,
          errorWidget: _buildPlaceholderAvatar(context),
        ),
      );
    }

    return _buildPlaceholderAvatar(context);
  }

  Widget _buildPlaceholderAvatar(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.primaryVariant,
        shape: BoxShape.circle,
      ),
      child: Text(
        userName.isNotEmpty
            ? userName
                .split(' ')
                .where((word) => word.isNotEmpty)
                .take(2)
                .map((word) => word.characters.first.toUpperCase())
                .join()
            : '?',
        style: textTheme.labelMedium.copyWith(color: colors.primary),
      ),
    );
  }
}