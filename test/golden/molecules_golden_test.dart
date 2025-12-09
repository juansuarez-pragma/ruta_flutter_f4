import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'golden_test_helper.dart';

void main() {
  group('Molecules Golden Tests', () {
    group('DSCard', () {
      testWidgets('elevations match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                DSCard(
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Elev 0'),
                  ),
                ),
                DSCard(
                  elevation: 1,
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
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_card_elevations.png'),
        );
      });
    });

    group('DSFilterChip', () {
      testWidgets('states match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                DSFilterChip(
                  label: 'Unselected',
                  isSelected: false,
                  onTap: () {},
                ),
                DSFilterChip(
                  label: 'Selected',
                  isSelected: true,
                  onTap: () {},
                ),
                const DSFilterChip(
                  label: 'Disabled',
                  isSelected: false,
                ),
              ],
            ),
            size: const Size(400, 120),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_filter_chip_states.png'),
        );
      });
    });

    group('DSEmptyState', () {
      testWidgets('complete match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            DSEmptyState(
              icon: Icons.inbox_outlined,
              title: 'No items found',
              description: 'Try adjusting search',
              actionText: 'Refresh',
              onAction: () {},
            ),
            size: const Size(400, 350),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_empty_state.png'),
        );
      });
    });

    group('DSErrorState', () {
      testWidgets('complete match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            DSErrorState(
              message: 'Something went wrong',
              onRetry: () {},
            ),
            size: const Size(400, 320),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_error_state.png'),
        );
      });
    });

    group('DSLoadingState', () {
      testWidgets('complete match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            const DSLoadingState(
              message: 'Loading data...',
            ),
            size: const Size(300, 200),
          ),
        );

        // Pump to show animation frame
        await tester.pump();

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_loading_state.png'),
        );
      });
    });

    group('DSProductCard', () {
      testWidgets('complete match golden', (tester) async {
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
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 80),
              ),
            ),
            size: const Size(220, 350),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_product_card.png'),
        );
      });
    });
  });
}
