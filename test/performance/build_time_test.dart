import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'performance_helper.dart';

void main() {
  group('Performance: Build Time Tests', () {
    group('Atoms', () {
      testWidgets('DSButton builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSButton.primary(text: 'Test Button', onPressed: () {}),
          name: 'DSButton.primary',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildAcceptable),
          reason: 'DSButton average build: ${result.averageMs}ms '
              '(threshold: ${PerformanceThresholds.atomBuildAcceptable}ms)',
        );
      });

      testWidgets('DSButton rebuild is efficient', (tester) async {
        final initialResult = await measureBuildTime(
          tester,
          DSButton.primary(text: 'Initial', onPressed: () {}),
          name: 'DSButton initial',
          iterations: 5,
        );

        final rebuildTime = await measureRebuildTime(
          tester,
          (i) => DSButton.primary(text: 'Text $i', onPressed: () {}),
        );

        // Rebuild should not be more than rebuildEfficiencyFactor times slower
        final maxRebuildTime =
            (initialResult.averageMs * PerformanceThresholds.rebuildEfficiencyFactor).ceil();

        expect(
          rebuildTime,
          lessThanOrEqualTo(maxRebuildTime),
          reason: 'Rebuild ($rebuildTime ms) should be within '
              '${PerformanceThresholds.rebuildEfficiencyFactor}x of '
              'initial build (${initialResult.averageMs}ms)',
        );
      });

      testWidgets('DSIconButton builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSIconButton(
            icon: Icons.favorite,
            onPressed: () {},
          ),
          name: 'DSIconButton',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSBadge builds within excellent threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          const DSBadge.success(text: 'Success'),
          name: 'DSBadge',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildGood),
          reason: 'DSBadge is a simple component: ${result.averageMs}ms',
        );
      });

      testWidgets('DSText variants build within threshold', (tester) async {
        final variants = <Widget>[
          const DSText.headingLarge('Heading'),
          const DSText.bodyMedium('Body'),
          const DSText.caption('Caption'),
        ];

        for (final variant in variants) {
          final result = await measureBuildTime(
            tester,
            variant,
            name: 'DSText variant',
            iterations: 5,
          );

          expect(
            result.averageMs,
            lessThanOrEqualTo(PerformanceThresholds.atomBuildGood),
            reason: result.toString(),
          );
        }
      });

      testWidgets('DSTextField builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSTextField(
            label: 'Email',
            hint: 'Enter email',
            controller: TextEditingController(),
          ),
          name: 'DSTextField',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSCircularLoader builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          const DSCircularLoader(),
          name: 'DSCircularLoader',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildGood),
          reason: result.toString(),
        );
      });

      testWidgets('DSSkeleton builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          const DSSkeleton(width: 200, height: 20),
          name: 'DSSkeleton',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.atomBuildGood),
          reason: result.toString(),
        );
      });
    });

    group('Molecules', () {
      testWidgets('DSCard builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          const DSCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Card content'),
            ),
          ),
          name: 'DSCard',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSProductCard builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSProductCard(
            imageUrl: 'https://example.com/image.jpg',
            title: 'Product Title',
            price: 99.99,
            rating: 4.5,
            reviewCount: 100,
            badge: 'New',
            onTap: () {},
            onAddToCart: () {},
            imageWidget: Container(color: Colors.grey),
          ),
          name: 'DSProductCard',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSFilterChip builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSFilterChip(
            label: 'Filter',
            isSelected: false,
            onTap: () {},
          ),
          name: 'DSFilterChip',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildGood),
          reason: result.toString(),
        );
      });

      testWidgets('DSEmptyState builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSEmptyState(
            icon: Icons.inbox,
            title: 'No items',
            description: 'Try again later',
            actionText: 'Refresh',
            onAction: () {},
          ),
          name: 'DSEmptyState',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSErrorState builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSErrorState(
            message: 'An error occurred',
            onRetry: () {},
          ),
          name: 'DSErrorState',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSLoadingState builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          const DSLoadingState(message: 'Loading...'),
          name: 'DSLoadingState',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.moleculeBuildGood),
          reason: result.toString(),
        );
      });
    });

    group('Organisms', () {
      testWidgets('DSAppBar builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              appBar: DSAppBar(
                title: 'Title',
                actions: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                ],
              ),
            ),
          ),
          name: 'DSAppBar',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.organismBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSBottomNav builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              bottomNavigationBar: DSBottomNav(
                currentIndex: 0,
                items: const [
                  DSBottomNavItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Home',
                  ),
                  DSBottomNavItem(
                    icon: Icons.category_outlined,
                    selectedIcon: Icons.category,
                    label: 'Categories',
                  ),
                  DSBottomNavItem(
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Cart',
                    badgeCount: 3,
                  ),
                  DSBottomNavItem(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    label: 'Profile',
                  ),
                ],
                onTap: (_) {},
              ),
            ),
          ),
          name: 'DSBottomNav',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.organismBuildAcceptable),
          reason: result.toString(),
        );
      });

      testWidgets('DSProductGrid builds within threshold', (tester) async {
        final result = await measureBuildTime(
          tester,
          DSProductGrid<Map<String, dynamic>>(
            products: const [
              {'title': 'Product 1', 'price': 19.99},
              {'title': 'Product 2', 'price': 29.99},
              {'title': 'Product 3', 'price': 39.99},
              {'title': 'Product 4', 'price': 49.99},
            ],
            itemBuilder: (context, product, index) => DSCard(
              child: Text(product['title'] as String),
            ),
          ),
          name: 'DSProductGrid (4 items)',
        );

        expect(
          result.averageMs,
          lessThanOrEqualTo(PerformanceThresholds.organismBuildAcceptable),
          reason: result.toString(),
        );
      });
    });

    group('Comparative Benchmarks', () {
      testWidgets('atoms are faster than molecules', (tester) async {
        final atomResult = await measureBuildTime(
          tester,
          DSButton.primary(text: 'Button', onPressed: () {}),
          name: 'Atom (DSButton)',
          iterations: 5,
        );

        final moleculeResult = await measureBuildTime(
          tester,
          DSProductCard(
            imageUrl: '',
            title: 'Product',
            price: 99.99,
            onTap: () {},
            imageWidget: Container(color: Colors.grey),
          ),
          name: 'Molecule (DSProductCard)',
          iterations: 5,
        );

        // Atoms should generally be faster, but allow for measurement variance
        expect(
          atomResult.averageMs,
          lessThanOrEqualTo(moleculeResult.averageMs + 5),
          reason: 'Atom (${atomResult.averageMs}ms) should not be much '
              'slower than molecule (${moleculeResult.averageMs}ms)',
        );
      });

      testWidgets('const widgets have minimal rebuild cost', (tester) async {
        // First build - must use FakeStoreTheme for DS components
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSBadge.success(text: 'Const'),
            ),
          ),
        );

        final stopwatch = Stopwatch()..start();

        // Rebuild - const should be efficient
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: const Scaffold(
              body: DSBadge.success(text: 'Const'),
            ),
          ),
        );

        stopwatch.stop();

        expect(
          stopwatch.elapsedMilliseconds,
          lessThanOrEqualTo(PerformanceThresholds.constRebuildMax),
          reason: 'Const widgets should have efficient rebuild: '
              '${stopwatch.elapsedMilliseconds}ms',
        );
      });

      testWidgets('widget tree depth is reasonable', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              body: DSProductCard(
                imageUrl: '',
                title: 'Product',
                price: 99.99,
                badge: 'New',
                onTap: () {},
                onAddToCart: () {},
                imageWidget: Container(color: Colors.grey),
              ),
            ),
          ),
        );

        final element = tester.element(find.byType(DSProductCard));
        final depth = measureWidgetTreeDepth(element);

        // Flutter uses composition heavily - Material widgets add significant depth
        // A depth under widgetTreeDepthWarning is acceptable
        expect(
          depth,
          lessThan(PerformanceThresholds.widgetTreeDepthWarning),
          reason: 'Widget tree depth ($depth) should be under '
              '${PerformanceThresholds.widgetTreeDepthWarning}',
        );
      });
    });
  });
}
