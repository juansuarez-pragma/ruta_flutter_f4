import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'golden_test_helper.dart';

void main() {
  group('Dark Theme Golden Tests', () {
    group('DSButton', () {
      testWidgets('dark theme variants match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DSButton.primary(text: 'Primary', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.secondary(text: 'Secondary', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.ghost(text: 'Ghost', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.danger(text: 'Danger', onPressed: () {}),
              ],
            ),
            size: const Size(300, 250),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_button_variants_dark.png'),
        );
      });
    });

    group('DSBadge', () {
      testWidgets('dark theme types match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                DSBadge.success(text: 'Success'),
                DSBadge.error(text: 'Error'),
                DSBadge.warning(text: 'Warning'),
                DSBadge.info(text: 'Info'),
                DSBadge.neutral(text: 'Neutral'),
              ],
            ),
            size: const Size(350, 100),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_badge_types_dark.png'),
        );
      });
    });

    group('DSCard', () {
      testWidgets('dark theme elevations match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                DSCard(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Elev 0'),
                  ),
                ),
                DSCard(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Elev 1'),
                  ),
                ),
                DSCard(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Elev 2'),
                  ),
                ),
              ],
            ),
            size: const Size(350, 150),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_card_elevations_dark.png'),
        );
      });
    });

    group('DSText', () {
      testWidgets('dark theme variants match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DSText.headingMedium('Heading Medium'),
                SizedBox(height: 4),
                DSText.bodyLarge('Body Large'),
                SizedBox(height: 4),
                DSText.bodyMedium('Body Medium'),
                SizedBox(height: 4),
                DSText.caption('Caption text'),
              ],
            ),
            size: const Size(300, 180),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_text_variants_dark.png'),
        );
      });
    });

    group('DSProductCard', () {
      testWidgets('dark theme match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            DSProductCard(
              imageUrl: 'https://fakestoreapi.com/img/1.jpg',
              title: 'Sample Product',
              price: 29.99,
              rating: 4.5,
              reviewCount: 120,
              badge: 'New',
              badgeType: DSBadgeType.success,
              onTap: () {},
              onAddToCart: () {},
              imageWidget: Container(
                color: Colors.grey[700],
                child: const Icon(Icons.image, size: 80, color: Colors.white),
              ),
            ),
            size: const Size(220, 350),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_product_card_dark.png'),
        );
      });
    });

    group('Theme Consistency', () {
      testWidgets('complete theme comparison', (tester) async {
        // This test captures a comprehensive view for theme comparison
        await tester.pumpWidget(
          buildGoldenTestWidget(
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DSButton.primary(text: 'Primary', onPressed: () {}),
                      const SizedBox(width: 8),
                      DSButton.secondary(text: 'Secondary', onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Badges row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DSBadge.success(text: 'Success'),
                      SizedBox(width: 8),
                      DSBadge.error(text: 'Error'),
                      SizedBox(width: 8),
                      DSBadge.info(text: 'Info'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Text samples
                  const DSText.headingMedium('Dark Theme Sample'),
                  const DSText.bodyMedium('Body text in dark mode'),
                ],
              ),
            ),
            size: const Size(400, 200),
            brightness: Brightness.dark,
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/theme_consistency_dark.png'),
        );
      });
    });
  });
}
