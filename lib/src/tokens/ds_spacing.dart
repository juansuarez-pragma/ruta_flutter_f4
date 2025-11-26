/// Tokens de espaciado del sistema de diseño.
///
/// Sistema basado en una escala de 4px para consistencia visual.
///
/// ## Uso
///
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(DSSpacing.md),
///   child: Column(
///     children: [
///       Text('Título'),
///       SizedBox(height: DSSpacing.sm),
///       Text('Descripción'),
///     ],
///   ),
/// )
/// ```
abstract final class DSSpacing {
  /// 0px - Sin espacio
  static const double none = 0;

  /// 2px - Extra extra pequeño
  static const double xxs = 2;

  /// 4px - Extra pequeño
  static const double xs = 4;

  /// 8px - Pequeño
  static const double sm = 8;

  /// 12px - Pequeño-Medio
  static const double md = 12;

  /// 16px - Medio (Base)
  static const double base = 16;

  /// 20px - Medio-Grande
  static const double lg = 20;

  /// 24px - Grande
  static const double xl = 24;

  /// 32px - Extra grande
  static const double xxl = 32;

  /// 40px - Extra extra grande
  static const double xxxl = 40;

  /// 48px - Jumbo
  static const double jumbo = 48;

  /// 56px - Jumbo grande
  static const double jumboLg = 56;

  /// 64px - Mega
  static const double mega = 64;

  /// 80px - Giga
  static const double giga = 80;

  /// 96px - Tera
  static const double tera = 96;

  /// 120px - Ultra
  static const double ultra = 120;
}
