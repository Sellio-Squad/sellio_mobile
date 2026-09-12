import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seller/presentation/utils/date_format.dart';

void main() {
  testWidgets('Seller app widget tree renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Text('Sellio Seller')),
      ),
    );

    expect(find.text('Sellio Seller'), findsOneWidget);
  });

  test('formatDateToReadable formats date', () {
    final result = formatDateToReadable(DateTime(2026, 9, 12));
    expect(result, '12 Sep 2026');
  });
}
