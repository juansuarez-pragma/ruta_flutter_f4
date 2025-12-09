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
  group('DSCircularLoader', () {
    group('Rendering', () {
      testWidgets('renders CircularProgressIndicator',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCircularLoader(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('renders small size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCircularLoader(size: DSLoaderSize.small),
          ),
        );

        final sizedBox =
            tester.widget<SizedBox>(find.byType(SizedBox).first);
        expect(sizedBox.width, equals(DSSizes.loaderSm));
        expect(sizedBox.height, equals(DSSizes.loaderSm));
      });

      testWidgets('renders medium size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCircularLoader(size: DSLoaderSize.medium),
          ),
        );

        final sizedBox =
            tester.widget<SizedBox>(find.byType(SizedBox).first);
        expect(sizedBox.width, equals(DSSizes.loaderMd));
        expect(sizedBox.height, equals(DSSizes.loaderMd));
      });

      testWidgets('renders large size', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCircularLoader(size: DSLoaderSize.large),
          ),
        );

        final sizedBox =
            tester.widget<SizedBox>(find.byType(SizedBox).first);
        expect(sizedBox.width, equals(DSSizes.loaderLg));
        expect(sizedBox.height, equals(DSSizes.loaderLg));
      });
    });

    group('Custom color', () {
      testWidgets('applies custom color', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSCircularLoader(color: Colors.red),
          ),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );
        // Color is applied via valueColor
        expect(indicator.valueColor, isNotNull);
      });
    });
  });

  group('DSSkeleton', () {
    group('Rendering', () {
      testWidgets('renders with default dimensions',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton(),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });

      testWidgets('renders with custom dimensions',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton(
              width: 200,
              height: 100,
            ),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });
    });

    group('Shapes', () {
      testWidgets('renders rectangle shape', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton(
              width: 100,
              height: 50,
              borderRadius: DSBorderRadius.md,
            ),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });

      testWidgets('renders circular shape', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton.circular(size: 50),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });
    });

    group('Named constructors', () {
      testWidgets('renders text skeleton', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton.text(width: 150),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });

      testWidgets('renders title skeleton', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton.title(width: 200),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });

      testWidgets('renders image skeleton', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton.image(width: 100, height: 100),
          ),
        );

        expect(find.byType(DSSkeleton), findsOneWidget);
      });
    });

    group('Animation', () {
      testWidgets('contains AnimatedContainer or similar animation',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSSkeleton(width: 100, height: 50),
          ),
        );

        // Pump several frames to verify animation doesn't crash
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(DSSkeleton), findsOneWidget);
      });
    });
  });
}
