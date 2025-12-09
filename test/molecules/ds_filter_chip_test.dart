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
  group('DSFilterChip', () {
    group('Rendering', () {
      testWidgets('renders label text', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Electronics',
              onTap: () {},
            ),
          ),
        );

        expect(find.text('Electronics'), findsOneWidget);
      });

      testWidgets('renders with icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Category',
              icon: Icons.category,
              onTap: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.category), findsOneWidget);
      });
    });

    group('Selection state', () {
      testWidgets('renders unselected state', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Filter',
              isSelected: false,
              onTap: () {},
            ),
          ),
        );

        expect(find.byType(DSFilterChip), findsOneWidget);
      });

      testWidgets('renders selected state', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Filter',
              isSelected: true,
              onTap: () {},
            ),
          ),
        );

        expect(find.byType(DSFilterChip), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onTap when tapped', (WidgetTester tester) async {
        bool wasTapped = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Tappable',
              onTap: () => wasTapped = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSFilterChip));
        expect(wasTapped, isTrue);
      });
    });
  });
}
