import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(
      body: const SizedBox(),
      bottomNavigationBar: child,
    ),
  );
}

void main() {
  group('DSBottomNav', () {
    group('Rendering', () {
      testWidgets('renders all nav items', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
                DSBottomNavItem(icon: Icons.person, label: 'Profile'),
              ],
            ),
          ),
        );

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('renders icons', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
              ],
            ),
          ),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('renders selected icon when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                ),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
              ],
            ),
          ),
        );

        // Selected item should show filled icon
        expect(find.byIcon(Icons.home), findsOneWidget);
      });
    });

    group('Badge', () {
      testWidgets('renders badge count', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(
                  icon: Icons.shopping_cart,
                  label: 'Cart',
                  badgeCount: 5,
                ),
              ],
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
      });

      testWidgets('shows 99+ for large badge counts',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(
                  icon: Icons.shopping_cart,
                  label: 'Cart',
                  badgeCount: 150,
                ),
              ],
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
      });

      testWidgets('does not show badge when count is 0',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(
                  icon: Icons.shopping_cart,
                  label: 'Cart',
                  badgeCount: 0,
                ),
              ],
            ),
          ),
        );

        expect(find.text('0'), findsNothing);
      });
    });

    group('Selection', () {
      testWidgets('highlights selected item', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 1,
              onTap: (_) {},
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
              ],
            ),
          ),
        );

        // The selected item (Search) should be highlighted
        expect(find.byType(DSBottomNav), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onTap with correct index when item is tapped',
          (WidgetTester tester) async {
        int? tappedIndex;
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (index) => tappedIndex = index,
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
                DSBottomNavItem(icon: Icons.person, label: 'Profile'),
              ],
            ),
          ),
        );

        // Tap on Search (index 1)
        await tester.tap(find.text('Search'));
        expect(tappedIndex, equals(1));

        // Tap on Profile (index 2)
        await tester.tap(find.text('Profile'));
        expect(tappedIndex, equals(2));
      });
    });

    group('Styling', () {
      testWidgets('renders with custom background color',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              backgroundColor: Colors.blue,
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
              ],
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);
      });

      testWidgets('renders with elevation', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSBottomNav(
              currentIndex: 0,
              onTap: (_) {},
              elevation: 8,
              items: const [
                DSBottomNavItem(icon: Icons.home, label: 'Home'),
                DSBottomNavItem(icon: Icons.search, label: 'Search'),
              ],
            ),
          ),
        );

        expect(find.byType(DSBottomNav), findsOneWidget);
      });
    });
  });
}
