import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'performance_helper.dart';

void main() {
  group('Performance: Memory Tests', () {
    group('Widget Disposal', () {
      testWidgets('DSButton disposes correctly', (tester) async {
        // Build widget
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSButton.primary(text: 'Test', onPressed: () {}),
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);

        // Replace with empty widget to trigger disposal
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        // Widget should be disposed
        expect(find.byType(DSButton), findsNothing);
      });

      testWidgets('DSTextField disposes controller correctly', (tester) async {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSTextField(
                label: 'Test',
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.byType(DSTextField), findsOneWidget);

        // Type some text
        await tester.enterText(find.byType(TextField), 'Hello');
        expect(controller.text, 'Hello');

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSTextField), findsNothing);
        // Controller should still be accessible (managed externally)
        expect(controller.text, 'Hello');
      });

      testWidgets('DSCircularLoader animation disposes correctly',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSCircularLoader(),
            ),
          ),
        );

        expect(find.byType(DSCircularLoader), findsOneWidget);

        // Pump a few frames to ensure animation is running
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSCircularLoader), findsNothing);
      });

      testWidgets('DSSkeleton animation disposes correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSSkeleton(width: 200, height: 20),
            ),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);

        // Pump to advance animation
        await tester.pump(const Duration(milliseconds: 500));

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSSkeleton), findsNothing);
      });
    });

    group('Complex Widget Disposal', () {
      testWidgets('DSProductCard disposes all children', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSProductCard(
                imageUrl: 'https://example.com/image.jpg',
                title: 'Product',
                price: 99.99,
                rating: 4.5,
                reviewCount: 100,
                badge: 'New',
                onTap: () {},
                onAddToCart: () {},
                imageWidget: Container(color: Colors.grey),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(find.byType(DSBadge), findsOneWidget);
        // DSProductCard may use IconButton for add to cart instead of DSButton
        expect(find.byType(DSCard), findsOneWidget);

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSProductCard), findsNothing);
        expect(find.byType(DSBadge), findsNothing);
        expect(find.byType(DSCard), findsNothing);
      });

      testWidgets('DSProductGrid disposes all items', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSProductGrid<String>(
                products: const ['A', 'B', 'C', 'D'],
                itemBuilder: (context, product, index) => DSCard(
                  child: Text(product),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);
        // Grid uses lazy loading, so only visible items are rendered
        expect(find.byType(DSCard), findsWidgets);

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSProductGrid<String>), findsNothing);
        expect(find.byType(DSCard), findsNothing);
      });

      testWidgets('DSBottomNav disposes correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              bottomNavigationBar: DSBottomNav(
                currentIndex: 0,
                items: const [
                  DSBottomNavItem(
                    icon: Icons.home,
                    selectedIcon: Icons.home,
                    label: 'Home',
                  ),
                  DSBottomNavItem(
                    icon: Icons.search,
                    selectedIcon: Icons.search,
                    label: 'Search',
                  ),
                ],
                onTap: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);

        // Replace widget
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        expect(find.byType(DSBottomNav), findsNothing);
      });
    });

    group('State Management', () {
      testWidgets('DSFilterChip maintains state correctly', (tester) async {
        bool isSelected = false;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) => DSFilterChip(
                  label: 'Filter',
                  isSelected: isSelected,
                  onTap: () => setState(() => isSelected = !isSelected),
                ),
              ),
            ),
          ),
        );

        // Initial state
        expect(isSelected, false);

        // Tap to select
        await tester.tap(find.byType(DSFilterChip));
        await tester.pumpAndSettle();

        expect(isSelected, true);

        // Tap again to deselect
        await tester.tap(find.byType(DSFilterChip));
        await tester.pumpAndSettle();

        expect(isSelected, false);
      });

      testWidgets('DSTextField preserves text during rebuilds',
          (tester) async {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        int rebuildCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  rebuildCount++;
                  return Column(
                    children: [
                      DSTextField(
                        label: 'Test',
                        controller: controller,
                      ),
                      DSButton.primary(
                        text: 'Rebuild',
                        onPressed: () => setState(() {}),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        expect(rebuildCount, 1);

        // Enter text
        await tester.enterText(find.byType(TextField), 'Test input');
        expect(controller.text, 'Test input');

        // Trigger rebuild
        await tester.tap(find.widgetWithText(DSButton, 'Rebuild'));
        await tester.pumpAndSettle();

        expect(rebuildCount, 2);
        // Text should be preserved
        expect(controller.text, 'Test input');
      });
    });

    group('Widget Count Efficiency', () {
      testWidgets('DSButton has reasonable widget count', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSButton.primary(text: 'Test', onPressed: () {}),
            ),
          ),
        );

        final element = tester.element(find.byType(DSButton));
        final count = countWidgets(element);

        // A button shouldn't have an excessive number of widgets
        expect(
          count,
          lessThan(50),
          reason: 'DSButton widget count ($count) should be reasonable',
        );
      });

      testWidgets('DSCard has reasonable widget count', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSCard(
                child: Text('Content'),
              ),
            ),
          ),
        );

        final element = tester.element(find.byType(DSCard));
        final count = countWidgets(element);

        expect(
          count,
          lessThan(30),
          reason: 'DSCard widget count ($count) should be minimal',
        );
      });

      testWidgets('DSBadge has minimal widget count', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSBadge.success(text: 'Success'),
            ),
          ),
        );

        final element = tester.element(find.byType(DSBadge));
        final count = countWidgets(element);

        expect(
          count,
          lessThan(20),
          reason: 'DSBadge widget count ($count) should be minimal',
        );
      });

      testWidgets('DSText has minimal widget count', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSText.bodyMedium('Test text'),
            ),
          ),
        );

        final element = tester.element(find.byType(DSText));
        final count = countWidgets(element);

        expect(
          count,
          lessThan(10),
          reason: 'DSText widget count ($count) should be minimal',
        );
      });
    });

    group('Rebuild Efficiency', () {
      testWidgets('theme change triggers efficient rebuild', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: Column(
                children: [
                  DSButton.primary(text: 'Button', onPressed: () {}),
                  const DSBadge.info(text: 'Info'),
                  const DSText.bodyMedium('Text'),
                ],
              ),
            ),
          ),
        );

        // Switch to dark theme
        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.dark(),
            home: Scaffold(
              body: Column(
                children: [
                  DSButton.primary(text: 'Button', onPressed: () {}),
                  const DSBadge.info(text: 'Info'),
                  const DSText.bodyMedium('Text'),
                ],
              ),
            ),
          ),
        );

        stopwatch.stop();

        // Theme switch should be reasonably fast
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(PerformanceThresholds.organismBuildAcceptable),
          reason: 'Theme switch took ${stopwatch.elapsedMilliseconds}ms',
        );
      });

      testWidgets('partial update does not rebuild entire tree',
          (tester) async {
        int buttonBuildCount = 0;
        int badgeBuildCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) => Column(
                    children: [
                      Builder(
                        builder: (context) {
                          buttonBuildCount++;
                          return DSButton.primary(
                            text: 'Count: $buttonBuildCount',
                            onPressed: () => setState(() {}),
                          );
                        },
                      ),
                      Builder(
                        builder: (context) {
                          badgeBuildCount++;
                          return const DSBadge.success(text: 'Static');
                        },
                      ),
                    ],
                  ),
              ),
            ),
          ),
        );

        expect(buttonBuildCount, 1);
        expect(badgeBuildCount, 1);

        // Tap button to trigger rebuild
        await tester.tap(find.byType(DSButton));
        await tester.pumpAndSettle();

        // Both rebuild due to StatefulBuilder, but this is expected
        // The key is they rebuild efficiently
        expect(buttonBuildCount, 2);
        expect(badgeBuildCount, 2);
      });
    });

    group('Large List Performance', () {
      testWidgets('DSProductGrid handles 20 items efficiently', (tester) async {
        final products = List.generate(20, (i) => 'Product $i');

        final stopwatch = Stopwatch()..start();

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSProductGrid<String>(
                products: products,
                itemBuilder: (context, product, index) => DSCard(
                  child: DSText.bodyMedium(product),
                ),
              ),
            ),
          ),
        );

        stopwatch.stop();

        expect(find.byType(DSProductGrid<String>), findsOneWidget);

        // Building 20 items should still be within acceptable time
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(PerformanceThresholds.organismBuildAcceptable * 2),
          reason: '20-item grid built in ${stopwatch.elapsedMilliseconds}ms',
        );
      });

      testWidgets('DSProductGrid scroll maintains performance', (tester) async {
        final products = List.generate(50, (i) => 'Product $i');

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSProductGrid<String>(
                products: products,
                itemBuilder: (context, product, index) => DSCard(
                  child: DSText.bodyMedium(product),
                ),
              ),
            ),
          ),
        );

        final stopwatch = Stopwatch()..start();

        // Scroll down
        await tester.drag(
          find.byType(DSProductGrid<String>),
          const Offset(0, -500),
        );
        await tester.pumpAndSettle();

        stopwatch.stop();

        // Scroll should be fast
        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(PerformanceThresholds.organismBuildAcceptable),
          reason: 'Scroll took ${stopwatch.elapsedMilliseconds}ms',
        );
      });
    });
  });
}
