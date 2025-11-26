import 'package:flutter/material.dart';

import '../../tokens/tokens.dart';
import 'ds_theme_data.dart';

/// Implementación del tema claro del sistema de diseño.
///
/// Proporciona todos los valores de tokens para el modo claro.
abstract final class DSThemeLight {
  /// Obtiene los datos del tema claro.
  static DSThemeData get data => DSThemeData(
        // ============================================
        // SURFACE COLORS
        // ============================================
        colorSurfacePrimary: DSColors.white,
        colorSurfaceSecondary: DSColors.neutral50,
        colorSurfaceTertiary: DSColors.neutral100,
        colorSurfaceInverse: DSColors.neutral900,
        colorSurfaceOverlay: DSColors.blackAlpha48,

        // ============================================
        // TEXT COLORS
        // ============================================
        colorTextPrimary: DSColors.neutral900,
        colorTextSecondary: DSColors.neutral700,
        colorTextTertiary: DSColors.neutral500,
        colorTextInverse: DSColors.white,
        colorTextDisabled: DSColors.neutral400,
        colorTextLink: DSColors.primary500,

        // ============================================
        // BORDER COLORS
        // ============================================
        colorBorderPrimary: DSColors.neutral300,
        colorBorderSecondary: DSColors.neutral200,
        colorBorderFocus: DSColors.primary500,
        colorBorderError: DSColors.error500,

        // ============================================
        // ICON COLORS
        // ============================================
        colorIconPrimary: DSColors.neutral900,
        colorIconSecondary: DSColors.neutral600,
        colorIconInverse: DSColors.white,
        colorIconDisabled: DSColors.neutral400,

        // ============================================
        // BRAND COLORS
        // ============================================
        colorBrandPrimary: DSColors.primary500,
        colorBrandSecondary: DSColors.secondary500,
        colorBrandPrimaryLight: DSColors.primary100,
        colorBrandPrimaryDark: DSColors.primary700,

        // ============================================
        // FEEDBACK COLORS
        // ============================================
        colorFeedbackSuccess: DSColors.success500,
        colorFeedbackSuccessLight: DSColors.success50,
        colorFeedbackError: DSColors.error500,
        colorFeedbackErrorLight: DSColors.error50,
        colorFeedbackWarning: DSColors.warning500,
        colorFeedbackWarningLight: DSColors.warning50,
        colorFeedbackInfo: DSColors.info500,
        colorFeedbackInfoLight: DSColors.info50,

        // ============================================
        // BUTTON - PRIMARY
        // ============================================
        buttonPrimaryBackground: DSColors.primary500,
        buttonPrimaryBackgroundHover: DSColors.primary600,
        buttonPrimaryBackgroundPressed: DSColors.primary700,
        buttonPrimaryBackgroundDisabled: DSColors.neutral200,
        buttonPrimaryText: DSColors.white,
        buttonPrimaryTextDisabled: DSColors.neutral400,

        // ============================================
        // BUTTON - SECONDARY
        // ============================================
        buttonSecondaryBackground: DSColors.transparent,
        buttonSecondaryBackgroundHover: DSColors.primary50,
        buttonSecondaryBackgroundPressed: DSColors.primary100,
        buttonSecondaryBorder: DSColors.primary500,
        buttonSecondaryText: DSColors.primary500,
        buttonSecondaryTextDisabled: DSColors.neutral400,

        // ============================================
        // BUTTON - GHOST
        // ============================================
        buttonGhostBackground: DSColors.transparent,
        buttonGhostBackgroundHover: DSColors.neutral100,
        buttonGhostBackgroundPressed: DSColors.neutral200,
        buttonGhostText: DSColors.primary500,
        buttonGhostTextDisabled: DSColors.neutral400,

        // ============================================
        // BUTTON - DANGER
        // ============================================
        buttonDangerBackground: DSColors.error500,
        buttonDangerBackgroundHover: DSColors.error700,
        buttonDangerText: DSColors.white,

        // ============================================
        // CARD
        // ============================================
        cardBackground: DSColors.white,
        cardBackgroundHover: DSColors.neutral50,
        cardBorder: DSColors.neutral200,

        // ============================================
        // INPUT
        // ============================================
        inputBackground: DSColors.white,
        inputBackgroundFocused: DSColors.white,
        inputBorder: DSColors.neutral300,
        inputBorderFocused: DSColors.primary500,
        inputBorderError: DSColors.error500,
        inputText: DSColors.neutral900,
        inputPlaceholder: DSColors.neutral500,

        // ============================================
        // CHIP
        // ============================================
        chipBackground: DSColors.neutral100,
        chipBackgroundSelected: DSColors.primary100,
        chipText: DSColors.neutral700,
        chipTextSelected: DSColors.primary700,
        chipBorder: DSColors.neutral300,

        // ============================================
        // BADGE
        // ============================================
        badgeBackground: DSColors.neutral200,
        badgeText: DSColors.neutral700,

        // ============================================
        // TYPOGRAPHY
        // ============================================
        typographyDisplayLarge: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.displayLarge,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.tight,
          letterSpacing: DSLetterSpacing.tight,
          color: DSColors.neutral900,
        ),
        typographyDisplayMedium: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.displayMedium,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.tight,
          letterSpacing: DSLetterSpacing.tight,
          color: DSColors.neutral900,
        ),
        typographyDisplaySmall: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.displaySmall,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.tight,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyHeadingLarge: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.headingLarge,
          fontWeight: DSFontWeight.semiBold,
          height: DSLineHeight.snug,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyHeadingMedium: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.headingMedium,
          fontWeight: DSFontWeight.semiBold,
          height: DSLineHeight.snug,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyHeadingSmall: TextStyle(
          fontFamily: DSFontFamily.display,
          fontSize: DSFontSize.headingSmall,
          fontWeight: DSFontWeight.semiBold,
          height: DSLineHeight.snug,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyTitleLarge: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.titleLarge,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyTitleMedium: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.titleMedium,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.neutral900,
        ),
        typographyTitleSmall: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.titleSmall,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.neutral900,
        ),
        typographyBodyLarge: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.bodyLarge,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyBodyMedium: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.bodyMedium,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyBodySmall: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.bodySmall,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral900,
        ),
        typographyLabelLarge: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.labelLarge,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.neutral900,
        ),
        typographyLabelMedium: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.labelMedium,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.neutral900,
        ),
        typographyLabelSmall: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.labelSmall,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.neutral900,
        ),
        typographyCaption: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.caption,
          fontWeight: DSFontWeight.regular,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.normal,
          color: DSColors.neutral600,
        ),
        typographyOverline: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.overline,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.widest,
          color: DSColors.neutral600,
        ),
        typographyButton: TextStyle(
          fontFamily: DSFontFamily.body,
          fontSize: DSFontSize.labelLarge,
          fontWeight: DSFontWeight.medium,
          height: DSLineHeight.normal,
          letterSpacing: DSLetterSpacing.wide,
          color: DSColors.white,
        ),

        // ============================================
        // ELEVATION
        // ============================================
        elevationLevel1: DSElevation.level1,
        elevationLevel2: DSElevation.level2,
        elevationLevel3: DSElevation.level3,
        elevationLevel4: DSElevation.level4,
        elevationLevel5: DSElevation.level5,
      );

  /// Obtiene el ThemeData completo para el tema claro.
  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: DSColors.primary500,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: DSColors.neutral50,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: DSColors.white,
          foregroundColor: DSColors.neutral900,
          surfaceTintColor: DSColors.transparent,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.base),
            side: const BorderSide(color: DSColors.neutral200),
          ),
          color: DSColors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: DSColors.primary500,
            foregroundColor: DSColors.white,
            disabledBackgroundColor: DSColors.neutral200,
            disabledForegroundColor: DSColors.neutral400,
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.xl,
              vertical: DSSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: DSColors.primary500,
            side: const BorderSide(color: DSColors.primary500),
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.xl,
              vertical: DSSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: DSColors.primary500,
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.base,
              vertical: DSSpacing.sm,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DSBorderRadius.md),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: DSColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
            borderSide: const BorderSide(color: DSColors.neutral300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
            borderSide: const BorderSide(color: DSColors.neutral300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
            borderSide: const BorderSide(color: DSColors.primary500, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
            borderSide: const BorderSide(color: DSColors.error500),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DSSpacing.base,
            vertical: DSSpacing.md,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: DSColors.neutral100,
          selectedColor: DSColors.primary100,
          labelStyle: const TextStyle(
            fontSize: DSFontSize.labelMedium,
            color: DSColors.neutral700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.full),
          ),
          side: const BorderSide(color: DSColors.neutral300),
        ),
        dividerTheme: const DividerThemeData(
          color: DSColors.neutral200,
          thickness: 1,
          space: 1,
        ),
        extensions: [data],
      );
}
