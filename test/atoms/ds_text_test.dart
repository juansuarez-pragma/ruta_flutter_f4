import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSText', () {
    group('Rendering', () {
      testWidgets('renders text content', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText('Hello World'),
          ),
        );

        expect(find.text('Hello World'), findsOneWidget);
      });

      testWidgets('applies custom color', (tester) async {
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

      testWidgets('applies text alignment', (tester) async {
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

      testWidgets('applies max lines', (tester) async {
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

      testWidgets('applies overflow', (tester) async {
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
      testWidgets('renders headingLarge variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingLarge('Heading Large'),
          ),
        );

        expect(find.text('Heading Large'), findsOneWidget);
      });

      testWidgets('renders headingMedium variant',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingMedium('Heading Medium'),
          ),
        );

        expect(find.text('Heading Medium'), findsOneWidget);
      });

      testWidgets('renders headingSmall variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.headingSmall('Heading Small'),
          ),
        );

        expect(find.text('Heading Small'), findsOneWidget);
      });

      testWidgets('renders titleLarge variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.titleLarge('Title Large'),
          ),
        );

        expect(find.text('Title Large'), findsOneWidget);
      });

      testWidgets('renders titleMedium variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.titleMedium('Title Medium'),
          ),
        );

        expect(find.text('Title Medium'), findsOneWidget);
      });

      testWidgets('renders label variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.label('Label Text'),
          ),
        );

        expect(find.text('Label Text'), findsOneWidget);
      });

      testWidgets('renders bodyLarge variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyLarge('Body Large'),
          ),
        );

        expect(find.text('Body Large'), findsOneWidget);
      });

      testWidgets('renders bodyMedium variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodyMedium('Body Medium'),
          ),
        );

        expect(find.text('Body Medium'), findsOneWidget);
      });

      testWidgets('renders bodySmall variant', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSText.bodySmall('Body Small'),
          ),
        );

        expect(find.text('Body Small'), findsOneWidget);
      });

      testWidgets('renders caption variant', (tester) async {
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
