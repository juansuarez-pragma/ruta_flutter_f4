import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );
}

void main() {
  group('Content Resilience Tests', () {
    group('DSText Edge Cases', () {
      testWidgets('handles empty string', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(const DSText.bodyMedium('')),
        );

        expect(find.byType(DSText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles very long text without overflow', (tester) async {
        final longText = 'A' * 500;

        await tester.pumpWidget(
          buildTestableWidget(
            SizedBox(
              width: 200,
              child: DSText.bodyMedium(longText, maxLines: 2),
            ),
          ),
        );

        expect(find.byType(DSText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles special characters', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyMedium('Special: @#\$%^&*()_+{}|:<>?'),
          ),
        );

        expect(find.byType(DSText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles unicode and emojis', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyMedium('Unicode: 你好 🎉 مرحبا'),
          ),
        );

        expect(find.byType(DSText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSButton Edge Cases', () {
      testWidgets('handles very long button text', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            SizedBox(
              width: 150,
              child: DSButton.primary(
                text: 'This is a very long button text that should truncate',
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles rapid repeated taps', (tester) async {
        int tapCount = 0;

        await tester.pumpWidget(
          buildTestableWidget(
            DSButton.primary(
              text: 'Tap Me',
              onPressed: () => tapCount++,
            ),
          ),
        );

        // Rapid tapping
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(DSButton));
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(tapCount, greaterThanOrEqualTo(10));
        expect(tester.takeException(), isNull);
      });
    });

    group('DSBadge Edge Cases', () {
      testWidgets('handles empty badge text', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(const DSBadge.info(text: '')),
        );

        expect(find.byType(DSBadge), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles single character', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(const DSBadge.success(text: 'X')),
        );

        expect(find.byType(DSBadge), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSTextField Edge Cases', () {
      testWidgets('handles paste of very long text', (tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              controller: controller,
              maxLength: 50,
            ),
          ),
        );

        // Simulate entering long text
        await tester.enterText(find.byType(TextField), 'A' * 100);
        await tester.pump();

        // Should be truncated to maxLength
        expect(controller.text.length, lessThanOrEqualTo(50));
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles special characters in input', (tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(controller: controller),
          ),
        );

        await tester.enterText(
            find.byType(TextField), '<script>alert("xss")</script>');
        await tester.pump();

        expect(find.byType(DSTextField), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSProductCard Edge Cases', () {
      testWidgets('handles zero price', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: '',
              title: 'Free Product',
              price: 0.0,
              onTap: () {},
              imageWidget: Container(color: Colors.grey),
            ),
          ),
        );

        expect(find.text('\$0.00'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles very high price', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: '',
              title: 'Expensive',
              price: 999999.99,
              onTap: () {},
              imageWidget: Container(color: Colors.grey),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles zero rating', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: '',
              title: 'New Product',
              price: 19.99,
              rating: 0.0,
              reviewCount: 0,
              onTap: () {},
              imageWidget: Container(color: Colors.grey),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles very long title', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            SizedBox(
              width: 200,
              child: DSProductCard(
                imageUrl: '',
                title:
                    'This is an extremely long product title that should be truncated properly without causing any layout issues or overflow errors in the UI',
                price: 29.99,
                onTap: () {},
                imageWidget: Container(color: Colors.grey),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSCard Edge Cases', () {
      testWidgets('handles empty child', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(child: SizedBox.shrink()),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles elevation boundary values', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const Column(
              children: [
                DSCard(elevation: 0, child: Text('Zero')),
                DSCard(elevation: 3, child: Text('Three')),
              ],
            ),
          ),
        );

        expect(find.byType(DSCard), findsNWidgets(2));
        expect(tester.takeException(), isNull);
      });
    });

    group('DSFilterChip Edge Cases', () {
      testWidgets('handles empty label', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: '',
              isSelected: false,
              onTap: () {},
            ),
          ),
        );

        expect(find.byType(DSFilterChip), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles rapid selection toggle', (tester) async {
        bool isSelected = false;

        await tester.pumpWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return buildTestableWidget(
                DSFilterChip(
                  label: 'Toggle',
                  isSelected: isSelected,
                  onTap: () => setState(() => isSelected = !isSelected),
                ),
              );
            },
          ),
        );

        // Rapid toggling
        for (int i = 0; i < 10; i++) {
          await tester.tap(find.byType(DSFilterChip));
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(tester.takeException(), isNull);
      });
    });

    group('DSEmptyState Edge Cases', () {
      testWidgets('renders with minimal content', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSEmptyState(
              icon: Icons.inbox,
              title: '',
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSProductGrid Edge Cases', () {
      testWidgets('handles empty product list', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<Map<String, dynamic>>(
              products: const [],
              itemBuilder: (context, product, index) => const SizedBox(),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<Map<String, dynamic>>), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });
}
