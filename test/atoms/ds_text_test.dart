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
  group('DSText', () {
    group('Rendering', () {
      testWidgets('renders text content', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText('Hello World'),
          ),
        );

        expect(find.text('Hello World'), findsOneWidget);
      });

      testWidgets('applies custom color', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText(
              'Colored Text',
              color: Colors.red,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.color, equals(Colors.red));
      });

      testWidgets('applies text alignment', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText(
              'Centered',
              textAlign: TextAlign.center,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.textAlign, equals(TextAlign.center));
      });

      testWidgets('applies max lines', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText(
              'Limited lines',
              maxLines: 2,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.maxLines, equals(2));
      });

      testWidgets('applies overflow', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText(
              'Ellipsis overflow',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      });
    });

    group('Variants', () {
      testWidgets('renders headingLarge variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingLarge('Heading Large'),
          ),
        );

        expect(find.text('Heading Large'), findsOneWidget);
      });

      testWidgets('renders headingMedium variant',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingMedium('Heading Medium'),
          ),
        );

        expect(find.text('Heading Medium'), findsOneWidget);
      });

      testWidgets('renders headingSmall variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingSmall('Heading Small'),
          ),
        );

        expect(find.text('Heading Small'), findsOneWidget);
      });

      testWidgets('renders titleLarge variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.titleLarge('Title Large'),
          ),
        );

        expect(find.text('Title Large'), findsOneWidget);
      });

      testWidgets('renders titleMedium variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.titleMedium('Title Medium'),
          ),
        );

        expect(find.text('Title Medium'), findsOneWidget);
      });

      testWidgets('renders label variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.label('Label Text'),
          ),
        );

        expect(find.text('Label Text'), findsOneWidget);
      });

      testWidgets('renders bodyLarge variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyLarge('Body Large'),
          ),
        );

        expect(find.text('Body Large'), findsOneWidget);
      });

      testWidgets('renders bodyMedium variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyMedium('Body Medium'),
          ),
        );

        expect(find.text('Body Medium'), findsOneWidget);
      });

      testWidgets('renders bodySmall variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodySmall('Body Small'),
          ),
        );

        expect(find.text('Body Small'), findsOneWidget);
      });

      testWidgets('renders caption variant', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.caption('Caption'),
          ),
        );

        expect(find.text('Caption'), findsOneWidget);
      });
    });
  });
}
