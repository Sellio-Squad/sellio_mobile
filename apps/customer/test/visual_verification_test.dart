// Visual verification test for the reviews feature (Issue #513).
//
// Renders the review UI components with mock data and saves PNG screenshots
// to the `screenshots/` directory at the app root for PR review.
//
// Run with:
//   flutter test test/visual_verification_test.dart

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show FontLoader;
import 'package:flutter_test/flutter_test.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/domain/entities/product_review.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/add_review_sheet.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/review_card.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/reviews_section.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating_input.dart';

const _outputDir = 'screenshots';

Future<void> _loadRealFonts() async {
  const fontFiles = {
    'Rubik': '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
  };

  for (final entry in fontFiles.entries) {
    final file = File(entry.value);
    if (!file.existsSync()) continue;

    final bytes = file.readAsBytesSync();
    final loader = FontLoader(entry.key)
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    // ignore: avoid_print
    print('Loaded font family ${entry.key} from ${entry.value}');
    await loader.load();
  }
}

Future<void> _capture(
  WidgetTester tester,
  String name, {
  double width = 390,
  double height = 844,
}) async {
  await tester.binding.setSurfaceSize(Size(width, height));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));

  await tester.runAsync(() async {
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(const Key('capture-root')),
    );

    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final file = File('$_outputDir/$name.png');
    file.createSync(recursive: true);
    file.writeAsBytesSync(byteData!.buffer.asUint8List());

    // ignore: avoid_print
    print('Saved screenshot -> ${file.path}');
  });
}

Widget _wrap(Widget child) {
  return SellioThemeProvider(
    brightness: Brightness.light,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: RepaintBoundary(
          key: const Key('capture-root'),
          child: child,
        ),
      ),
    ),
  );
}

List<ProductReview> _mockProductReviews() {
  final now = DateTime.now();

  return List.generate(
    5,
    (i) => ProductReview(
      id: 'review_$i',
      productId: 'product_1',
      userId: 'user_$i',
      userName: const [
        'Sarah Ahmed',
        'Mahmoud Hassan',
        'Layla Karim',
        'Omar Farouk',
        'Nour El-Din',
      ][i],
      userImage: '',
      rating: [5, 4, 5, 3, 5][i].toDouble(),
      comment: const [
        'Amazing quality and super fast delivery. Highly recommend this product!',
        'Good value for money. The material feels premium.',
        'Exactly as described. Very satisfied with my purchase.',
        'Decent product but shipping took a little longer than expected.',
        'Best purchase I have made this year. Will buy again.',
      ][i],
      createdAt: now.subtract(Duration(days: i * 3 + 1)),
    ),
  );
}

List<ReviewItemData> _mockReviewItems() {
  return _mockProductReviews()
      .map(
        (r) => ReviewItemData(
          userName: r.userName,
          userImage: r.userImage,
          rating: r.rating,
          comment: r.comment,
          createdAt: r.createdAt,
        ),
      )
      .toList();
}

void main() {
  testWidgets('Captures review components screenshots', (tester) async {
    await tester.runAsync(_loadRealFonts);

    addTearDown(
      () => tester.binding.setSurfaceSize(null),
    );

    // ---- 1. ReviewsSection (full list) ----
    await tester.pumpWidget(
      _wrap(
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ReviewsSection(
            title: 'Reviews',
            reviews: _mockReviewItems(),
            onAddReview: () async {},
          ),
        ),
      ),
    );
    await _capture(tester, 'reviews_section_list');

    // ---- 2. ReviewsSection empty state ----
    await tester.pumpWidget(
      _wrap(
        const Padding(
          padding: EdgeInsets.all(16),
          child: ReviewsSection(
            title: 'Reviews',
            reviews: [],
            onAddReview: null,
          ),
        ),
      ),
    );
    await _capture(tester, 'reviews_section_empty');

    // ---- 3. ReviewsSection loading state ----
    await tester.pumpWidget(
      _wrap(
        const Padding(
          padding: EdgeInsets.all(16),
          child: ReviewsSection(
            title: 'Reviews',
            isLoading: true,
            onAddReview: null,
          ),
        ),
      ),
    );
    await _capture(tester, 'reviews_section_loading');

    // ---- 4. ReviewCard variants ----
    await tester.pumpWidget(
      _wrap(
        const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ReviewCard(
                userName: 'Sarah Ahmed',
                userImage: '',
                rating: 5,
                comment: 'Amazing quality and super fast delivery!',
              ),
              SizedBox(height: 12),
              ReviewCard(
                userName: 'Mahmoud Hassan',
                rating: 3,
                comment: 'Decent product but shipping was a little slow.',
              ),
            ],
          ),
        ),
      ),
    );
    await _capture(tester, 'review_card');

    // ---- 5. ReviewRatingSummary ----
    await tester.pumpWidget(
      _wrap(
        const Padding(
          padding: EdgeInsets.all(16),
          child: ReviewRatingSummary(
            averageRating: 4.4,
            totalReviews: 127,
          ),
        ),
      ),
    );
    await _capture(tester, 'review_rating_summary');

    // ---- 6. Star rating widgets ----
    await tester.pumpWidget(
      _wrap(
        const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StarRating(rating: 4.5, size: 24),
              SizedBox(height: 24),
              StarRating(rating: 2.0, size: 24),
              SizedBox(height: 24),
              StarRatingInput(rating: 3, onChanged: _noop),
            ],
          ),
        ),
      ),
    );
    await _capture(tester, 'star_ratings');

    // ---- 7. AddReviewSheet ----
    await tester.pumpWidget(
      _wrap(
        Center(
          child: AddReviewSheet(
            title: 'Add Product Review',
            onSubmit: _fakeSubmit,
          ),
        ),
      ),
    );
    await _capture(tester, 'add_review_sheet', width: 390, height: 520);

    // ---- 8. Integrated product details style section ----
    await tester.pumpWidget(
      _wrap(
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wireless Headphones',
                  style: context.theme.typography.textTheme.titleMedium
                      .copyWith(color: context.theme.colors.title),
                ),
                const SizedBox(height: 16),
                ReviewsSection(
                  title: 'Reviews',
                  reviews: _mockReviewItems().take(3).toList(),
                  onAddReview: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await _capture(tester, 'product_details_reviews');

    // ---- 9. About Store ratings + reviews ----
    await tester.pumpWidget(
      _wrap(
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReviewRatingSummary(
                averageRating: 4.2,
                totalReviews: 89,
              ),
              const SizedBox(height: 16),
              ReviewsSection(
                title: 'Store Reviews',
                reviews: _mockReviewItems().take(3).toList(),
                onAddReview: () async {},
              ),
            ],
          ),
        ),
      ),
    );
    await _capture(tester, 'about_store_reviews');

    expect(true, isTrue);
  });
}

Future<bool> _fakeSubmit(int rating, String comment) async => true;

void _noop(int value) {}