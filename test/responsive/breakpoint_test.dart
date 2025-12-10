import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'responsive_helper.dart';

void main() {
  group('Responsive: Breakpoint Tests', () {
    group('DSButton Breakpoints', () {
      testWidgets('renders correctly on phone', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Test Button', onPressed: () {}),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
        expect(find.text('Test Button'), findsOneWidget);

        final buttonSize = getWidgetSize(tester, find.byType(DSButton));
        expect(buttonSize, isNotNull);
        expect(
            buttonSize!.width, lessThan(ResponsiveBreakpoints.iPhone14Pro.width));
      });

      testWidgets('renders correctly on tablet', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPadPro11);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Test Button', onPressed: () {}),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);

        final buttonSize = getWidgetSize(tester, find.byType(DSButton));
        expect(buttonSize, isNotNull);
        expect(
            buttonSize!.width, lessThan(ResponsiveBreakpoints.iPadPro11.width));
      });

      testWidgets('maintains minimum touch target on all devices',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await pumpResponsiveWidget(
            tester,
            DSButton.primary(text: 'Tap', onPressed: () {}),
            config: config,
          );

          final buttonSize = getWidgetSize(tester, find.byType(DSButton));
          expect(
            buttonSize!.height,
            greaterThanOrEqualTo(44),
            reason: 'Button height on ${config.name}',
          );
        }
      });
    });

    group('DSIconButton Breakpoints', () {
      testWidgets('meets touch target on all devices', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.phones) {
          await pumpResponsiveWidget(
            tester,
            DSIconButton(icon: Icons.favorite, onPressed: () {}),
            config: config,
          );

          final iconButtonSize =
              getWidgetSize(tester, find.byType(DSIconButton));
          expect(
            iconButtonSize!.width,
            greaterThanOrEqualTo(44),
            reason: 'IconButton width on ${config.name}',
          );
          expect(
            iconButtonSize.height,
            greaterThanOrEqualTo(44),
            reason: 'IconButton height on ${config.name}',
          );
        }
      });
    });

    group('DSCard Breakpoints', () {
      testWidgets('adapts width to container on different devices',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await pumpResponsiveWidget(
            tester,
            const SizedBox(
              width: double.infinity,
              child: DSCard(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Card content'),
                ),
              ),
            ),
            config: config,
          );

          final cardSize = getWidgetSize(tester, find.byType(DSCard));
          expect(cardSize, isNotNull);
          expect(
            cardSize!.width,
            lessThanOrEqualTo(config.effectiveSize.width),
            reason: 'Card width on ${config.name}',
          );
        }
      });
    });

    group('DSProductCard Breakpoints', () {
      testWidgets('displays correctly on phones', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSProductCard(
                imageUrl: '',
                title: 'Long Product Title That Might Need Wrapping',
                price: 99.99,
                rating: 4.5,
                reviewCount: 100,
                onTap: () {},
                imageWidget: Container(
                  height: 150,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(find.textContaining('Long Product'), findsOneWidget);
        expect(find.textContaining('99.99'), findsOneWidget);
      });

      testWidgets('fits within viewport on small phones', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhoneSE);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSProductCard(
                imageUrl: '',
                title: 'Product',
                price: 29.99,
                onTap: () {},
                imageWidget: Container(height: 100, color: Colors.grey),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);

        final cardSize = getWidgetSize(tester, find.byType(DSProductCard));
        expect(
          cardSize!.width,
          lessThanOrEqualTo(ResponsiveBreakpoints.iPhoneSE.width),
        );
      });
    });

    group('DSProductGrid Breakpoints', () {
      final testProducts = List.generate(6, (i) => 'Product $i');

      testWidgets('shows grid on phone', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: testProducts,
              itemBuilder: (context, product, index) => DSCard(
                child: Text(product),
              ),
            ),
          ),
        );

        expect(find.byType(DSProductGrid<String>), findsOneWidget);
        expect(find.byType(GridView), findsOneWidget);
      });

      testWidgets('renders on tablet without overflow', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPadPro11);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: testProducts,
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

      testWidgets('renders on desktop without overflow', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.largeDesktop);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSProductGrid<String>(
              products: testProducts,
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

    group('DSBottomNav Breakpoints', () {
      testWidgets('displays all items on phone', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
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
                    icon: Icons.search_outlined,
                    selectedIcon: Icons.search,
                    label: 'Search',
                  ),
                  DSBottomNavItem(
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Cart',
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
        );

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Cart'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('fits on small phone', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhoneSE);
        addTearDown(() => resetViewportSize(tester));

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
                  DSBottomNavItem(
                    icon: Icons.shopping_cart,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Cart',
                  ),
                ],
                onTap: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('DSAppBar Breakpoints', () {
      testWidgets('renders title on all devices', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await setViewportSize(tester, config.effectiveSize);

          await tester.pumpWidget(
            MaterialApp(
              theme: FakeStoreTheme.light(),
              home: Scaffold(
                appBar: DSAppBar(
                  title: 'App Title',
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: const SizedBox(),
              ),
            ),
          );

          expect(
            find.text('App Title'),
            findsOneWidget,
            reason: 'Title visible on ${config.name}',
          );
        }
      });
    });

    group('DSBadge Breakpoints', () {
      testWidgets('text is readable on all devices', (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await pumpResponsiveWidget(
            tester,
            const DSBadge.success(text: 'Active'),
            config: config,
          );

          expect(
            find.text('Active'),
            findsOneWidget,
            reason: 'Badge text visible on ${config.name}',
          );

          final badgeSize = getWidgetSize(tester, find.byType(DSBadge));
          expect(
            badgeSize!.height,
            greaterThanOrEqualTo(20),
            reason: 'Badge minimum height on ${config.name}',
          );
        }
      });
    });

    group('DSTextField Breakpoints', () {
      testWidgets('renders correctly on phone', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            Padding(
              padding: const EdgeInsets.all(16),
              child: DSTextField(
                label: 'Email',
                hint: 'Enter your email address',
                controller: TextEditingController(),
              ),
            ),
          ),
        );

        expect(find.byType(DSTextField), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);

        final fieldSize = getWidgetSize(tester, find.byType(DSTextField));
        expect(
          fieldSize!.width,
          lessThanOrEqualTo(ResponsiveBreakpoints.iPhone14Pro.width - 32),
        );
      });

      testWidgets('input area is touch-friendly', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSTextField(
              label: 'Input',
              controller: TextEditingController(),
            ),
          ),
        );

        final textFieldSize = getWidgetSize(tester, find.byType(TextField));
        expect(
          textFieldSize!.height,
          greaterThanOrEqualTo(44),
          reason: 'TextField should meet touch target size',
        );
      });
    });

    group('Empty States Breakpoints', () {
      testWidgets('DSEmptyState centers content on all devices',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await pumpResponsiveWidget(
            tester,
            DSEmptyState(
              icon: Icons.inbox,
              title: 'No Items',
              description: 'Your collection is empty',
              actionText: 'Add Item',
              onAction: () {},
            ),
            config: config,
          );

          expect(find.byType(DSEmptyState), findsOneWidget);
          expect(find.text('No Items'), findsOneWidget);
          expect(find.text('Your collection is empty'), findsOneWidget);
        }
      });

      testWidgets('DSErrorState displays retry button on all devices',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.phones) {
          await pumpResponsiveWidget(
            tester,
            DSErrorState(
              message: 'Something went wrong',
              onRetry: () {},
            ),
            config: config,
          );

          expect(find.byType(DSErrorState), findsOneWidget);
          expect(find.text('Something went wrong'), findsOneWidget);
        }
      });

      testWidgets('DSLoadingState centers loader on all devices',
          (tester) async {
        addTearDown(() => resetViewportSize(tester));

        for (final config in ResponsiveTestScenarios.allDevices) {
          await pumpResponsiveWidget(
            tester,
            const DSLoadingState(message: 'Loading...'),
            config: config,
          );

          expect(find.byType(DSLoadingState), findsOneWidget);
          expect(find.text('Loading...'), findsOneWidget);
        }
      });
    });

    group('Context Extension Breakpoints', () {
      testWidgets('isMobile returns true for phones', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        late bool isMobile;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isMobile = context.isMobile;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isMobile, isTrue);
      });

      testWidgets('isTablet returns true for tablets', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPadPro11);
        addTearDown(() => resetViewportSize(tester));

        late bool isTablet;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isTablet = context.isTablet;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isTablet, isTrue);
      });
    });
  });
}
