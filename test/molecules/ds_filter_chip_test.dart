import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSFilterChip', () {
    group('Rendering', () {
      testWidgets('renders label text', (tester) async {
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

      testWidgets('renders with icon', (tester) async {
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
      testWidgets('renders unselected state', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSFilterChip(
              label: 'Filter',
              onTap: () {},
            ),
          ),
        );

        expect(find.byType(DSFilterChip), findsOneWidget);
      });

      testWidgets('renders selected state', (tester) async {
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
      testWidgets('calls onTap when tapped', (tester) async {
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
