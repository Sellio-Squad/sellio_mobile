import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating_input.dart';

class AddReviewSheet extends StatefulWidget {
  final String title;
  final Future<bool> Function(int rating, String comment) onSubmit;

  const AddReviewSheet({
    super.key,
    required this.title,
    required this.onSubmit,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required Future<bool> Function(int rating, String comment) onSubmit,
  }) {
    return SellioBottomSheet.show<bool>(
      context: context,
      child: AddReviewSheet(title: title, onSubmit: onSubmit),
    );
  }

  @override
  State<AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<AddReviewSheet> {
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      setState(() {
        _errorMessage = _local.rate_before_submit;
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final success = await widget.onSubmit(_rating, _commentController.text);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        _isSubmitting = false;
        _errorMessage = _local.could_not_submit_review;
      });
    }
  }

  AppLocalizations get _local => context.local;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            widget.title,
            style: textTheme.titleMedium.copyWith(color: colors.title),
          ),
        ),
        const SizedBox(height: LayoutConstants.paddingLarge),
        Text(
          _local.your_rating,
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        const SizedBox(height: LayoutConstants.paddingSmall),
        StarRatingInput(
          rating: _rating,
          onChanged: (value) => setState(() {
            _rating = value;
            _errorMessage = null;
          }),
        ),
        const SizedBox(height: LayoutConstants.paddingLarge),
        Text(
          _local.your_review,
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        const SizedBox(height: LayoutConstants.paddingSmall),
        SellioTextField(
          isParagraph: true,
          maxLine: 4,
          controller: _commentController,
          hintText: _local.write_your_review_hint,
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: LayoutConstants.paddingSmall),
          Text(
            _errorMessage!,
            style: textTheme.labelSmall.copyWith(color: colors.semanticError),
          ),
        ],
        const SizedBox(height: LayoutConstants.paddingLarge),
        SellioButton(
          text: _local.submit_review,
          isLoading: _isSubmitting,
          onTap: _isSubmitting ? null : _submit,
        ),
      ],
    );
  }
}