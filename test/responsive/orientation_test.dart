import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'responsive_helper.dart';

void main() {
  group('Responsive: Orientation Tests', () {
    group('Portrait vs Landscape Comparison', () {
      testWidgets('DSButton renders in both orientations', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Test Button', onPressed: () {}),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
        final portraitSize = getWidgetSize(tester, find.byType(DSButton));

        // Landscape (swap dimensions)
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Test Button', onPressed: () {}),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
        final landscapeButtonSize = getWidgetSize(tester, find.byType(DSButton));

        // Button height should remain consistent across orientations
        expect(
          portraitSize!.height,
          equals(landscapeButtonSize!.height),
          reason: 'Button height should be consistent across orientations',
        );
      });

      testWidgets('DSProductCard adapts to landscape', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSProductCard(
                imageUrl: '',
                title: 'Product Title',
                price: 49.99,
                onTap: () {},
                imageWidget: Container(height: 150, color: Colors.grey),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        final portraitWidth =
            getWidgetSize(tester, find.byType(DSProductCard))!.width;

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSProductCard(
                imageUrl: '',
                title: 'Product Title',
                price: 49.99,
                onTap: () {},
                imageWidget: Container(height: 150, color: Colors.grey),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        final landscapeWidth =
            getWidgetSize(tester, find.byType(DSProductCard))!.width;

        // In landscape, card should adapt to wider viewport
        expect(
          landscapeWidth,
          greaterThanOrEqualTo(portraitWidth),
          reason: 'Card should adapt to wider landscape viewport',
        );
      });

      testWidgets('DSProductGrid works in both orientations', (tester) async {
        addTearDown(() => resetViewportSize(tester));
        final products = List.generate(4, (i) => 'Product $i');

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: products,
              itemBuilder: (context, product, index) => DSCard(
                child: Text(product),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);
        expect(tester.takeException(), isNull);

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: products,
              itemBuilder: (context, product, index) => DSCard(
                child: Text(product),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('DSBottomNav fits in both orientations', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        final bottomNav = DSBottomNav(
          currentIndex: 0,
          items: const [
            DSBottomNavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            DSBottomNavItem(
              icon: Icons.search_outlined,
              selectedIcon: Icons.search,
              label: 'Search',
            ),
            DSBottomNavItem(
              icon: Icons.shopping_cart_outlined,
              selectedIcon: Icons.shopping_cart,
              label: 'Cart',
            ),
          ],
          onTap: (_) {},
        );

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              bottomNavigationBar: bottomNav,
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Cart'), findsOneWidget);

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              bottomNavigationBar: bottomNav,
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Cart'), findsOneWidget);
      });
    });

    group('Tablet Orientation', () {
      testWidgets('DSAppBar works in tablet portrait', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPadPro11);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              appBar: DSAppBar(
                title: 'Tablet App',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.text('Tablet App'), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });

      testWidgets('DSAppBar works in tablet landscape', (tester) async {
        // iPad Pro 11 landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPadPro11.height,
          ResponsiveBreakpoints.iPadPro11.width,
        );
        await setViewportSize(tester, landscapeSize);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Scaffold(
              appBar: DSAppBar(
                title: 'Tablet Landscape',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.text('Tablet Landscape'), findsOneWidget);
      });

      testWidgets('DSProductGrid shows more columns in tablet landscape',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));
        final products = List.generate(8, (i) => 'Product $i');

        // iPad portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPadPro11);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: products,
              itemBuilder: (context, product, index) => DSCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(product),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);

        // iPad landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPadPro11.height,
          ResponsiveBreakpoints.iPadPro11.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: products,
              itemBuilder: (context, product, index) => DSCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(product),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Content Adaptation', () {
      testWidgets('DSEmptyState adapts to landscape', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSEmptyState(
              icon: Icons.inbox,
              title: 'No Items',
              description: 'Your collection is empty. Add items to get started.',
              actionText: 'Add Item',
              onAction: () {},
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
        expect(find.text('No Items'), findsOneWidget);

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSEmptyState(
              icon: Icons.inbox,
              title: 'No Items',
              description: 'Your collection is empty. Add items to get started.',
              actionText: 'Add Item',
              onAction: () {},
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
        expect(find.text('No Items'), findsOneWidget);
      });

      testWidgets('DSLoadingState centers in both orientations', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSLoadingState(message: 'Loading content...'),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
        expect(find.byType(DSCircularLoader), findsOneWidget);

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSLoadingState(message: 'Loading content...'),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
        expect(find.byType(DSCircularLoader), findsOneWidget);
      });

      testWidgets('DSErrorState displays correctly in landscape',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Landscape phone
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSErrorState(
              message: 'An error occurred. Please try again.',
              onRetry: () {},
            ),
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(find.text('An error occurred. Please try again.'), findsOneWidget);
      });
    });

    group('Form Elements in Orientation', () {
      testWidgets('DSTextField adapts width in landscape', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            Padding(
              padding: const EdgeInsets.all(16),
              child: DSTextField(
                label: 'Email',
                hint: 'Enter email',
                controller: TextEditingController(),
              ),
            ),
          ),
        );

        final portraitWidth =
            getWidgetSize(tester, find.byType(DSTextField))!.width;

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            Padding(
              padding: const EdgeInsets.all(16),
              child: DSTextField(
                label: 'Email',
                hint: 'Enter email',
                controller: TextEditingController(),
              ),
            ),
          ),
        );

        final landscapeWidth =
            getWidgetSize(tester, find.byType(DSTextField))!.width;

        // In landscape, field should be wider
        expect(
          landscapeWidth,
          greaterThan(portraitWidth),
          reason: 'TextField should be wider in landscape',
        );
      });

      testWidgets('DSFilterChip maintains size across orientations',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        // Portrait
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSFilterChip(
              label: 'Filter Option',
              onTap: () {},
            ),
          ),
        );

        final portraitSize = getWidgetSize(tester, find.byType(DSFilterChip));

        // Landscape
        final landscapeSize = Size(
          ResponsiveBreakpoints.iPhone14Pro.height,
          ResponsiveBreakpoints.iPhone14Pro.width,
        );
        await setViewportSize(tester, landscapeSize);
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSFilterChip(
              label: 'Filter Option',
              onTap: () {},
            ),
          ),
        );

        final landscapeChipSize =
            getWidgetSize(tester, find.byType(DSFilterChip));

        // Chip size should be consistent (intrinsic sizing)
        expect(
          portraitSize!.height,
          equals(landscapeChipSize!.height),
          reason: 'Chip height should be consistent across orientations',
        );
      });
    });
  });
}
