import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  group('DSContextExtension', () {
    group('tokens', () {
      testWidgets('returns DSThemeData from light theme',
          (WidgetTester tester) async {
        DSThemeData? capturedTokens;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                capturedTokens = context.tokens;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedTokens, isNotNull);
        expect(capturedTokens, isA<DSThemeData>());
      });

      testWidgets('returns DSThemeData from dark theme',
          (WidgetTester tester) async {
        DSThemeData? capturedTokens;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.dark(),
            home: Builder(
              builder: (context) {
                capturedTokens = context.tokens;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(capturedTokens, isNotNull);
        expect(capturedTokens, isA<DSThemeData>());
      });
    });

    group('isDarkMode', () {
      testWidgets('returns false for light theme',
          (WidgetTester tester) async {
        bool? isDark;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isDark = context.isDarkMode;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isDark, isFalse);
      });

      testWidgets('returns true for dark theme', (WidgetTester tester) async {
        bool? isDark;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.dark(),
            home: Builder(
              builder: (context) {
                isDark = context.isDarkMode;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isDark, isTrue);
      });
    });

    group('isLightMode', () {
      testWidgets('returns true for light theme', (WidgetTester tester) async {
        bool? isLight;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isLight = context.isLightMode;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isLight, isTrue);
      });

      testWidgets('returns false for dark theme', (WidgetTester tester) async {
        bool? isLight;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.dark(),
            home: Builder(
              builder: (context) {
                isLight = context.isLightMode;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isLight, isFalse);
      });
    });

    group('responsive breakpoints', () {
      testWidgets('isMobile returns true for small screens',
          (WidgetTester tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        bool? isMobile;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isMobile = context.isMobile;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isMobile, isTrue);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('isTablet returns true for medium screens',
          (WidgetTester tester) async {
        tester.view.physicalSize = const Size(800, 1024);
        tester.view.devicePixelRatio = 1.0;

        bool? isTablet;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                isTablet = context.isTablet;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(isTablet, isTrue);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });
  });
}
