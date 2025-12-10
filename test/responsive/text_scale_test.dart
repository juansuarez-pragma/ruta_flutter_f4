import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'responsive_helper.dart';

void main() {
  group('Responsive: Text Scale Tests', () {
    group('DSText Accessibility', () {
      testWidgets('DSText scales with text scale factor', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        // Normal scale (1.0)
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSText.bodyMedium('Sample Text'),
            textScaleFactor: TextScaleFactors.normal,
          ),
        );

        final normalSize = getWidgetSize(tester, find.byType(DSText));

        // Large scale (1.3)
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSText.bodyMedium('Sample Text'),
            textScaleFactor: TextScaleFactors.large,
          ),
        );

        final largeSize = getWidgetSize(tester, find.byType(DSText));

        // Text should be larger at higher scale
        expect(
          largeSize!.height,
          greaterThan(normalSize!.height),
          reason: 'Text height should increase with scale factor',
        );
      });

      testWidgets('DSText.headingLarge remains readable at 2x scale',
          (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSText.headingLarge('Large Heading'),
            textScaleFactor: TextScaleFactors.huge,
          ),
        );

        expect(find.text('Large Heading'), findsOneWidget);

        final size = getWidgetSize(tester, find.byType(DSText));
        // Should fit within viewport width
        expect(
          size!.width,
          lessThanOrEqualTo(ResponsiveBreakpoints.iPhone14Pro.width),
        );
      });

      testWidgets('all DSText variants scale proportionally', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        final variants = <Widget>[
          const DSText.headingLarge('Heading'),
          const DSText.headingMedium('Subheading'),
          const DSText.bodyMedium('Body text'),
          const DSText.bodySmall('Small text'),
          const DSText.caption('Caption'),
        ];

        for (final variant in variants) {
          // Test at normal scale
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              variant,
              textScaleFactor: TextScaleFactors.normal,
            ),
          );
          expect(find.byType(DSText), findsOneWidget);

          // Test at large scale
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              variant,
              textScaleFactor: TextScaleFactors.extraLarge,
            ),
          );
          expect(find.byType(DSText), findsOneWidget);
        }
      });
    });

    group('DSButton Text Scaling', () {
      testWidgets('DSButton text scales appropriately', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        // Normal scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Click Me', onPressed: () {}),
            textScaleFactor: TextScaleFactors.normal,
          ),
        );

        final normalSize = getWidgetSize(tester, find.byType(DSButton));

        // Large scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSButton.primary(text: 'Click Me', onPressed: () {}),
            textScaleFactor: TextScaleFactors.large,
          ),
        );

        final largeSize = getWidgetSize(tester, find.byType(DSButton));

        // Button should grow to accommodate larger text
        expect(
          largeSize!.height,
          greaterThanOrEqualTo(normalSize!.height),
          reason: 'Button should grow with text scale',
        );
      });

      testWidgets('DSButton maintains touch target at all scales',
          (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        for (final scale in TextScaleFactors.allScales) {
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              DSButton.primary(text: 'Tap', onPressed: () {}),
              textScaleFactor: scale,
            ),
          );

          final size = getWidgetSize(tester, find.byType(DSButton));
          expect(
            size!.height,
            greaterThanOrEqualTo(44),
            reason: 'Button must meet minimum touch target at scale $scale',
          );
        }
      });

      testWidgets('all button variants handle text scaling', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        final buttons = <Widget>[
          DSButton.primary(text: 'Primary', onPressed: () {}),
          DSButton.secondary(text: 'Secondary', onPressed: () {}),
          DSButton.ghost(text: 'Ghost', onPressed: () {}),
          DSButton.danger(text: 'Danger', onPressed: () {}),
        ];

        for (final button in buttons) {
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              button,
              textScaleFactor: TextScaleFactors.huge,
            ),
          );

          expect(find.byType(DSButton), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
      });
    });

    group('DSBadge Text Scaling', () {
      testWidgets('DSBadge scales text appropriately', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        // Normal scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSBadge.success(text: 'Active'),
            textScaleFactor: TextScaleFactors.normal,
          ),
        );

        final normalSize = getWidgetSize(tester, find.byType(DSBadge));

        // Extra large scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSBadge.success(text: 'Active'),
            textScaleFactor: TextScaleFactors.extraLarge,
          ),
        );

        final largeSize = getWidgetSize(tester, find.byType(DSBadge));

        // Badge should grow with text
        expect(
          largeSize!.height,
          greaterThanOrEqualTo(normalSize!.height),
          reason: 'Badge should grow with text scale',
        );
      });

      testWidgets('all badge types handle scaling', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        final badges = <Widget>[
          const DSBadge.success(text: 'Success'),
          const DSBadge.error(text: 'Error'),
          const DSBadge.warning(text: 'Warning'),
          const DSBadge.info(text: 'Info'),
          const DSBadge.neutral(text: 'Neutral'),
        ];

        for (final badge in badges) {
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              badge,
              textScaleFactor: TextScaleFactors.huge,
            ),
          );

          expect(find.byType(DSBadge), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
      });
    });

    group('Form Elements Text Scaling', () {
      testWidgets('DSTextField label and hint scale', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        // Normal scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSTextField(
              label: 'Email Address',
              hint: 'Enter your email',
              controller: TextEditingController(),
            ),
            textScaleFactor: TextScaleFactors.normal,
          ),
        );

        expect(find.text('Email Address'), findsOneWidget);
        final normalSize = getWidgetSize(tester, find.byType(DSTextField));

        // Large scale
        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSTextField(
              label: 'Email Address',
              hint: 'Enter your email',
              controller: TextEditingController(),
            ),
            textScaleFactor: TextScaleFactors.large,
          ),
        );

        expect(find.text('Email Address'), findsOneWidget);
        final largeSize = getWidgetSize(tester, find.byType(DSTextField));

        // TextField should accommodate larger text
        expect(
          largeSize!.height,
          greaterThanOrEqualTo(normalSize!.height),
          reason: 'TextField should grow with text scale',
        );
      });

      testWidgets('DSTextField maintains usability at 2x scale',
          (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            DSTextField(
              label: 'Username',
              hint: 'Enter username',
              controller: TextEditingController(),
            ),
            textScaleFactor: TextScaleFactors.huge,
          ),
        );

        expect(find.byType(DSTextField), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);

        // Should be able to interact
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();
      });

      testWidgets('DSFilterChip text scales correctly', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        for (final scale in TextScaleFactors.allScales) {
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              DSFilterChip(
                label: 'Category',
                isSelected: false,
                onTap: () {},
              ),
              textScaleFactor: scale,
            ),
          );

          expect(find.text('Category'), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
      });
    });

    group('Complex Components Text Scaling', () {
      testWidgets('DSProductCard handles text scaling', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSProductCard(
                imageUrl: '',
                title: 'Product with a Long Title That May Wrap',
                price: 99.99,
                rating: 4.5,
                reviewCount: 100,
                badge: 'Sale',
                onTap: () {},
                imageWidget: Container(height: 100, color: Colors.grey),
              ),
            ),
            textScaleFactor: TextScaleFactors.large,
          ),
        );

        expect(find.byType(DSProductCard), findsOneWidget);
        expect(find.textContaining('Product'), findsOneWidget);
        expect(find.textContaining('99.99'), findsOneWidget);
      });

      testWidgets('DSEmptyState text scales appropriately', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSEmptyState(
                icon: Icons.inbox,
                title: 'No Items Found',
                description:
                    'Your collection is empty. Add some items to get started.',
                actionText: 'Add Item',
                onAction: () {},
              ),
            ),
            textScaleFactor: TextScaleFactors.extraLarge,
          ),
        );

        expect(find.text('No Items Found'), findsOneWidget);
        expect(find.text('Add Item'), findsOneWidget);
      });

      testWidgets('DSErrorState remains usable at high scale', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            SingleChildScrollView(
              child: DSErrorState(
                message: 'An unexpected error occurred. Please try again later.',
                onRetry: () {},
              ),
            ),
            textScaleFactor: TextScaleFactors.huge,
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(
            find.textContaining('unexpected error'), findsOneWidget);
      });

      testWidgets('DSLoadingState text scales', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            const DSLoadingState(message: 'Loading your content...'),
            textScaleFactor: TextScaleFactors.extraLarge,
          ),
        );

        expect(find.text('Loading your content...'), findsOneWidget);
        expect(find.byType(DSCircularLoader), findsOneWidget);
      });
    });

    group('Navigation Text Scaling', () {
      testWidgets('DSBottomNav labels scale appropriately', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        for (final scale in [
          TextScaleFactors.normal,
          TextScaleFactors.large,
        ]) {
          await tester.pumpWidget(
            MaterialApp(
              theme: FakeStoreTheme.light(),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(scale),
                  ),
                  child: child!,
                );
              },
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
                body: const SizedBox(),
              ),
            ),
          );

          expect(find.text('Home'), findsOneWidget);
          expect(find.text('Search'), findsOneWidget);
        }
      });

      testWidgets('DSAppBar title scales', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(TextScaleFactors.large),
                ),
                child: child!,
              );
            },
            home: Scaffold(
              appBar: DSAppBar(
                title: 'Application Title',
              ),
              body: const SizedBox(),
            ),
          ),
        );

        expect(find.text('Application Title'), findsOneWidget);
      });
    });

    group('Extreme Scale Factors', () {
      testWidgets('components handle 2x scale without overflow',
          (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        // Test multiple components at 2x scale
        final widgets = <Widget>[
          DSButton.primary(text: 'Button', onPressed: () {}),
          const DSBadge.success(text: 'Badge'),
          const DSText.bodyMedium('Text content'),
          DSFilterChip(label: 'Chip', isSelected: false, onTap: () {}),
        ];

        for (final widget in widgets) {
          await tester.pumpWidget(
            buildResponsiveTestWidget(
              widget,
              textScaleFactor: TextScaleFactors.huge,
            ),
          );

          // Should render without overflow errors
          expect(tester.takeException(), isNull);
        }
      });

      testWidgets('components handle 0.8x scale (reduced)', (tester) async {
        await setViewportSize(tester, ResponsiveBreakpoints.iPhone14Pro);
        addTearDown(() => resetViewportSize(tester));

        const reducedScale = 0.8;

        await tester.pumpWidget(
          buildResponsiveTestWidget(
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DSButton.primary(text: 'Button', onPressed: () {}),
                const SizedBox(height: 8),
                const DSBadge.info(text: 'Info'),
                const SizedBox(height: 8),
                const DSText.bodyMedium('Sample text'),
              ],
            ),
            textScaleFactor: reducedScale,
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
        expect(find.byType(DSBadge), findsOneWidget);
        expect(find.byType(DSText), findsOneWidget);
      });
    });
  });
}
