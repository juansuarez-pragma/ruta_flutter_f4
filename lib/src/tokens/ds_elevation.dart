import 'package:flutter/material.dart';

/// Tokens de elevación (sombras) del sistema de diseño.
///
/// Las elevaciones siguen las guías de Material Design 3 para
/// proporcionar profundidad y jerarquía visual consistente.
///
/// ## Uso
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: DSElevation.level2,
///     borderRadius: BorderRadius.circular(12),
///   ),
/// )
/// ```
abstract final class DSElevation {
  /// Sin elevación
  static const List<BoxShadow> none = [];

  /// Elevación nivel 1 (sutil)
  ///
  /// Uso: Cards en reposo, elementos sutiles
  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];

  /// Elevación nivel 2 (media-baja)
  ///
  /// Uso: Cards hover, botones elevados, chips
  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  /// Elevación nivel 3 (media)
  ///
  /// Uso: Dropdowns, menús, tooltips
  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x1F000000), // 12% opacity
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  /// Elevación nivel 4 (media-alta)
  ///
  /// Uso: Modales pequeños, snackbars
  static const List<BoxShadow> level4 = [
    BoxShadow(
      color: Color(0x26000000), // 15% opacity
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0D000000), // 5% opacity
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  /// Elevación nivel 5 (alta)
  ///
  /// Uso: Diálogos, modales, navigation drawers
  static const List<BoxShadow> level5 = [
    BoxShadow(
      color: Color(0x33000000), // 20% opacity
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color(0x14000000), // 8% opacity
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  // ============================================
  // DARK MODE VARIANTS
  // ============================================

  /// Elevación nivel 1 para modo oscuro
  static const List<BoxShadow> level1Dark = [
    BoxShadow(
      color: Color(0x40000000), // 25% opacity
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  /// Elevación nivel 2 para modo oscuro
  static const List<BoxShadow> level2Dark = [
    BoxShadow(
      color: Color(0x4D000000), // 30% opacity
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  /// Elevación nivel 3 para modo oscuro
  static const List<BoxShadow> level3Dark = [
    BoxShadow(
      color: Color(0x59000000), // 35% opacity
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Elevación nivel 4 para modo oscuro
  static const List<BoxShadow> level4Dark = [
    BoxShadow(
      color: Color(0x66000000), // 40% opacity
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  /// Elevación nivel 5 para modo oscuro
  static const List<BoxShadow> level5Dark = [
    BoxShadow(
      color: Color(0x73000000), // 45% opacity
      blurRadius: 28,
      offset: Offset(0, 12),
    ),
  ];
}
