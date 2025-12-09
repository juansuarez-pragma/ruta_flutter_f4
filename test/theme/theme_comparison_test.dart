import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  group('Theme Comparison Tests', () {
    late DSThemeData lightTokens;
    late DSThemeData darkTokens;

    setUp(() {
      final lightTheme = FakeStoreTheme.light();
      final darkTheme = FakeStoreTheme.dark();
      lightTokens = lightTheme.extension<DSThemeData>()!;
      darkTokens = darkTheme.extension<DSThemeData>()!;
    });

    group('Theme Differentiation', () {
      test('light and dark themes have different surface colors', () {
        expect(lightTokens.colorSurfacePrimary,
            isNot(equals(darkTokens.colorSurfacePrimary)));
        expect(lightTokens.colorSurfaceSecondary,
            isNot(equals(darkTokens.colorSurfaceSecondary)));
      });

      test('light and dark themes have different text colors', () {
        expect(lightTokens.colorTextPrimary,
            isNot(equals(darkTokens.colorTextPrimary)));
        expect(lightTokens.colorTextSecondary,
            isNot(equals(darkTokens.colorTextSecondary)));
      });

      test('light theme has lighter surface than dark theme', () {
        final lightLuminance =
            lightTokens.colorSurfacePrimary.computeLuminance();
        final darkLuminance =
            darkTokens.colorSurfacePrimary.computeLuminance();
        expect(lightLuminance, greaterThan(darkLuminance),
            reason:
                'Light surface luminance ($lightLuminance) should be greater than dark ($darkLuminance)');
      });

      test('dark theme has lighter text than light theme', () {
        final lightTextLuminance =
            lightTokens.colorTextPrimary.computeLuminance();
        final darkTextLuminance =
            darkTokens.colorTextPrimary.computeLuminance();
        expect(darkTextLuminance, greaterThan(lightTextLuminance),
            reason:
                'Dark theme text luminance ($darkTextLuminance) should be greater than light theme ($lightTextLuminance)');
      });
    });

    group('Token Consistency', () {
      test('both themes have defined brand primary color', () {
        // Brand colors are defined in both themes
        expect(lightTokens.colorBrandPrimary, isNotNull);
        expect(darkTokens.colorBrandPrimary, isNotNull);
        // Both should have reasonable saturation for brand recognition
        final lightHsl =
            HSLColor.fromColor(lightTokens.colorBrandPrimary);
        final darkHsl = HSLColor.fromColor(darkTokens.colorBrandPrimary);
        expect(lightHsl.saturation, greaterThan(0.3));
        expect(darkHsl.saturation, greaterThan(0.3));
      });

      test('feedback colors are semantically appropriate', () {
        // Error colors should be red-ish in both themes
        expect(lightTokens.colorFeedbackError.red,
            greaterThan(lightTokens.colorFeedbackError.green));
        expect(darkTokens.colorFeedbackError.red,
            greaterThan(darkTokens.colorFeedbackError.green));

        // Success colors should be green-ish in both themes
        expect(lightTokens.colorFeedbackSuccess.green,
            greaterThan(lightTokens.colorFeedbackSuccess.red));
        expect(darkTokens.colorFeedbackSuccess.green,
            greaterThan(darkTokens.colorFeedbackSuccess.red));
      });

      test('typography styles are consistent across themes', () {
        expect(lightTokens.typographyHeadingLarge.fontSize,
            equals(darkTokens.typographyHeadingLarge.fontSize));
        expect(lightTokens.typographyBodyMedium.fontSize,
            equals(darkTokens.typographyBodyMedium.fontSize));
      });
    });

    group('Theme Extension lerp', () {
      test('lerp at 0.0 returns start theme', () {
        final lerped = lightTokens.lerp(darkTokens, 0.0) as DSThemeData;
        expect(lerped.colorSurfacePrimary,
            equals(lightTokens.colorSurfacePrimary));
      });

      test('lerp at 1.0 returns end theme', () {
        final lerped = lightTokens.lerp(darkTokens, 1.0) as DSThemeData;
        expect(lerped.colorSurfacePrimary,
            equals(darkTokens.colorSurfacePrimary));
      });

      test('lerp at 0.5 returns intermediate values', () {
        final lerped = lightTokens.lerp(darkTokens, 0.5) as DSThemeData;
        final lightRed = lightTokens.colorSurfacePrimary.red;
        final darkRed = darkTokens.colorSurfacePrimary.red;
        final expectedRed = ((lightRed + darkRed) / 2).round();

        // Allow for rounding differences
        expect(lerped.colorSurfacePrimary.red, closeTo(expectedRed, 1));
      });
    });

    group('Theme copyWith', () {
      test('copyWith preserves unchanged values', () {
        final newColor = Colors.purple;
        final copied = lightTokens.copyWith(colorBrandPrimary: newColor);

        expect(copied.colorBrandPrimary, equals(newColor));
        expect(copied.colorSurfacePrimary,
            equals(lightTokens.colorSurfacePrimary));
        expect(
            copied.colorTextPrimary, equals(lightTokens.colorTextPrimary));
      });

      test('copyWith can modify multiple values', () {
        final copied = lightTokens.copyWith(
          colorBrandPrimary: Colors.red,
          colorBrandSecondary: Colors.blue,
        );

        expect(copied.colorBrandPrimary, equals(Colors.red));
        expect(copied.colorBrandSecondary, equals(Colors.blue));
      });
    });

    group('FakeStoreTheme Factory', () {
      test('light() returns theme with light brightness', () {
        final theme = FakeStoreTheme.light();
        expect(theme.brightness, equals(Brightness.light));
      });

      test('dark() returns theme with dark brightness', () {
        final theme = FakeStoreTheme.dark();
        expect(theme.brightness, equals(Brightness.dark));
      });

      testWidgets('of() returns DSThemeData from context', (tester) async {
        late DSThemeData contextTokens;

        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            home: Builder(
              builder: (context) {
                contextTokens = context.tokens;
                return const SizedBox();
              },
            ),
          ),
        );

        expect(contextTokens, isA<DSThemeData>());
        expect(contextTokens.colorSurfacePrimary,
            equals(lightTokens.colorSurfacePrimary));
      });
    });

    group('Context Extensions', () {
      testWidgets('isDarkMode returns true for dark theme', (tester) async {
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

      testWidgets('isLightMode returns true for light theme', (tester) async {
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
    });
  });
}
