import 'package:fake_store_design_system/src/foundations/theme/ds_theme_data.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// Implementación del tema oscuro del sistema de diseño.
///
/// Proporciona todos los valores de tokens para el modo oscuro.
abstract final class DSThemeDark {
  /// Obtiene los datos del tema oscuro.
  static DSThemeData get data => const DSThemeData(
    // ============================================
    // SURFACE COLORS
    // ============================================
    colorSurfacePrimary: DSColors.neutral900,
    colorSurfaceSecondary: DSColors.neutral800,
    colorSurfaceTertiary: DSColors.neutral700,
    colorSurfaceInverse: DSColors.neutral100,
    colorSurfaceOverlay: DSColors.blackAlpha64,

    // ============================================
    // TEXT COLORS
    // ============================================
    colorTextPrimary: DSColors.neutral100,
    colorTextSecondary: DSColors.neutral300,
    colorTextTertiary: DSColors.neutral500,
    colorTextInverse: DSColors.neutral900,
    colorTextDisabled: DSColors.neutral600,
    colorTextLink: DSColors.primary300,

    // ============================================
    // BORDER COLORS
    // ============================================
    colorBorderPrimary: DSColors.neutral700,
    colorBorderSecondary: DSColors.neutral800,
    colorBorderFocus: DSColors.primary400,
    colorBorderError: DSColors.error400,

    // ============================================
    // ICON COLORS
    // ============================================
    colorIconPrimary: DSColors.neutral100,
    colorIconSecondary: DSColors.neutral400,
    colorIconInverse: DSColors.neutral900,
    colorIconDisabled: DSColors.neutral600,

    // ============================================
    // BRAND COLORS
    // ============================================
    colorBrandPrimary: DSColors.primary400,
    colorBrandSecondary: DSColors.secondary400,
    colorBrandPrimaryLight: DSColors.primary200,
    colorBrandPrimaryDark: DSColors.primary600,

    // ============================================
    // FEEDBACK COLORS
    // ============================================
    colorFeedbackSuccess: DSColors.success400,
    colorFeedbackSuccessLight: DSColors.success900,
    colorFeedbackError: DSColors.error400,
    colorFeedbackErrorLight: DSColors.error900,
    colorFeedbackWarning: DSColors.warning400,
    colorFeedbackWarningLight: DSColors.warning900,
    colorFeedbackInfo: DSColors.info400,
    colorFeedbackInfoLight: DSColors.info900,

    // ============================================
    // BUTTON - PRIMARY
    // ============================================
    buttonPrimaryBackground: DSColors.primary400,
    buttonPrimaryBackgroundHover: DSColors.primary300,
    buttonPrimaryBackgroundPressed: DSColors.primary500,
    buttonPrimaryBackgroundDisabled: DSColors.neutral700,
    buttonPrimaryText: DSColors.white,
    buttonPrimaryTextDisabled: DSColors.neutral500,

    // ============================================
    // BUTTON - SECONDARY
    // ============================================
    buttonSecondaryBackground: DSColors.transparent,
    buttonSecondaryBackgroundHover: DSColors.whiteAlpha8,
    buttonSecondaryBackgroundPressed: DSColors.whiteAlpha16,
    buttonSecondaryBorder: DSColors.primary400,
    buttonSecondaryText: DSColors.primary400,
    buttonSecondaryTextDisabled: DSColors.neutral600,

    // ============================================
    // BUTTON - GHOST
    // ============================================
    buttonGhostBackground: DSColors.transparent,
    buttonGhostBackgroundHover: DSColors.whiteAlpha8,
    buttonGhostBackgroundPressed: DSColors.whiteAlpha16,
    buttonGhostText: DSColors.primary400,
    buttonGhostTextDisabled: DSColors.neutral600,

    // ============================================
    // BUTTON - DANGER
    // ============================================
    buttonDangerBackground: DSColors.error700,
    buttonDangerBackgroundHover: DSColors.error600,
    buttonDangerBackgroundPressed: DSColors.error800,
    buttonDangerText: DSColors.white,
    buttonDangerBackgroundDisabled: DSColors.error900,
    buttonDangerTextDisabled: DSColors.error700,

    // ============================================
    // CARD
    // ============================================
    cardBackground: DSColors.neutral800,
    cardBackgroundHover: DSColors.neutral700,
    cardBorder: DSColors.neutral700,

    // ============================================
    // INPUT
    // ============================================
    inputBackground: DSColors.neutral800,
    inputBackgroundFocused: DSColors.neutral800,
    inputBorder: DSColors.neutral600,
    inputBorderFocused: DSColors.primary400,
    inputBorderError: DSColors.error400,
    inputText: DSColors.neutral100,
    inputPlaceholder: DSColors.neutral500,

    // ============================================
    // CHIP
    // ============================================
    chipBackground: DSColors.neutral800,
    chipBackgroundHover: DSColors.neutral700,
    chipBackgroundPressed: DSColors.neutral600,
    chipBackgroundSelected: DSColors.primary900,
    chipText: DSColors.neutral300,
    chipTextSelected: DSColors.primary300,
    chipBorder: DSColors.neutral700,

    // ============================================
    // BADGE
    // ============================================
    badgeBackground: DSColors.neutral700,
    badgeText: DSColors.neutral300,

    // ============================================
    // TYPOGRAPHY
    // ============================================
    typographyDisplayLarge: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.displayLarge,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.tight,
      letterSpacing: DSLetterSpacing.tight,
      color: DSColors.neutral100,
    ),
    typographyDisplayMedium: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.displayMedium,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.tight,
      letterSpacing: DSLetterSpacing.tight,
      color: DSColors.neutral100,
    ),
    typographyDisplaySmall: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.displaySmall,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.tight,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyHeadingLarge: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.headingLarge,
      fontWeight: DSFontWeight.semiBold,
      height: DSLineHeight.snug,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyHeadingMedium: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.headingMedium,
      fontWeight: DSFontWeight.semiBold,
      height: DSLineHeight.snug,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyHeadingSmall: TextStyle(
      fontFamily: DSFontFamily.display,
      fontSize: DSFontSize.headingSmall,
      fontWeight: DSFontWeight.semiBold,
      height: DSLineHeight.snug,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyTitleLarge: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.titleLarge,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyTitleMedium: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.titleMedium,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.wide,
      color: DSColors.neutral100,
    ),
    typographyTitleSmall: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.titleSmall,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.wide,
      color: DSColors.neutral100,
    ),
    typographyBodyLarge: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.bodyLarge,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyBodyMedium: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.bodyMedium,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyBodySmall: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.bodySmall,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral100,
    ),
    typographyLabelLarge: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.labelLarge,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.wide,
      color: DSColors.neutral100,
    ),
    typographyLabelMedium: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.labelMedium,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.wide,
      color: DSColors.neutral100,
    ),
    typographyLabelSmall: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.labelSmall,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.wide,
      color: DSColors.neutral100,
    ),
    typographyCaption: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.caption,
      fontWeight: DSFontWeight.regular,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.normal,
      color: DSColors.neutral400,
    ),
    typographyOverline: TextStyle(
      fontFamily: DSFontFamily.body,
      fontSize: DSFontSize.overline,
      fontWeight: DSFontWeight.medium,
      height: DSLineHeight.normal,
      letterSpacing: DSLetterSpacing.widest,
      color: DSColors.neutral400,
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
    elevationLevel1: DSElevation.level1Dark,
    elevationLevel2: DSElevation.level2Dark,
    elevationLevel3: DSElevation.level3Dark,
    elevationLevel4: DSElevation.level4Dark,
    elevationLevel5: DSElevation.level5Dark,
  );

  /// Obtiene el ThemeData completo para el tema oscuro.
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: DSColors.primary500,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: DSColors.neutral900,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: DSColors.neutral900,
      foregroundColor: DSColors.neutral100,
      surfaceTintColor: DSColors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.base),
        side: const BorderSide(color: DSColors.neutral700),
      ),
      color: DSColors.neutral800,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: DSColors.primary400,
        foregroundColor: DSColors.neutral900,
        disabledBackgroundColor: DSColors.neutral700,
        disabledForegroundColor: DSColors.neutral500,
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
        foregroundColor: DSColors.primary400,
        side: const BorderSide(color: DSColors.primary400),
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
        foregroundColor: DSColors.primary400,
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
      fillColor: DSColors.neutral800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        borderSide: const BorderSide(color: DSColors.neutral600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        borderSide: const BorderSide(color: DSColors.neutral600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        borderSide: const BorderSide(color: DSColors.primary400, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        borderSide: const BorderSide(color: DSColors.error400),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.base,
        vertical: DSSpacing.md,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: DSColors.neutral800,
      selectedColor: DSColors.primary900,
      labelStyle: const TextStyle(
        fontSize: DSFontSize.labelMedium,
        color: DSColors.neutral300,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.full),
      ),
      side: const BorderSide(color: DSColors.neutral700),
    ),
    dividerTheme: const DividerThemeData(
      color: DSColors.neutral700,
      thickness: 1,
      space: 1,
    ),
    extensions: [data],
  );
}
