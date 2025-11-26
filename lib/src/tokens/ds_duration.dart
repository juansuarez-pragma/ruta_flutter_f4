import 'package:flutter/material.dart';

/// Tokens de duración para animaciones del sistema de diseño.
///
/// ## Uso
///
/// ```dart
/// AnimatedContainer(
///   duration: DSDuration.normal,
///   curve: DSCurves.standard,
///   // ...
/// )
/// ```
abstract final class DSDuration {
  /// 0ms - Sin animación
  static const Duration none = Duration.zero;

  /// 50ms - Instantáneo
  static const Duration instant = Duration(milliseconds: 50);

  /// 100ms - Ultra rápido
  static const Duration ultraFast = Duration(milliseconds: 100);

  /// 150ms - Rápido
  static const Duration fast = Duration(milliseconds: 150);

  /// 200ms - Normal (Base)
  static const Duration normal = Duration(milliseconds: 200);

  /// 250ms - Medio-Rápido
  static const Duration mediumFast = Duration(milliseconds: 250);

  /// 300ms - Medio
  static const Duration medium = Duration(milliseconds: 300);

  /// 400ms - Lento
  static const Duration slow = Duration(milliseconds: 400);

  /// 500ms - Muy lento
  static const Duration slower = Duration(milliseconds: 500);

  /// 600ms - Extra lento
  static const Duration extraSlow = Duration(milliseconds: 600);

  /// 1000ms - Largo
  static const Duration long = Duration(milliseconds: 1000);
}

/// Curvas de animación del sistema de diseño.
///
/// Basadas en las curvas de Material Design 3.
abstract final class DSCurves {
  /// Curva estándar para la mayoría de animaciones
  static const Curve standard = Curves.easeInOut;

  /// Curva estándar acelerada
  static const Curve standardAccelerate = Curves.easeIn;

  /// Curva estándar desacelerada
  static const Curve standardDecelerate = Curves.easeOut;

  /// Curva para elementos que entran en pantalla
  static const Curve enter = Curves.easeOut;

  /// Curva para elementos que salen de pantalla
  static const Curve exit = Curves.easeIn;

  /// Curva enfatizada para animaciones importantes
  static const Curve emphasized = Curves.easeInOutCubic;

  /// Curva enfatizada acelerada
  static const Curve emphasizedAccelerate = Curves.easeInCubic;

  /// Curva enfatizada desacelerada
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;

  /// Curva lineal (sin aceleración)
  static const Curve linear = Curves.linear;

  /// Curva elástica para efectos bouncy
  static const Curve elastic = Curves.elasticOut;

  /// Curva bounce para efectos de rebote
  static const Curve bounce = Curves.bounceOut;
}
