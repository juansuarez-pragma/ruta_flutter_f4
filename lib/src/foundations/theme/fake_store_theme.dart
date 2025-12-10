import 'package:fake_store_design_system/src/foundations/theme/ds_theme_dark.dart';
import 'package:fake_store_design_system/src/foundations/theme/ds_theme_data.dart';
import 'package:fake_store_design_system/src/foundations/theme/ds_theme_light.dart';
import 'package:flutter/material.dart';

/// Configuración principal del tema del sistema de diseño Fake Store.
///
/// Proporciona acceso a los temas claro y oscuro, así como métodos
/// utilitarios para acceder a los tokens desde cualquier widget.
///
/// ## Uso básico
///
/// ```dart
/// MaterialApp(
///   theme: FakeStoreTheme.light(),
///   darkTheme: FakeStoreTheme.dark(),
///   themeMode: ThemeMode.system,
///   home: MyApp(),
/// )
/// ```
///
/// ## Acceso a tokens
///
/// ```dart
/// // Usando la extensión de contexto (recomendado)
/// final tokens = context.tokens;
/// Container(color: tokens.colorBrandPrimary);
///
/// // Usando el método estático
/// final tokens = FakeStoreTheme.of(context);
/// Container(color: tokens.colorBrandPrimary);
/// ```
abstract final class FakeStoreTheme {
  /// Obtiene el ThemeData para el tema claro.
  ///
  /// Incluye todos los tokens del sistema de diseño configurados
  /// para el modo claro.
  static ThemeData light() => DSThemeLight.themeData;

  /// Obtiene el ThemeData para el tema oscuro.
  ///
  /// Incluye todos los tokens del sistema de diseño configurados
  /// para el modo oscuro.
  static ThemeData dark() => DSThemeDark.themeData;

  /// Obtiene los tokens del sistema de diseño desde el contexto.
  ///
  /// Lanza [FlutterError] si el tema no está configurado correctamente.
  ///
  /// ```dart
  /// final tokens = FakeStoreTheme.of(context);
  /// Container(color: tokens.colorBrandPrimary);
  /// ```
  static DSThemeData of(BuildContext context) {
    final themeData = Theme.of(context).extension<DSThemeData>();
    if (themeData == null) {
      throw FlutterError.fromParts([
        ErrorSummary('DSThemeData not found in context.'),
        ErrorDescription(
          'No DSThemeData was found in the widget tree. '
          'This usually means FakeStoreTheme.light() or FakeStoreTheme.dark() '
          'is not set as the theme in MaterialApp.',
        ),
        ErrorHint(
          'Ensure your MaterialApp is configured like this:\n'
          '  MaterialApp(\n'
          '    theme: FakeStoreTheme.light(),\n'
          '    darkTheme: FakeStoreTheme.dark(),\n'
          '  )',
        ),
      ]);
    }
    return themeData;
  }

  /// Intenta obtener los tokens del sistema de diseño desde el contexto.
  ///
  /// Retorna null si el tema no está configurado.
  static DSThemeData? maybeOf(BuildContext context) => Theme.of(context).extension<DSThemeData>();

  /// Obtiene solo los datos del tema claro (sin ThemeData completo).
  static DSThemeData get lightData => DSThemeLight.data;

  /// Obtiene solo los datos del tema oscuro (sin ThemeData completo).
  static DSThemeData get darkData => DSThemeDark.data;
}
