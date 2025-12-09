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
  group('DSEmptyState', () {
    group('Rendering', () {
      testWidgets('renders with icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSEmptyState(
              icon: Icons.inbox,
              title: 'No items',
            ),
          ),
        );

        expect(find.byIcon(Icons.inbox), findsOneWidget);
        expect(find.text('No items'), findsOneWidget);
      });

      testWidgets('renders with description', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSEmptyState(
              icon: Icons.inbox,
              title: 'No items',
              description: 'Add items to get started',
            ),
          ),
        );

        expect(find.text('Add items to get started'), findsOneWidget);
      });

      testWidgets('renders with action button', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSEmptyState(
              icon: Icons.inbox,
              title: 'No items',
              actionText: 'Add Item',
              onAction: () {},
            ),
          ),
        );

        expect(find.text('Add Item'), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onAction when button is tapped',
          (WidgetTester tester) async {
        bool wasPressed = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSEmptyState(
              icon: Icons.inbox,
              title: 'No items',
              actionText: 'Add Item',
              onAction: () => wasPressed = true,
            ),
          ),
        );

        await tester.tap(find.text('Add Item'));
        expect(wasPressed, isTrue);
      });
    });
  });

  group('DSErrorState', () {
    group('Rendering', () {
      testWidgets('renders error message', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSErrorState(
              message: 'Something went wrong',
            ),
          ),
        );

        expect(find.text('Something went wrong'), findsOneWidget);
      });

      testWidgets('renders with custom icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSErrorState(
              icon: Icons.cloud_off,
              message: 'No connection',
            ),
          ),
        );

        expect(find.byIcon(Icons.cloud_off), findsOneWidget);
      });

      testWidgets('renders with details', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSErrorState(
              message: 'Error',
              details: 'Please try again later',
            ),
          ),
        );

        expect(find.text('Please try again later'), findsOneWidget);
      });

      testWidgets('renders with retry button', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSErrorState(
              message: 'Error',
              onRetry: () {},
            ),
          ),
        );

        // Should have a retry button with default text
        expect(find.text('Reintentar'), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onRetry when retry button is tapped',
          (WidgetTester tester) async {
        bool wasRetried = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSErrorState(
              message: 'Error',
              onRetry: () => wasRetried = true,
            ),
          ),
        );

        await tester.tap(find.text('Reintentar'));
        expect(wasRetried, isTrue);
      });
    });
  });

  group('DSLoadingState', () {
    group('Rendering', () {
      testWidgets('renders loading indicator', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSLoadingState(),
          ),
        );

        expect(find.byType(DSCircularLoader), findsOneWidget);
      });

      testWidgets('renders with message', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSLoadingState(
              message: 'Loading products...',
            ),
          ),
        );

        expect(find.text('Loading products...'), findsOneWidget);
      });
    });
  });
}
