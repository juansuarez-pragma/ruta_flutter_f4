import 'package:flutter/material.dart';

/// Datos del tema del sistema de diseño.
///
/// Extiende [ThemeExtension] para integrarse con el sistema de temas de Flutter.
/// Proporciona todos los tokens semánticos necesarios para los componentes.
///
/// ## Uso
///
/// ```dart
/// // Acceso via extensión de contexto
/// final tokens = context.tokens;
/// Container(color: tokens.colorSurfacePrimary);
///
/// // Acceso directo desde Theme
/// final tokens = Theme.of(context).extension<DSThemeData>()!;
/// ```
class DSThemeData extends ThemeExtension<DSThemeData> {
  // ============================================
  // SURFACE COLORS
  // ============================================

  /// Color de superficie primaria (fondo principal)
  final Color colorSurfacePrimary;

  /// Color de superficie secundaria (fondo secundario)
  final Color colorSurfaceSecondary;

  /// Color de superficie terciaria (fondo elevado)
  final Color colorSurfaceTertiary;

  /// Color de superficie inversa
  final Color colorSurfaceInverse;

  /// Color de overlay/scrim
  final Color colorSurfaceOverlay;

  // ============================================
  // TEXT COLORS
  // ============================================

  /// Color de texto primario
  final Color colorTextPrimary;

  /// Color de texto secundario
  final Color colorTextSecondary;

  /// Color de texto terciario
  final Color colorTextTertiary;

  /// Color de texto inverso
  final Color colorTextInverse;

  /// Color de texto deshabilitado
  final Color colorTextDisabled;

  /// Color de texto para enlaces
  final Color colorTextLink;

  // ============================================
  // BORDER COLORS
  // ============================================

  /// Color de borde primario
  final Color colorBorderPrimary;

  /// Color de borde secundario
  final Color colorBorderSecondary;

  /// Color de borde cuando está enfocado
  final Color colorBorderFocus;

  /// Color de borde en estado de error
  final Color colorBorderError;

  // ============================================
  // ICON COLORS
  // ============================================

  /// Color de ícono primario
  final Color colorIconPrimary;

  /// Color de ícono secundario
  final Color colorIconSecondary;

  /// Color de ícono inverso
  final Color colorIconInverse;

  /// Color de ícono deshabilitado
  final Color colorIconDisabled;

  // ============================================
  // BRAND COLORS
  // ============================================

  /// Color de marca primario
  final Color colorBrandPrimary;

  /// Color de marca secundario
  final Color colorBrandSecondary;

  /// Color de marca primario claro
  final Color colorBrandPrimaryLight;

  /// Color de marca primario oscuro
  final Color colorBrandPrimaryDark;

  // ============================================
  // FEEDBACK COLORS
  // ============================================

  /// Color de éxito
  final Color colorFeedbackSuccess;

  /// Color de éxito claro (para fondos)
  final Color colorFeedbackSuccessLight;

  /// Color de error
  final Color colorFeedbackError;

  /// Color de error claro (para fondos)
  final Color colorFeedbackErrorLight;

  /// Color de advertencia
  final Color colorFeedbackWarning;

  /// Color de advertencia claro (para fondos)
  final Color colorFeedbackWarningLight;

  /// Color de información
  final Color colorFeedbackInfo;

  /// Color de información claro (para fondos)
  final Color colorFeedbackInfoLight;

  // ============================================
  // BUTTON - PRIMARY
  // ============================================

  /// Fondo del botón primario
  final Color buttonPrimaryBackground;

  /// Fondo del botón primario en hover
  final Color buttonPrimaryBackgroundHover;

  /// Fondo del botón primario presionado
  final Color buttonPrimaryBackgroundPressed;

  /// Fondo del botón primario deshabilitado
  final Color buttonPrimaryBackgroundDisabled;

  /// Texto del botón primario
  final Color buttonPrimaryText;

  /// Texto del botón primario deshabilitado
  final Color buttonPrimaryTextDisabled;

  // ============================================
  // BUTTON - SECONDARY
  // ============================================

  /// Fondo del botón secundario
  final Color buttonSecondaryBackground;

  /// Fondo del botón secundario en hover
  final Color buttonSecondaryBackgroundHover;

  /// Fondo del botón secundario presionado
  final Color buttonSecondaryBackgroundPressed;

  /// Borde del botón secundario
  final Color buttonSecondaryBorder;

  /// Texto del botón secundario
  final Color buttonSecondaryText;

  /// Texto del botón secundario deshabilitado
  final Color buttonSecondaryTextDisabled;

  // ============================================
  // BUTTON - GHOST
  // ============================================

  /// Fondo del botón ghost
  final Color buttonGhostBackground;

  /// Fondo del botón ghost en hover
  final Color buttonGhostBackgroundHover;

  /// Fondo del botón ghost presionado
  final Color buttonGhostBackgroundPressed;

  /// Texto del botón ghost
  final Color buttonGhostText;

  /// Texto del botón ghost deshabilitado
  final Color buttonGhostTextDisabled;

  // ============================================
  // BUTTON - DANGER
  // ============================================

  /// Fondo del botón de peligro
  final Color buttonDangerBackground;

  /// Fondo del botón de peligro en hover
  final Color buttonDangerBackgroundHover;

  /// Fondo del botón de peligro presionado
  final Color buttonDangerBackgroundPressed;

  /// Texto del botón de peligro
  final Color buttonDangerText;

  /// Fondo del botón de peligro deshabilitado
  final Color buttonDangerBackgroundDisabled;

  /// Texto del botón de peligro deshabilitado
  final Color buttonDangerTextDisabled;

  // ============================================
  // CARD
  // ============================================

  /// Fondo de la card
  final Color cardBackground;

  /// Fondo de la card en hover
  final Color cardBackgroundHover;

  /// Borde de la card
  final Color cardBorder;

  // ============================================
  // INPUT
  // ============================================

  /// Fondo del input
  final Color inputBackground;

  /// Fondo del input enfocado
  final Color inputBackgroundFocused;

  /// Borde del input
  final Color inputBorder;

  /// Borde del input enfocado
  final Color inputBorderFocused;

  /// Borde del input en error
  final Color inputBorderError;

  /// Texto del input
  final Color inputText;

  /// Placeholder del input
  final Color inputPlaceholder;

  // ============================================
  // CHIP
  // ============================================

  /// Fondo del chip
  final Color chipBackground;

  /// Fondo del chip en hover
  final Color chipBackgroundHover;

  /// Fondo del chip presionado
  final Color chipBackgroundPressed;

  /// Fondo del chip seleccionado
  final Color chipBackgroundSelected;

  /// Texto del chip
  final Color chipText;

  /// Texto del chip seleccionado
  final Color chipTextSelected;

  /// Borde del chip
  final Color chipBorder;

  // ============================================
  // BADGE
  // ============================================

  /// Fondo del badge por defecto
  final Color badgeBackground;

  /// Texto del badge por defecto
  final Color badgeText;

  // ============================================
  // TYPOGRAPHY STYLES
  // ============================================

  /// Display Large
  final TextStyle typographyDisplayLarge;

  /// Display Medium
  final TextStyle typographyDisplayMedium;

  /// Display Small
  final TextStyle typographyDisplaySmall;

  /// Heading Large
  final TextStyle typographyHeadingLarge;

  /// Heading Medium
  final TextStyle typographyHeadingMedium;

  /// Heading Small
  final TextStyle typographyHeadingSmall;

  /// Title Large
  final TextStyle typographyTitleLarge;

  /// Title Medium
  final TextStyle typographyTitleMedium;

  /// Title Small
  final TextStyle typographyTitleSmall;

  /// Body Large
  final TextStyle typographyBodyLarge;

  /// Body Medium
  final TextStyle typographyBodyMedium;

  /// Body Small
  final TextStyle typographyBodySmall;

  /// Label Large
  final TextStyle typographyLabelLarge;

  /// Label Medium
  final TextStyle typographyLabelMedium;

  /// Label Small
  final TextStyle typographyLabelSmall;

  /// Caption
  final TextStyle typographyCaption;

  /// Overline
  final TextStyle typographyOverline;

  /// Button text style
  final TextStyle typographyButton;

  // ============================================
  // ELEVATION
  // ============================================

  /// Elevación nivel 1
  final List<BoxShadow> elevationLevel1;

  /// Elevación nivel 2
  final List<BoxShadow> elevationLevel2;

  /// Elevación nivel 3
  final List<BoxShadow> elevationLevel3;

  /// Elevación nivel 4
  final List<BoxShadow> elevationLevel4;

  /// Elevación nivel 5
  final List<BoxShadow> elevationLevel5;

  /// Constructor
  const DSThemeData({
    // Surface
    required this.colorSurfacePrimary,
    required this.colorSurfaceSecondary,
    required this.colorSurfaceTertiary,
    required this.colorSurfaceInverse,
    required this.colorSurfaceOverlay,
    // Text
    required this.colorTextPrimary,
    required this.colorTextSecondary,
    required this.colorTextTertiary,
    required this.colorTextInverse,
    required this.colorTextDisabled,
    required this.colorTextLink,
    // Border
    required this.colorBorderPrimary,
    required this.colorBorderSecondary,
    required this.colorBorderFocus,
    required this.colorBorderError,
    // Icon
    required this.colorIconPrimary,
    required this.colorIconSecondary,
    required this.colorIconInverse,
    required this.colorIconDisabled,
    // Brand
    required this.colorBrandPrimary,
    required this.colorBrandSecondary,
    required this.colorBrandPrimaryLight,
    required this.colorBrandPrimaryDark,
    // Feedback
    required this.colorFeedbackSuccess,
    required this.colorFeedbackSuccessLight,
    required this.colorFeedbackError,
    required this.colorFeedbackErrorLight,
    required this.colorFeedbackWarning,
    required this.colorFeedbackWarningLight,
    required this.colorFeedbackInfo,
    required this.colorFeedbackInfoLight,
    // Button Primary
    required this.buttonPrimaryBackground,
    required this.buttonPrimaryBackgroundHover,
    required this.buttonPrimaryBackgroundPressed,
    required this.buttonPrimaryBackgroundDisabled,
    required this.buttonPrimaryText,
    required this.buttonPrimaryTextDisabled,
    // Button Secondary
    required this.buttonSecondaryBackground,
    required this.buttonSecondaryBackgroundHover,
    required this.buttonSecondaryBackgroundPressed,
    required this.buttonSecondaryBorder,
    required this.buttonSecondaryText,
    required this.buttonSecondaryTextDisabled,
    // Button Ghost
    required this.buttonGhostBackground,
    required this.buttonGhostBackgroundHover,
    required this.buttonGhostBackgroundPressed,
    required this.buttonGhostText,
    required this.buttonGhostTextDisabled,
    // Button Danger
    required this.buttonDangerBackground,
    required this.buttonDangerBackgroundHover,
    required this.buttonDangerBackgroundPressed,
    required this.buttonDangerText,
    required this.buttonDangerBackgroundDisabled,
    required this.buttonDangerTextDisabled,
    // Card
    required this.cardBackground,
    required this.cardBackgroundHover,
    required this.cardBorder,
    // Input
    required this.inputBackground,
    required this.inputBackgroundFocused,
    required this.inputBorder,
    required this.inputBorderFocused,
    required this.inputBorderError,
    required this.inputText,
    required this.inputPlaceholder,
    // Chip
    required this.chipBackground,
    required this.chipBackgroundHover,
    required this.chipBackgroundPressed,
    required this.chipBackgroundSelected,
    required this.chipText,
    required this.chipTextSelected,
    required this.chipBorder,
    // Badge
    required this.badgeBackground,
    required this.badgeText,
    // Typography
    required this.typographyDisplayLarge,
    required this.typographyDisplayMedium,
    required this.typographyDisplaySmall,
    required this.typographyHeadingLarge,
    required this.typographyHeadingMedium,
    required this.typographyHeadingSmall,
    required this.typographyTitleLarge,
    required this.typographyTitleMedium,
    required this.typographyTitleSmall,
    required this.typographyBodyLarge,
    required this.typographyBodyMedium,
    required this.typographyBodySmall,
    required this.typographyLabelLarge,
    required this.typographyLabelMedium,
    required this.typographyLabelSmall,
    required this.typographyCaption,
    required this.typographyOverline,
    required this.typographyButton,
    // Elevation
    required this.elevationLevel1,
    required this.elevationLevel2,
    required this.elevationLevel3,
    required this.elevationLevel4,
    required this.elevationLevel5,
  });

  @override
  DSThemeData copyWith({
    // Surface
    Color? colorSurfacePrimary,
    Color? colorSurfaceSecondary,
    Color? colorSurfaceTertiary,
    Color? colorSurfaceInverse,
    Color? colorSurfaceOverlay,
    // Text
    Color? colorTextPrimary,
    Color? colorTextSecondary,
    Color? colorTextTertiary,
    Color? colorTextInverse,
    Color? colorTextDisabled,
    Color? colorTextLink,
    // Border
    Color? colorBorderPrimary,
    Color? colorBorderSecondary,
    Color? colorBorderFocus,
    Color? colorBorderError,
    // Icon
    Color? colorIconPrimary,
    Color? colorIconSecondary,
    Color? colorIconInverse,
    Color? colorIconDisabled,
    // Brand
    Color? colorBrandPrimary,
    Color? colorBrandSecondary,
    Color? colorBrandPrimaryLight,
    Color? colorBrandPrimaryDark,
    // Feedback
    Color? colorFeedbackSuccess,
    Color? colorFeedbackSuccessLight,
    Color? colorFeedbackError,
    Color? colorFeedbackErrorLight,
    Color? colorFeedbackWarning,
    Color? colorFeedbackWarningLight,
    Color? colorFeedbackInfo,
    Color? colorFeedbackInfoLight,
    // Button Primary
    Color? buttonPrimaryBackground,
    Color? buttonPrimaryBackgroundHover,
    Color? buttonPrimaryBackgroundPressed,
    Color? buttonPrimaryBackgroundDisabled,
    Color? buttonPrimaryText,
    Color? buttonPrimaryTextDisabled,
    // Button Secondary
    Color? buttonSecondaryBackground,
    Color? buttonSecondaryBackgroundHover,
    Color? buttonSecondaryBackgroundPressed,
    Color? buttonSecondaryBorder,
    Color? buttonSecondaryText,
    Color? buttonSecondaryTextDisabled,
    // Button Ghost
    Color? buttonGhostBackground,
    Color? buttonGhostBackgroundHover,
    Color? buttonGhostBackgroundPressed,
    Color? buttonGhostText,
    Color? buttonGhostTextDisabled,
    // Button Danger
    Color? buttonDangerBackground,
    Color? buttonDangerBackgroundHover,
    Color? buttonDangerBackgroundPressed,
    Color? buttonDangerText,
    Color? buttonDangerBackgroundDisabled,
    Color? buttonDangerTextDisabled,
    // Card
    Color? cardBackground,
    Color? cardBackgroundHover,
    Color? cardBorder,
    // Input
    Color? inputBackground,
    Color? inputBackgroundFocused,
    Color? inputBorder,
    Color? inputBorderFocused,
    Color? inputBorderError,
    Color? inputText,
    Color? inputPlaceholder,
    // Chip
    Color? chipBackground,
    Color? chipBackgroundHover,
    Color? chipBackgroundPressed,
    Color? chipBackgroundSelected,
    Color? chipText,
    Color? chipTextSelected,
    Color? chipBorder,
    // Badge
    Color? badgeBackground,
    Color? badgeText,
    // Typography
    TextStyle? typographyDisplayLarge,
    TextStyle? typographyDisplayMedium,
    TextStyle? typographyDisplaySmall,
    TextStyle? typographyHeadingLarge,
    TextStyle? typographyHeadingMedium,
    TextStyle? typographyHeadingSmall,
    TextStyle? typographyTitleLarge,
    TextStyle? typographyTitleMedium,
    TextStyle? typographyTitleSmall,
    TextStyle? typographyBodyLarge,
    TextStyle? typographyBodyMedium,
    TextStyle? typographyBodySmall,
    TextStyle? typographyLabelLarge,
    TextStyle? typographyLabelMedium,
    TextStyle? typographyLabelSmall,
    TextStyle? typographyCaption,
    TextStyle? typographyOverline,
    TextStyle? typographyButton,
    // Elevation
    List<BoxShadow>? elevationLevel1,
    List<BoxShadow>? elevationLevel2,
    List<BoxShadow>? elevationLevel3,
    List<BoxShadow>? elevationLevel4,
    List<BoxShadow>? elevationLevel5,
  }) => DSThemeData(
      // Surface
      colorSurfacePrimary: colorSurfacePrimary ?? this.colorSurfacePrimary,
      colorSurfaceSecondary:
          colorSurfaceSecondary ?? this.colorSurfaceSecondary,
      colorSurfaceTertiary: colorSurfaceTertiary ?? this.colorSurfaceTertiary,
      colorSurfaceInverse: colorSurfaceInverse ?? this.colorSurfaceInverse,
      colorSurfaceOverlay: colorSurfaceOverlay ?? this.colorSurfaceOverlay,
      // Text
      colorTextPrimary: colorTextPrimary ?? this.colorTextPrimary,
      colorTextSecondary: colorTextSecondary ?? this.colorTextSecondary,
      colorTextTertiary: colorTextTertiary ?? this.colorTextTertiary,
      colorTextInverse: colorTextInverse ?? this.colorTextInverse,
      colorTextDisabled: colorTextDisabled ?? this.colorTextDisabled,
      colorTextLink: colorTextLink ?? this.colorTextLink,
      // Border
      colorBorderPrimary: colorBorderPrimary ?? this.colorBorderPrimary,
      colorBorderSecondary: colorBorderSecondary ?? this.colorBorderSecondary,
      colorBorderFocus: colorBorderFocus ?? this.colorBorderFocus,
      colorBorderError: colorBorderError ?? this.colorBorderError,
      // Icon
      colorIconPrimary: colorIconPrimary ?? this.colorIconPrimary,
      colorIconSecondary: colorIconSecondary ?? this.colorIconSecondary,
      colorIconInverse: colorIconInverse ?? this.colorIconInverse,
      colorIconDisabled: colorIconDisabled ?? this.colorIconDisabled,
      // Brand
      colorBrandPrimary: colorBrandPrimary ?? this.colorBrandPrimary,
      colorBrandSecondary: colorBrandSecondary ?? this.colorBrandSecondary,
      colorBrandPrimaryLight:
          colorBrandPrimaryLight ?? this.colorBrandPrimaryLight,
      colorBrandPrimaryDark:
          colorBrandPrimaryDark ?? this.colorBrandPrimaryDark,
      // Feedback
      colorFeedbackSuccess: colorFeedbackSuccess ?? this.colorFeedbackSuccess,
      colorFeedbackSuccessLight:
          colorFeedbackSuccessLight ?? this.colorFeedbackSuccessLight,
      colorFeedbackError: colorFeedbackError ?? this.colorFeedbackError,
      colorFeedbackErrorLight:
          colorFeedbackErrorLight ?? this.colorFeedbackErrorLight,
      colorFeedbackWarning: colorFeedbackWarning ?? this.colorFeedbackWarning,
      colorFeedbackWarningLight:
          colorFeedbackWarningLight ?? this.colorFeedbackWarningLight,
      colorFeedbackInfo: colorFeedbackInfo ?? this.colorFeedbackInfo,
      colorFeedbackInfoLight:
          colorFeedbackInfoLight ?? this.colorFeedbackInfoLight,
      // Button Primary
      buttonPrimaryBackground:
          buttonPrimaryBackground ?? this.buttonPrimaryBackground,
      buttonPrimaryBackgroundHover:
          buttonPrimaryBackgroundHover ?? this.buttonPrimaryBackgroundHover,
      buttonPrimaryBackgroundPressed:
          buttonPrimaryBackgroundPressed ?? this.buttonPrimaryBackgroundPressed,
      buttonPrimaryBackgroundDisabled:
          buttonPrimaryBackgroundDisabled ??
          this.buttonPrimaryBackgroundDisabled,
      buttonPrimaryText: buttonPrimaryText ?? this.buttonPrimaryText,
      buttonPrimaryTextDisabled:
          buttonPrimaryTextDisabled ?? this.buttonPrimaryTextDisabled,
      // Button Secondary
      buttonSecondaryBackground:
          buttonSecondaryBackground ?? this.buttonSecondaryBackground,
      buttonSecondaryBackgroundHover:
          buttonSecondaryBackgroundHover ?? this.buttonSecondaryBackgroundHover,
      buttonSecondaryBackgroundPressed:
          buttonSecondaryBackgroundPressed ??
          this.buttonSecondaryBackgroundPressed,
      buttonSecondaryBorder:
          buttonSecondaryBorder ?? this.buttonSecondaryBorder,
      buttonSecondaryText: buttonSecondaryText ?? this.buttonSecondaryText,
      buttonSecondaryTextDisabled:
          buttonSecondaryTextDisabled ?? this.buttonSecondaryTextDisabled,
      // Button Ghost
      buttonGhostBackground:
          buttonGhostBackground ?? this.buttonGhostBackground,
      buttonGhostBackgroundHover:
          buttonGhostBackgroundHover ?? this.buttonGhostBackgroundHover,
      buttonGhostBackgroundPressed:
          buttonGhostBackgroundPressed ?? this.buttonGhostBackgroundPressed,
      buttonGhostText: buttonGhostText ?? this.buttonGhostText,
      buttonGhostTextDisabled:
          buttonGhostTextDisabled ?? this.buttonGhostTextDisabled,
      // Button Danger
      buttonDangerBackground:
          buttonDangerBackground ?? this.buttonDangerBackground,
      buttonDangerBackgroundHover:
          buttonDangerBackgroundHover ?? this.buttonDangerBackgroundHover,
      buttonDangerBackgroundPressed:
          buttonDangerBackgroundPressed ?? this.buttonDangerBackgroundPressed,
      buttonDangerText: buttonDangerText ?? this.buttonDangerText,
      buttonDangerBackgroundDisabled:
          buttonDangerBackgroundDisabled ?? this.buttonDangerBackgroundDisabled,
      buttonDangerTextDisabled:
          buttonDangerTextDisabled ?? this.buttonDangerTextDisabled,
      // Card
      cardBackground: cardBackground ?? this.cardBackground,
      cardBackgroundHover: cardBackgroundHover ?? this.cardBackgroundHover,
      cardBorder: cardBorder ?? this.cardBorder,
      // Input
      inputBackground: inputBackground ?? this.inputBackground,
      inputBackgroundFocused:
          inputBackgroundFocused ?? this.inputBackgroundFocused,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBorderFocused: inputBorderFocused ?? this.inputBorderFocused,
      inputBorderError: inputBorderError ?? this.inputBorderError,
      inputText: inputText ?? this.inputText,
      inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
      // Chip
      chipBackground: chipBackground ?? this.chipBackground,
      chipBackgroundHover: chipBackgroundHover ?? this.chipBackgroundHover,
      chipBackgroundPressed:
          chipBackgroundPressed ?? this.chipBackgroundPressed,
      chipBackgroundSelected:
          chipBackgroundSelected ?? this.chipBackgroundSelected,
      chipText: chipText ?? this.chipText,
      chipTextSelected: chipTextSelected ?? this.chipTextSelected,
      chipBorder: chipBorder ?? this.chipBorder,
      // Badge
      badgeBackground: badgeBackground ?? this.badgeBackground,
      badgeText: badgeText ?? this.badgeText,
      // Typography
      typographyDisplayLarge:
          typographyDisplayLarge ?? this.typographyDisplayLarge,
      typographyDisplayMedium:
          typographyDisplayMedium ?? this.typographyDisplayMedium,
      typographyDisplaySmall:
          typographyDisplaySmall ?? this.typographyDisplaySmall,
      typographyHeadingLarge:
          typographyHeadingLarge ?? this.typographyHeadingLarge,
      typographyHeadingMedium:
          typographyHeadingMedium ?? this.typographyHeadingMedium,
      typographyHeadingSmall:
          typographyHeadingSmall ?? this.typographyHeadingSmall,
      typographyTitleLarge: typographyTitleLarge ?? this.typographyTitleLarge,
      typographyTitleMedium:
          typographyTitleMedium ?? this.typographyTitleMedium,
      typographyTitleSmall: typographyTitleSmall ?? this.typographyTitleSmall,
      typographyBodyLarge: typographyBodyLarge ?? this.typographyBodyLarge,
      typographyBodyMedium: typographyBodyMedium ?? this.typographyBodyMedium,
      typographyBodySmall: typographyBodySmall ?? this.typographyBodySmall,
      typographyLabelLarge: typographyLabelLarge ?? this.typographyLabelLarge,
      typographyLabelMedium:
          typographyLabelMedium ?? this.typographyLabelMedium,
      typographyLabelSmall: typographyLabelSmall ?? this.typographyLabelSmall,
      typographyCaption: typographyCaption ?? this.typographyCaption,
      typographyOverline: typographyOverline ?? this.typographyOverline,
      typographyButton: typographyButton ?? this.typographyButton,
      // Elevation
      elevationLevel1: elevationLevel1 ?? this.elevationLevel1,
      elevationLevel2: elevationLevel2 ?? this.elevationLevel2,
      elevationLevel3: elevationLevel3 ?? this.elevationLevel3,
      elevationLevel4: elevationLevel4 ?? this.elevationLevel4,
      elevationLevel5: elevationLevel5 ?? this.elevationLevel5,
    );

  /// Lerp helper for List<BoxShadow>.
  ///
  /// Interpolates each BoxShadow in the list for smooth theme transitions.
  static List<BoxShadow> _lerpBoxShadowList(
    List<BoxShadow> a,
    List<BoxShadow> b,
    double t,
  ) {
    // If lengths differ, use binary switch at t=0.5
    if (a.length != b.length) {
      return t < 0.5 ? a : b;
    }

    return [
      for (int i = 0; i < a.length; i++) BoxShadow.lerp(a[i], b[i], t)!,
    ];
  }

  @override
  DSThemeData lerp(covariant DSThemeData? other, double t) {
    if (other is! DSThemeData) return this;

    return DSThemeData(
      // Surface
      colorSurfacePrimary: Color.lerp(
        colorSurfacePrimary,
        other.colorSurfacePrimary,
        t,
      )!,
      colorSurfaceSecondary: Color.lerp(
        colorSurfaceSecondary,
        other.colorSurfaceSecondary,
        t,
      )!,
      colorSurfaceTertiary: Color.lerp(
        colorSurfaceTertiary,
        other.colorSurfaceTertiary,
        t,
      )!,
      colorSurfaceInverse: Color.lerp(
        colorSurfaceInverse,
        other.colorSurfaceInverse,
        t,
      )!,
      colorSurfaceOverlay: Color.lerp(
        colorSurfaceOverlay,
        other.colorSurfaceOverlay,
        t,
      )!,
      // Text
      colorTextPrimary: Color.lerp(
        colorTextPrimary,
        other.colorTextPrimary,
        t,
      )!,
      colorTextSecondary: Color.lerp(
        colorTextSecondary,
        other.colorTextSecondary,
        t,
      )!,
      colorTextTertiary: Color.lerp(
        colorTextTertiary,
        other.colorTextTertiary,
        t,
      )!,
      colorTextInverse: Color.lerp(
        colorTextInverse,
        other.colorTextInverse,
        t,
      )!,
      colorTextDisabled: Color.lerp(
        colorTextDisabled,
        other.colorTextDisabled,
        t,
      )!,
      colorTextLink: Color.lerp(colorTextLink, other.colorTextLink, t)!,
      // Border
      colorBorderPrimary: Color.lerp(
        colorBorderPrimary,
        other.colorBorderPrimary,
        t,
      )!,
      colorBorderSecondary: Color.lerp(
        colorBorderSecondary,
        other.colorBorderSecondary,
        t,
      )!,
      colorBorderFocus: Color.lerp(
        colorBorderFocus,
        other.colorBorderFocus,
        t,
      )!,
      colorBorderError: Color.lerp(
        colorBorderError,
        other.colorBorderError,
        t,
      )!,
      // Icon
      colorIconPrimary: Color.lerp(
        colorIconPrimary,
        other.colorIconPrimary,
        t,
      )!,
      colorIconSecondary: Color.lerp(
        colorIconSecondary,
        other.colorIconSecondary,
        t,
      )!,
      colorIconInverse: Color.lerp(
        colorIconInverse,
        other.colorIconInverse,
        t,
      )!,
      colorIconDisabled: Color.lerp(
        colorIconDisabled,
        other.colorIconDisabled,
        t,
      )!,
      // Brand
      colorBrandPrimary: Color.lerp(
        colorBrandPrimary,
        other.colorBrandPrimary,
        t,
      )!,
      colorBrandSecondary: Color.lerp(
        colorBrandSecondary,
        other.colorBrandSecondary,
        t,
      )!,
      colorBrandPrimaryLight: Color.lerp(
        colorBrandPrimaryLight,
        other.colorBrandPrimaryLight,
        t,
      )!,
      colorBrandPrimaryDark: Color.lerp(
        colorBrandPrimaryDark,
        other.colorBrandPrimaryDark,
        t,
      )!,
      // Feedback
      colorFeedbackSuccess: Color.lerp(
        colorFeedbackSuccess,
        other.colorFeedbackSuccess,
        t,
      )!,
      colorFeedbackSuccessLight: Color.lerp(
        colorFeedbackSuccessLight,
        other.colorFeedbackSuccessLight,
        t,
      )!,
      colorFeedbackError: Color.lerp(
        colorFeedbackError,
        other.colorFeedbackError,
        t,
      )!,
      colorFeedbackErrorLight: Color.lerp(
        colorFeedbackErrorLight,
        other.colorFeedbackErrorLight,
        t,
      )!,
      colorFeedbackWarning: Color.lerp(
        colorFeedbackWarning,
        other.colorFeedbackWarning,
        t,
      )!,
      colorFeedbackWarningLight: Color.lerp(
        colorFeedbackWarningLight,
        other.colorFeedbackWarningLight,
        t,
      )!,
      colorFeedbackInfo: Color.lerp(
        colorFeedbackInfo,
        other.colorFeedbackInfo,
        t,
      )!,
      colorFeedbackInfoLight: Color.lerp(
        colorFeedbackInfoLight,
        other.colorFeedbackInfoLight,
        t,
      )!,
      // Button Primary
      buttonPrimaryBackground: Color.lerp(
        buttonPrimaryBackground,
        other.buttonPrimaryBackground,
        t,
      )!,
      buttonPrimaryBackgroundHover: Color.lerp(
        buttonPrimaryBackgroundHover,
        other.buttonPrimaryBackgroundHover,
        t,
      )!,
      buttonPrimaryBackgroundPressed: Color.lerp(
        buttonPrimaryBackgroundPressed,
        other.buttonPrimaryBackgroundPressed,
        t,
      )!,
      buttonPrimaryBackgroundDisabled: Color.lerp(
        buttonPrimaryBackgroundDisabled,
        other.buttonPrimaryBackgroundDisabled,
        t,
      )!,
      buttonPrimaryText: Color.lerp(
        buttonPrimaryText,
        other.buttonPrimaryText,
        t,
      )!,
      buttonPrimaryTextDisabled: Color.lerp(
        buttonPrimaryTextDisabled,
        other.buttonPrimaryTextDisabled,
        t,
      )!,
      // Button Secondary
      buttonSecondaryBackground: Color.lerp(
        buttonSecondaryBackground,
        other.buttonSecondaryBackground,
        t,
      )!,
      buttonSecondaryBackgroundHover: Color.lerp(
        buttonSecondaryBackgroundHover,
        other.buttonSecondaryBackgroundHover,
        t,
      )!,
      buttonSecondaryBackgroundPressed: Color.lerp(
        buttonSecondaryBackgroundPressed,
        other.buttonSecondaryBackgroundPressed,
        t,
      )!,
      buttonSecondaryBorder: Color.lerp(
        buttonSecondaryBorder,
        other.buttonSecondaryBorder,
        t,
      )!,
      buttonSecondaryText: Color.lerp(
        buttonSecondaryText,
        other.buttonSecondaryText,
        t,
      )!,
      buttonSecondaryTextDisabled: Color.lerp(
        buttonSecondaryTextDisabled,
        other.buttonSecondaryTextDisabled,
        t,
      )!,
      // Button Ghost
      buttonGhostBackground: Color.lerp(
        buttonGhostBackground,
        other.buttonGhostBackground,
        t,
      )!,
      buttonGhostBackgroundHover: Color.lerp(
        buttonGhostBackgroundHover,
        other.buttonGhostBackgroundHover,
        t,
      )!,
      buttonGhostBackgroundPressed: Color.lerp(
        buttonGhostBackgroundPressed,
        other.buttonGhostBackgroundPressed,
        t,
      )!,
      buttonGhostText: Color.lerp(buttonGhostText, other.buttonGhostText, t)!,
      buttonGhostTextDisabled: Color.lerp(
        buttonGhostTextDisabled,
        other.buttonGhostTextDisabled,
        t,
      )!,
      // Button Danger
      buttonDangerBackground: Color.lerp(
        buttonDangerBackground,
        other.buttonDangerBackground,
        t,
      )!,
      buttonDangerBackgroundHover: Color.lerp(
        buttonDangerBackgroundHover,
        other.buttonDangerBackgroundHover,
        t,
      )!,
      buttonDangerBackgroundPressed: Color.lerp(
        buttonDangerBackgroundPressed,
        other.buttonDangerBackgroundPressed,
        t,
      )!,
      buttonDangerText: Color.lerp(
        buttonDangerText,
        other.buttonDangerText,
        t,
      )!,
      buttonDangerBackgroundDisabled: Color.lerp(
        buttonDangerBackgroundDisabled,
        other.buttonDangerBackgroundDisabled,
        t,
      )!,
      buttonDangerTextDisabled: Color.lerp(
        buttonDangerTextDisabled,
        other.buttonDangerTextDisabled,
        t,
      )!,
      // Card
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBackgroundHover: Color.lerp(
        cardBackgroundHover,
        other.cardBackgroundHover,
        t,
      )!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      // Input
      inputBackground: Color.lerp(inputBackground, other.inputBackground, t)!,
      inputBackgroundFocused: Color.lerp(
        inputBackgroundFocused,
        other.inputBackgroundFocused,
        t,
      )!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputBorderFocused: Color.lerp(
        inputBorderFocused,
        other.inputBorderFocused,
        t,
      )!,
      inputBorderError: Color.lerp(
        inputBorderError,
        other.inputBorderError,
        t,
      )!,
      inputText: Color.lerp(inputText, other.inputText, t)!,
      inputPlaceholder: Color.lerp(
        inputPlaceholder,
        other.inputPlaceholder,
        t,
      )!,
      // Chip
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      chipBackgroundHover: Color.lerp(
        chipBackgroundHover,
        other.chipBackgroundHover,
        t,
      )!,
      chipBackgroundPressed: Color.lerp(
        chipBackgroundPressed,
        other.chipBackgroundPressed,
        t,
      )!,
      chipBackgroundSelected: Color.lerp(
        chipBackgroundSelected,
        other.chipBackgroundSelected,
        t,
      )!,
      chipText: Color.lerp(chipText, other.chipText, t)!,
      chipTextSelected: Color.lerp(
        chipTextSelected,
        other.chipTextSelected,
        t,
      )!,
      chipBorder: Color.lerp(chipBorder, other.chipBorder, t)!,
      // Badge
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t)!,
      badgeText: Color.lerp(badgeText, other.badgeText, t)!,
      // Typography (no lerp needed for TextStyle in most cases)
      typographyDisplayLarge: TextStyle.lerp(
        typographyDisplayLarge,
        other.typographyDisplayLarge,
        t,
      )!,
      typographyDisplayMedium: TextStyle.lerp(
        typographyDisplayMedium,
        other.typographyDisplayMedium,
        t,
      )!,
      typographyDisplaySmall: TextStyle.lerp(
        typographyDisplaySmall,
        other.typographyDisplaySmall,
        t,
      )!,
      typographyHeadingLarge: TextStyle.lerp(
        typographyHeadingLarge,
        other.typographyHeadingLarge,
        t,
      )!,
      typographyHeadingMedium: TextStyle.lerp(
        typographyHeadingMedium,
        other.typographyHeadingMedium,
        t,
      )!,
      typographyHeadingSmall: TextStyle.lerp(
        typographyHeadingSmall,
        other.typographyHeadingSmall,
        t,
      )!,
      typographyTitleLarge: TextStyle.lerp(
        typographyTitleLarge,
        other.typographyTitleLarge,
        t,
      )!,
      typographyTitleMedium: TextStyle.lerp(
        typographyTitleMedium,
        other.typographyTitleMedium,
        t,
      )!,
      typographyTitleSmall: TextStyle.lerp(
        typographyTitleSmall,
        other.typographyTitleSmall,
        t,
      )!,
      typographyBodyLarge: TextStyle.lerp(
        typographyBodyLarge,
        other.typographyBodyLarge,
        t,
      )!,
      typographyBodyMedium: TextStyle.lerp(
        typographyBodyMedium,
        other.typographyBodyMedium,
        t,
      )!,
      typographyBodySmall: TextStyle.lerp(
        typographyBodySmall,
        other.typographyBodySmall,
        t,
      )!,
      typographyLabelLarge: TextStyle.lerp(
        typographyLabelLarge,
        other.typographyLabelLarge,
        t,
      )!,
      typographyLabelMedium: TextStyle.lerp(
        typographyLabelMedium,
        other.typographyLabelMedium,
        t,
      )!,
      typographyLabelSmall: TextStyle.lerp(
        typographyLabelSmall,
        other.typographyLabelSmall,
        t,
      )!,
      typographyCaption: TextStyle.lerp(
        typographyCaption,
        other.typographyCaption,
        t,
      )!,
      typographyOverline: TextStyle.lerp(
        typographyOverline,
        other.typographyOverline,
        t,
      )!,
      typographyButton: TextStyle.lerp(
        typographyButton,
        other.typographyButton,
        t,
      )!,
      // Elevation (interpolate BoxShadow properties)
      elevationLevel1: _lerpBoxShadowList(
        elevationLevel1,
        other.elevationLevel1,
        t,
      ),
      elevationLevel2: _lerpBoxShadowList(
        elevationLevel2,
        other.elevationLevel2,
        t,
      ),
      elevationLevel3: _lerpBoxShadowList(
        elevationLevel3,
        other.elevationLevel3,
        t,
      ),
      elevationLevel4: _lerpBoxShadowList(
        elevationLevel4,
        other.elevationLevel4,
        t,
      ),
      elevationLevel5: _lerpBoxShadowList(
        elevationLevel5,
        other.elevationLevel5,
        t,
      ),
    );
  }
}
