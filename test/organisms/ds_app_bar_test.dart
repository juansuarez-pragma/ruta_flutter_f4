import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(
      appBar: child as PreferredSizeWidget,
      body: const SizedBox(),
    ),
  );
}

void main() {
  group('DSAppBar', () {
    group('Rendering', () {
      testWidgets('renders with title', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Home',
            ),
          ),
        );

        expect(find.text('Home'), findsOneWidget);
      });

      testWidgets('renders with title widget', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              titleWidget: Icon(Icons.home),
            ),
          ),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
      });

      testWidgets('renders actions', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSAppBar(
              title: 'Home',
              actions: [
                DSIconButton(
                  icon: Icons.search,
                  onPressed: () {},
                ),
                DSIconButton(
                  icon: Icons.shopping_cart,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      });
    });

    group('Leading widget', () {
      testWidgets('renders custom leading widget',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSAppBar(
              title: 'Details',
              leading: DSIconButton(
                icon: Icons.arrow_back,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      });

      testWidgets('automatically implies leading when in Navigator',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => const Scaffold(
                  appBar: DSAppBar(
                    title: 'Details',
                    automaticallyImplyLeading: true,
                  ),
                  body: SizedBox(),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });
    });

    group('Elevation', () {
      testWidgets('renders with custom elevation',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Elevated',
              elevation: 4,
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });

      testWidgets('renders with no elevation', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Flat',
              elevation: 0,
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });
    });

    group('Center title', () {
      testWidgets('centers title when centerTitle is true',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Centered',
              centerTitle: true,
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });
    });
  });
}
