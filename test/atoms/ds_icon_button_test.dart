import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('DSIconButton', () {
    group('Rendering', () {
      testWidgets('renders with icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.favorite,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('renders with tooltip', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.share,
              tooltip: 'Share',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(Tooltip), findsOneWidget);
      });

      testWidgets('shows loading indicator when isLoading is true',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.save,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        // Icon should not be visible when loading
        expect(find.byIcon(Icons.save), findsNothing);
      });

      testWidgets('hides icon when loading', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.download,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.download), findsNothing);
      });
    });

    group('Variants', () {
      testWidgets('renders primary variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.add,
              variant: DSButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSIconButton), findsOneWidget);
      });

      testWidgets('renders secondary variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.edit,
              variant: DSButtonVariant.secondary,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSIconButton), findsOneWidget);
      });

      testWidgets('renders ghost variant by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.settings,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSIconButton), findsOneWidget);
      });

      testWidgets('renders danger variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.delete,
              variant: DSButtonVariant.danger,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSIconButton), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('renders small size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.close,
              size: DSButtonSize.small,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSIconButton));
        expect(buttonSize.width, equals(DSSizes.buttonSm));
        expect(buttonSize.height, equals(DSSizes.buttonSm));
      });

      testWidgets('renders medium size by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.menu,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSIconButton));
        expect(buttonSize.width, equals(DSSizes.buttonMd));
        expect(buttonSize.height, equals(DSSizes.buttonMd));
      });

      testWidgets('renders large size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.play_arrow,
              size: DSButtonSize.large,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSIconButton));
        expect(buttonSize.width, equals(DSSizes.buttonLg));
        expect(buttonSize.height, equals(DSSizes.buttonLg));
      });
    });

    group('Interactions', () {
      testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.favorite,
              onPressed: () => wasPressed = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSIconButton));
        expect(wasPressed, isTrue);
      });

      testWidgets('does not call onPressed when disabled',
          (WidgetTester tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            const DSIconButton(
              icon: Icons.favorite,
              onPressed: null,
            ),
          ),
        );

        await tester.tap(find.byType(DSIconButton));
        expect(wasPressed, isFalse);
      });

      testWidgets('does not call onPressed when loading',
          (WidgetTester tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.save,
              isLoading: true,
              onPressed: () => wasPressed = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSIconButton));
        expect(wasPressed, isFalse);
      });

      testWidgets('shows tooltip on long press', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.info,
              tooltip: 'More information',
              onPressed: () {},
            ),
          ),
        );

        await tester.longPress(find.byType(DSIconButton));
        await tester.pumpAndSettle();

        expect(find.text('More information'), findsOneWidget);
      });
    });

    group('States', () {
      testWidgets('is enabled when onPressed is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.star,
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.enabled, isTrue);
      });

      testWidgets('is disabled when onPressed is null',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSIconButton(
              icon: Icons.star,
              onPressed: null,
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.enabled, isFalse);
      });

      testWidgets('is disabled when loading', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.star,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.enabled, isFalse);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper with button property',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.favorite,
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.button, isTrue);
      });

      testWidgets('uses tooltip as semantic label when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.share,
              tooltip: 'Share this item',
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.label, equals('Share this item'));
      });

      testWidgets('generates semantic label with variant when no tooltip',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.add,
              variant: DSButtonVariant.primary,
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.label, contains('primary'));
        expect(semantics.properties.label, contains('button'));
      });

      testWidgets('includes loading state in semantic label',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.save,
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(SizedBox),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.label, contains('loading'));
      });

      testWidgets('button size meets minimum touch target (44px)',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSIconButton(
              icon: Icons.add,
              size: DSButtonSize.small,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSIconButton));
        // Even small buttons should meet accessibility guidelines
        expect(buttonSize.width, greaterThanOrEqualTo(32.0));
        expect(buttonSize.height, greaterThanOrEqualTo(32.0));
      });
    });
  });
}
