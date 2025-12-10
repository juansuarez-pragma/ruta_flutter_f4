import 'package:flutter/material.dart';

/// Familias de fuentes del sistema de diseño.
abstract final class DSFontFamily {
  /// Fuente para displays y headings
  static const String display = 'Roboto';

  /// Fuente para cuerpo de texto
  static const String body = 'Roboto';

  /// Fuente monoespaciada para código
  static const String mono = 'RobotoMono';
}

/// Pesos de fuente del sistema de diseño.
abstract final class DSFontWeight {
  /// Light - 300
  static const FontWeight light = FontWeight.w300;

  /// Regular - 400
  static const FontWeight regular = FontWeight.w400;

  /// Medium - 500
  static const FontWeight medium = FontWeight.w500;

  /// SemiBold - 600
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold - 700
  static const FontWeight bold = FontWeight.w700;

  /// Extra Bold - 800
  static const FontWeight extraBold = FontWeight.w800;
}

/// Tamaños de fuente del sistema de diseño.
///
/// Escala tipográfica basada en Material Design 3.
abstract final class DSFontSize {
  // ============================================
  // DISPLAY
  // ============================================

  /// Display Large - 57px
  static const double displayLarge = 57;

  /// Display Medium - 45px
  static const double displayMedium = 45;

  /// Display Small - 36px
  static const double displaySmall = 36;

  // ============================================
  // HEADING
  // ============================================

  /// Heading Large - 32px
  static const double headingLarge = 32;

  /// Heading Medium - 28px
  static const double headingMedium = 28;

  /// Heading Small - 24px
  static const double headingSmall = 24;

  // ============================================
  // TITLE
  // ============================================

  /// Title Large - 22px
  static const double titleLarge = 22;

  /// Title Medium - 16px
  static const double titleMedium = 16;

  /// Title Small - 14px
  static const double titleSmall = 14;

  // ============================================
  // BODY
  // ============================================

  /// Body Large - 16px
  static const double bodyLarge = 16;

  /// Body Medium - 14px
  static const double bodyMedium = 14;

  /// Body Small - 12px
  static const double bodySmall = 12;

  // ============================================
  // LABEL
  // ============================================

  /// Label Large - 14px
  static const double labelLarge = 14;

  /// Label Medium - 12px
  static const double labelMedium = 12;

  /// Label Small - 11px
  static const double labelSmall = 11;

  // ============================================
  // UTILITY
  // ============================================

  /// Caption - 12px
  static const double caption = 12;

  /// Overline - 10px
  static const double overline = 10;
}

/// Alturas de línea del sistema de diseño.
abstract final class DSLineHeight {
  /// Tight - 1.0
  static const double tight = 1;

  /// Snug - 1.2
  static const double snug = 1.2;

  /// Normal - 1.5 (Base)
  static const double normal = 1.5;

  /// Relaxed - 1.625
  static const double relaxed = 1.625;

  /// Loose - 1.75
  static const double loose = 1.75;

  /// Extra Loose - 2.0
  static const double extraLoose = 2;
}

/// Espaciado de letras del sistema de diseño.
abstract final class DSLetterSpacing {
  /// Tighter - -0.05em
  static const double tighter = -0.8;

  /// Tight - -0.025em
  static const double tight = -0.4;

  /// Normal - 0
  static const double normal = 0;

  /// Wide - 0.025em
  static const double wide = 0.4;

  /// Wider - 0.05em
  static const double wider = 0.8;

  /// Widest - 0.1em
  static const double widest = 1.6;
}
