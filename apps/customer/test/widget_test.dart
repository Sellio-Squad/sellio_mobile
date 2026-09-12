// Basic widget test to keep the app test suite green.

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sellio_mobile/presentation/widgets/reviews/star_rating.dart';

void main() {
  testWidgets('StarRating renders five stars', (tester) async {
    await tester.pumpWidget(
      SellioThemeProvider(
        brightness: Brightness.light,
        child: const MaterialApp(
          home: Scaffold(
            body: StarRating(rating: 4.0),
          ),
        ),
      ),
    );

    expect(find.byType(StarRating), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });
}