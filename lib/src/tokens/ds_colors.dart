import 'package:flutter/material.dart';

/// Tokens de colores primitivos del sistema de diseño.
///
/// Esta clase contiene todos los valores de color raw que sirven como
/// base para los tokens semánticos definidos en el tema.
///
/// ## Uso
///
/// Los colores primitivos no deben usarse directamente en los widgets.
/// En su lugar, usa los tokens semánticos disponibles vía `context.tokens`.
///
/// ```dart
/// // ❌ Incorrecto - No usar directamente
/// Container(color: DSColors.primary500)
///
/// // ✅ Correcto - Usar tokens del tema
/// Container(color: context.tokens.colorBrandPrimary)
/// ```
abstract final class DSColors {
  // ============================================
  // PRIMARY PALETTE (Purple)
  // ============================================

  /// Primary 50 - Más claro
  static const Color primary50 = Color(0xFFF3E5F5);

  /// Primary 100
  static const Color primary100 = Color(0xFFE1BEE7);

  /// Primary 200
  static const Color primary200 = Color(0xFFCE93D8);

  /// Primary 300
  static const Color primary300 = Color(0xFFBA68C8);

  /// Primary 400
  static const Color primary400 = Color(0xFF9C27B0);

  /// Primary 500 - Base
  static const Color primary500 = Color(0xFF6200EE);

  /// Primary 600
  static const Color primary600 = Color(0xFF5600D9);

  /// Primary 700
  static const Color primary700 = Color(0xFF4A00C4);

  /// Primary 800
  static const Color primary800 = Color(0xFF3E00AF);

  /// Primary 900 - Más oscuro
  static const Color primary900 = Color(0xFF32009A);

  // ============================================
  // SECONDARY PALETTE (Teal)
  // ============================================

  /// Secondary 50 - Más claro
  static const Color secondary50 = Color(0xFFE0F2F1);

  /// Secondary 100
  static const Color secondary100 = Color(0xFFB2DFDB);

  /// Secondary 200
  static const Color secondary200 = Color(0xFF80CBC4);

  /// Secondary 300
  static const Color secondary300 = Color(0xFF4DB6AC);

  /// Secondary 400
  static const Color secondary400 = Color(0xFF26A69A);

  /// Secondary 500 - Base
  static const Color secondary500 = Color(0xFF03DAC6);

  /// Secondary 600
  static const Color secondary600 = Color(0xFF00C4B4);

  /// Secondary 700
  static const Color secondary700 = Color(0xFF00AEA2);

  /// Secondary 800
  static const Color secondary800 = Color(0xFF009890);

  /// Secondary 900 - Más oscuro
  static const Color secondary900 = Color(0xFF00827E);

  // ============================================
  // NEUTRAL PALETTE (Gray)
  // ============================================

  /// Neutral 50 - Casi blanco
  static const Color neutral50 = Color(0xFFFAFAFA);

  /// Neutral 100
  static const Color neutral100 = Color(0xFFF5F5F5);

  /// Neutral 200
  static const Color neutral200 = Color(0xFFEEEEEE);

  /// Neutral 300
  static const Color neutral300 = Color(0xFFE0E0E0);

  /// Neutral 400
  static const Color neutral400 = Color(0xFFBDBDBD);

  /// Neutral 500
  static const Color neutral500 = Color(0xFF9E9E9E);

  /// Neutral 600
  static const Color neutral600 = Color(0xFF757575);

  /// Neutral 700
  static const Color neutral700 = Color(0xFF616161);

  /// Neutral 800
  static const Color neutral800 = Color(0xFF424242);

  /// Neutral 900
  static const Color neutral900 = Color(0xFF212121);

  /// Neutral 1000 - Casi negro
  static const Color neutral1000 = Color(0xFF121212);

  // ============================================
  // SUCCESS PALETTE (Green)
  // ============================================

  /// Success 50 - Más claro
  static const Color success50 = Color(0xFFE8F5E9);

  /// Success 100
  static const Color success100 = Color(0xFFC8E6C9);

  /// Success 200
  static const Color success200 = Color(0xFFA5D6A7);

  /// Success 300
  static const Color success300 = Color(0xFF81C784);

  /// Success 400
  static const Color success400 = Color(0xFF66BB6A);

  /// Success 500 - Base
  static const Color success500 = Color(0xFF4CAF50);

  /// Success 600
  static const Color success600 = Color(0xFF43A047);

  /// Success 700
  static const Color success700 = Color(0xFF388E3C);

  /// Success 800
  static const Color success800 = Color(0xFF2E7D32);

  /// Success 900 - Más oscuro
  static const Color success900 = Color(0xFF1B5E20);

  // ============================================
  // ERROR PALETTE (Red)
  // ============================================

  /// Error 50 - Más claro
  static const Color error50 = Color(0xFFFFEBEE);

  /// Error 100
  static const Color error100 = Color(0xFFFFCDD2);

  /// Error 200
  static const Color error200 = Color(0xFFEF9A9A);

  /// Error 300
  static const Color error300 = Color(0xFFE57373);

  /// Error 400
  static const Color error400 = Color(0xFFEF5350);

  /// Error 500 - Base
  static const Color error500 = Color(0xFFB00020);

  /// Error 600
  static const Color error600 = Color(0xFFE53935);

  /// Error 700
  static const Color error700 = Color(0xFFC62828);

  /// Error 800
  static const Color error800 = Color(0xFFB71C1C);

  /// Error 900 - Más oscuro
  static const Color error900 = Color(0xFF8B0000);

  // ============================================
  // WARNING PALETTE (Amber)
  // ============================================

  /// Warning 50 - Más claro
  static const Color warning50 = Color(0xFFFFF8E1);

  /// Warning 100
  static const Color warning100 = Color(0xFFFFECB3);

  /// Warning 200
  static const Color warning200 = Color(0xFFFFE082);

  /// Warning 300
  static const Color warning300 = Color(0xFFFFD54F);

  /// Warning 400
  static const Color warning400 = Color(0xFFFFCA28);

  /// Warning 500 - Base
  static const Color warning500 = Color(0xFFFFC107);

  /// Warning 600
  static const Color warning600 = Color(0xFFFFB300);

  /// Warning 700
  static const Color warning700 = Color(0xFFFFA000);

  /// Warning 800
  static const Color warning800 = Color(0xFFFF8F00);

  /// Warning 900 - Más oscuro
  static const Color warning900 = Color(0xFFFF6F00);

  // ============================================
  // INFO PALETTE (Blue)
  // ============================================

  /// Info 50 - Más claro
  static const Color info50 = Color(0xFFE3F2FD);

  /// Info 100
  static const Color info100 = Color(0xFFBBDEFB);

  /// Info 200
  static const Color info200 = Color(0xFF90CAF9);

  /// Info 300
  static const Color info300 = Color(0xFF64B5F6);

  /// Info 400
  static const Color info400 = Color(0xFF42A5F5);

  /// Info 500 - Base
  static const Color info500 = Color(0xFF2196F3);

  /// Info 600
  static const Color info600 = Color(0xFF1E88E5);

  /// Info 700
  static const Color info700 = Color(0xFF1976D2);

  /// Info 800
  static const Color info800 = Color(0xFF1565C0);

  /// Info 900 - Más oscuro
  static const Color info900 = Color(0xFF0D47A1);

  // ============================================
  // SPECIAL COLORS
  // ============================================

  /// Blanco puro
  static const Color white = Color(0xFFFFFFFF);

  /// Negro puro
  static const Color black = Color(0xFF000000);

  /// Transparente
  static const Color transparent = Color(0x00000000);

  // ============================================
  // ALPHA VARIANTS
  // ============================================

  /// Negro con 4% de opacidad
  static const Color blackAlpha4 = Color(0x0A000000);

  /// Negro con 8% de opacidad
  static const Color blackAlpha8 = Color(0x14000000);

  /// Negro con 12% de opacidad
  static const Color blackAlpha12 = Color(0x1F000000);

  /// Negro con 16% de opacidad
  static const Color blackAlpha16 = Color(0x29000000);

  /// Negro con 24% de opacidad
  static const Color blackAlpha24 = Color(0x3D000000);

  /// Negro con 32% de opacidad
  static const Color blackAlpha32 = Color(0x52000000);

  /// Negro con 48% de opacidad
  static const Color blackAlpha48 = Color(0x7A000000);

  /// Negro con 64% de opacidad
  static const Color blackAlpha64 = Color(0xA3000000);

  /// Blanco con 8% de opacidad
  static const Color whiteAlpha8 = Color(0x14FFFFFF);

  /// Blanco con 16% de opacidad
  static const Color whiteAlpha16 = Color(0x29FFFFFF);

  /// Blanco con 24% de opacidad
  static const Color whiteAlpha24 = Color(0x3DFFFFFF);

  /// Blanco con 48% de opacidad
  static const Color whiteAlpha48 = Color(0x7AFFFFFF);

  /// Blanco con 64% de opacidad
  static const Color whiteAlpha64 = Color(0xA3FFFFFF);

  /// Blanco con 80% de opacidad
  static const Color whiteAlpha80 = Color(0xCCFFFFFF);
}
