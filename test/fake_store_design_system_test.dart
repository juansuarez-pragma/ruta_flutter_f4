import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  group('FakeStoreTheme', () {
    test('light theme is created successfully', () {
      final theme = FakeStoreTheme.light();
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.light);
    });

    test('dark theme is created successfully', () {
      final theme = FakeStoreTheme.dark();
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.dark);
    });

    test('light theme has DSThemeData extension', () {
      final theme = FakeStoreTheme.light();
      final dsTheme = theme.extension<DSThemeData>();
      expect(dsTheme, isNotNull);
    });

    test('dark theme has DSThemeData extension', () {
      final theme = FakeStoreTheme.dark();
      final dsTheme = theme.extension<DSThemeData>();
      expect(dsTheme, isNotNull);
    });
  });

  group('DSColors', () {
    test('primary colors are defined', () {
      expect(DSColors.primary500, isA<Color>());
      expect(DSColors.primary100, isA<Color>());
      expect(DSColors.primary900, isA<Color>());
    });

    test('neutral colors are defined', () {
      expect(DSColors.neutral100, isA<Color>());
      expect(DSColors.neutral500, isA<Color>());
      expect(DSColors.neutral900, isA<Color>());
    });

    test('semantic colors are defined', () {
      expect(DSColors.success500, isA<Color>());
      expect(DSColors.error500, isA<Color>());
      expect(DSColors.warning500, isA<Color>());
      expect(DSColors.info500, isA<Color>());
    });
  });

  group('DSSpacing', () {
    test('spacing values follow 4px grid', () {
      expect(DSSpacing.xs, 4.0);
      expect(DSSpacing.sm, 8.0);
      expect(DSSpacing.base, 16.0);
      expect(DSSpacing.lg, 20.0);
      expect(DSSpacing.xl, 24.0);
    });
  });

  group('DSBorderRadius', () {
    test('border radius values are defined', () {
      expect(DSBorderRadius.none, 0.0);
      expect(DSBorderRadius.sm, 4.0);
      expect(DSBorderRadius.md, 8.0);
      expect(DSBorderRadius.base, 12.0);
      expect(DSBorderRadius.lg, 16.0);
    });
  });
}
