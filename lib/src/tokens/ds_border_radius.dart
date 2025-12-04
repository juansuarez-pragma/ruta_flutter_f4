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
}
