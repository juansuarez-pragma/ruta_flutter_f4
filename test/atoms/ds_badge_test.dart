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
  group('DSBadge', () {
    group('Rendering', () {
      testWidgets('renders with text', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(text: 'New'),
          ),
        );

        expect(find.text('New'), findsOneWidget);
      });

      testWidgets('renders with icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(
              text: 'Sale',
              icon: Icons.local_offer,
            ),
          ),
        );

        expect(find.byIcon(Icons.local_offer), findsOneWidget);
      });
    });

    group('Types', () {
      testWidgets('renders success type', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.success(text: 'Active'),
          ),
        );

        expect(find.text('Active'), findsOneWidget);
      });

      testWidgets('renders error type', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.error(text: 'Sold Out'),
          ),
        );

        expect(find.text('Sold Out'), findsOneWidget);
      });

      testWidgets('renders warning type', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.warning(text: 'Low Stock'),
          ),
        );

        expect(find.text('Low Stock'), findsOneWidget);
      });

      testWidgets('renders info type', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.info(text: 'Featured'),
          ),
        );

        expect(find.text('Featured'), findsOneWidget);
      });

      testWidgets('renders neutral type by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(text: 'Default'),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('renders small size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(
              text: 'Small',
              size: DSBadgeSize.small,
            ),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });

      testWidgets('renders medium size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(
              text: 'Medium',
              size: DSBadgeSize.medium,
            ),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });

      testWidgets('renders large size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(
              text: 'Large',
              size: DSBadgeSize.large,
            ),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });
    });
  });
}
