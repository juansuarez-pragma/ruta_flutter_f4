import 'package:flutter/material.dart';

/// Tokens de border radius del sistema de diseño.
///
/// ## Uso
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(DSBorderRadius.md),
///   ),
/// )
/// ```
abstract final class DSBorderRadius {
  /// 0px - Sin redondeo
  static const double none = 0;

  /// 2px - Extra pequeño
  static const double xs = 2;

  /// 4px - Pequeño
  static const double sm = 4;

  /// 8px - Medio
  static const double md = 8;

  /// 12px - Base
  static const double base = 12;

  /// 16px - Grande
  static const double lg = 16;

  /// 20px - Extra grande
  static const double xl = 20;

  /// 24px - Extra extra grande
  static const double xxl = 24;

  /// 28px - Jumbo
  static const double xxxl = 28;

  /// 9999px - Circular/Pill
  static const double full = 9999;

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Crea un BorderRadius circular con el valor especificado.
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);

  /// BorderRadius none (0px)
  static BorderRadius get noneRadius => BorderRadius.zero;

  /// BorderRadius extra pequeño (2px)
  static BorderRadius get xsRadius => BorderRadius.circular(xs);

  /// BorderRadius pequeño (4px)
  static BorderRadius get smRadius => BorderRadius.circular(sm);

  /// BorderRadius medio (8px)
  static BorderRadius get mdRadius => BorderRadius.circular(md);

  /// BorderRadius base (12px)
  static BorderRadius get baseRadius => BorderRadius.circular(base);

  /// BorderRadius grande (16px)
  static BorderRadius get lgRadius => BorderRadius.circular(lg);

  /// BorderRadius extra grande (20px)
  static BorderRadius get xlRadius => BorderRadius.circular(xl);

  /// BorderRadius extra extra grande (24px)
  static BorderRadius get xxlRadius => BorderRadius.circular(xxl);

  /// BorderRadius jumbo (28px)
  static BorderRadius get xxxlRadius => BorderRadius.circular(xxxl);

  /// BorderRadius circular/pill (9999px)
  static BorderRadius get fullRadius => BorderRadius.circular(full);
}
