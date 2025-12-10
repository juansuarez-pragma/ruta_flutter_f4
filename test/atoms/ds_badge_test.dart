import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSBadge', () {
    group('Rendering', () {
      testWidgets('renders with text', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(text: 'New'),
          ),
        );

        expect(find.text('New'), findsOneWidget);
      });

      testWidgets('renders with icon', (tester) async {
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
      testWidgets('renders success type', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.success(text: 'Active'),
          ),
        );

        expect(find.text('Active'), findsOneWidget);
      });

      testWidgets('renders error type', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.error(text: 'Sold Out'),
          ),
        );

        expect(find.text('Sold Out'), findsOneWidget);
      });

      testWidgets('renders warning type', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.warning(text: 'Low Stock'),
          ),
        );

        expect(find.text('Low Stock'), findsOneWidget);
      });

      testWidgets('renders info type', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge.info(text: 'Featured'),
          ),
        );

        expect(find.text('Featured'), findsOneWidget);
      });

      testWidgets('renders neutral type by default',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(text: 'Default'),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('renders small size', (tester) async {
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

      testWidgets('renders medium size', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSBadge(
              text: 'Medium',
            ),
          ),
        );

        expect(find.byType(DSBadge), findsOneWidget);
      });

      testWidgets('renders large size', (tester) async {
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
