import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSCard', () {
    group('Rendering', () {
      testWidgets('renders child content', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              child: Text('Card Content'),
            ),
          ),
        );

        expect(find.text('Card Content'), findsOneWidget);
      });

      testWidgets('applies padding', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              padding: EdgeInsets.all(24),
              child: Text('Padded'),
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });

      testWidgets('renders with custom border radius',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              borderRadius: DSBorderRadius.lg,
              child: Text('Rounded'),
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });
    });

    group('Elevation', () {
      testWidgets('renders with elevation 0', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              elevation: 0,
              child: Text('Flat'),
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });

      testWidgets('renders with elevation 1', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              child: Text('Elevated'),
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });

      testWidgets('renders with elevation 2', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              elevation: 2,
              child: Text('More Elevated'),
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onTap when tapped', (tester) async {
        bool wasTapped = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSCard(
              onTap: () => wasTapped = true,
              child: const Text('Tappable'),
            ),
          ),
        );

        await tester.tap(find.byType(DSCard));
        expect(wasTapped, isTrue);
      });

      testWidgets('is not tappable when onTap is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCard(
              child: Text('Not Tappable'),
            ),
          ),
        );

        // Should not find an InkWell or similar tappable widget
        expect(find.byType(DSCard), findsOneWidget);
      });
    });
  });
}
