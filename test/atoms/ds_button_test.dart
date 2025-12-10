import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSButton', () {
    group('Rendering', () {
      testWidgets('renders with text', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Click Me',
              onPressed: () {},
            ),
          ),
        );

        expect(find.text('Click Me'), findsOneWidget);
      });

      testWidgets('renders with icon at start', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'With Icon',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('renders with icon at end', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'With Icon',
              icon: Icons.arrow_forward,
              iconPosition: DSButtonIconPosition.end,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      });

      testWidgets('shows loading indicator when isLoading is true',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Variants', () {
      testWidgets('renders primary variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton.primary(
              text: 'Primary',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
      });

      testWidgets('renders secondary variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton.secondary(
              text: 'Secondary',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
      });

      testWidgets('renders ghost variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton.ghost(
              text: 'Ghost',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
      });

      testWidgets('renders danger variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton.danger(
              text: 'Danger',
              onPressed: () {},
            ),
          ),
        );

        expect(find.byType(DSButton), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('renders small size', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Small',
              size: DSButtonSize.small,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSButton));
        expect(buttonSize.height, equals(DSSizes.buttonSm));
      });

      testWidgets('renders medium size', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Medium',
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSButton));
        expect(buttonSize.height, equals(DSSizes.buttonMd));
      });

      testWidgets('renders large size', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Large',
              size: DSButtonSize.large,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSButton));
        expect(buttonSize.height, equals(DSSizes.buttonLg));
      });
    });

    group('Interactions', () {
      testWidgets('calls onPressed when tapped', (tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Tap Me',
              onPressed: () => wasPressed = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSButton));
        expect(wasPressed, isTrue);
      });

      testWidgets('does not call onPressed when disabled',
          (tester) async {
        const bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            const DSButton(
              text: 'Disabled',
            ),
          ),
        );

        await tester.tap(find.byType(DSButton));
        expect(wasPressed, isFalse);
      });

      testWidgets('does not call onPressed when loading',
          (tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Loading',
              isLoading: true,
              onPressed: () => wasPressed = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSButton));
        expect(wasPressed, isFalse);
      });
    });

    group('Full width', () {
      testWidgets('expands to full width when isFullWidth is true',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSButton(
              text: 'Full Width',
              isFullWidth: true,
              onPressed: () {},
            ),
          ),
        );

        final buttonSize = tester.getSize(find.byType(DSButton));
        // Button should be close to screen width minus padding
        expect(buttonSize.width, greaterThan(300));
      });
    });
  });
}
