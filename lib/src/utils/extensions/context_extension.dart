import 'package:fake_store_design_system/src/foundations/theme/ds_theme_data.dart';
import 'package:fake_store_design_system/src/foundations/theme/fake_store_theme.dart';
import 'package:flutter/material.dart';

/// Extensión de BuildContext para acceder fácilmente a los tokens del tema.
///
/// Proporciona una API simplificada para acceder a los tokens del sistema
/// de diseño desde cualquier widget.
///
/// ## Uso
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Container(
///     color: context.tokens.colorSurfacePrimary,
///     padding: EdgeInsets.all(DSSpacing.base),
///     child: Text(
///       'Hello World',
///       style: context.tokens.typographyBodyMedium,
///     ),
///   );
/// }
/// ```
extension DSContextExtension on BuildContext {
  /// Obtiene los tokens del sistema de diseño.
  ///
  /// Lanza una excepción si el tema no está configurado correctamente.
  DSThemeData get tokens => FakeStoreTheme.of(this);

  /// Indica si el tema actual es oscuro.
  ///
  /// ```dart
  /// if (context.isDarkMode) {
  ///   // Lógica específica para modo oscuro
  /// }
  /// ```
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Indica si el tema actual es claro.
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Obtiene el MediaQuery del contexto actual.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Obtiene el ancho de la pantalla.
  double get screenWidth => mediaQuery.size.width;

  /// Obtiene el alto de la pantalla.
  double get screenHeight => mediaQuery.size.height;

  /// Indica si el dispositivo es considerado móvil (ancho < 600).
  bool get isMobile => screenWidth < 600;

  /// Indica si el dispositivo es considerado tablet (600 <= ancho < 1024).
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;

  /// Indica si el dispositivo es considerado desktop (ancho >= 1024).
  bool get isDesktop => screenWidth >= 1024;
}
