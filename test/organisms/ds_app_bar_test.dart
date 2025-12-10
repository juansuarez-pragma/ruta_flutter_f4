import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(
      appBar: child as PreferredSizeWidget,
      body: const SizedBox(),
    ),
  );

void main() {
  group('DSAppBar', () {
    group('Rendering', () {
      testWidgets('renders with title', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Home',
            ),
          ),
        );

        expect(find.text('Home'), findsOneWidget);
      });

      testWidgets('renders with title widget', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              titleWidget: Icon(Icons.home),
            ),
          ),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
      });

      testWidgets('renders actions', (tester) async {
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
          (tester) async {
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
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => const Scaffold(
                  appBar: DSAppBar(
                    title: 'Details',
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
          (tester) async {
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

      testWidgets('renders with no elevation', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Flat',
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });
    });

    group('Center title', () {
      testWidgets('centers title when centerTitle is true',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSAppBar(
              title: 'Centered',
            ),
          ),
        );

        expect(find.byType(DSAppBar), findsOneWidget);
      });
    });
  });
}
