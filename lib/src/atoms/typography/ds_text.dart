import 'package:flutter/material.dart';

import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';

/// Componente de texto del sistema de diseño.
///
/// Proporciona acceso simplificado a los estilos tipográficos predefinidos.
///
/// ## Uso básico
///
/// ```dart
/// DSText(
///   'Bienvenido',
///   variant: DSTextVariant.headingLarge,
/// )
/// ```
///
/// ## Con color personalizado
///
/// ```dart
/// DSText(
///   'Precio: \$99.99',
///   variant: DSTextVariant.titleLarge,
///   color: context.tokens.colorBrandPrimary,
/// )
/// ```
class DSText extends StatelessWidget {
  /// El texto a mostrar.
  final String text;

  /// La variante tipográfica a usar.
  final DSTextVariant variant;

  /// Color opcional del texto.
  ///
  /// Si no se especifica, se usa el color de la variante.
  final Color? color;

  /// Alineación del texto.
  final TextAlign? textAlign;

  /// Número máximo de líneas.
  final int? maxLines;

  /// Comportamiento cuando el texto excede maxLines.
  final TextOverflow? overflow;

  /// Si el texto debe ser seleccionable.
  final bool selectable;

  const DSText(
    this.text, {
    super.key,
    this.variant = DSTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  });

  /// Crea un texto de display grande.
  const DSText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.displayLarge;

  /// Crea un texto de heading grande.
  const DSText.headingLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.headingLarge;

  /// Crea un texto de heading mediano.
  const DSText.headingMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.headingMedium;

  /// Crea un texto de heading pequeño.
  const DSText.headingSmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.headingSmall;

  /// Crea un texto de título grande.
  const DSText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.titleLarge;

  /// Crea un texto de título mediano.
  const DSText.titleMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.titleMedium;

  /// Crea un texto de cuerpo grande.
  const DSText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.bodyLarge;

  /// Crea un texto de cuerpo mediano.
  const DSText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.bodyMedium;

  /// Crea un texto de cuerpo pequeño.
  const DSText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.bodySmall;

  /// Crea un caption.
  const DSText.caption(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.caption;

  /// Crea un label.
  const DSText.label(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
  }) : variant = DSTextVariant.labelMedium;

  TextStyle _getStyle(BuildContext context) {
    final tokens = context.tokens;

    switch (variant) {
      case DSTextVariant.displayLarge:
        return tokens.typographyDisplayLarge;
      case DSTextVariant.displayMedium:
        return tokens.typographyDisplayMedium;
      case DSTextVariant.displaySmall:
        return tokens.typographyDisplaySmall;
      case DSTextVariant.headingLarge:
        return tokens.typographyHeadingLarge;
      case DSTextVariant.headingMedium:
        return tokens.typographyHeadingMedium;
      case DSTextVariant.headingSmall:
        return tokens.typographyHeadingSmall;
      case DSTextVariant.titleLarge:
        return tokens.typographyTitleLarge;
      case DSTextVariant.titleMedium:
        return tokens.typographyTitleMedium;
      case DSTextVariant.titleSmall:
        return tokens.typographyTitleSmall;
      case DSTextVariant.bodyLarge:
        return tokens.typographyBodyLarge;
      case DSTextVariant.bodyMedium:
        return tokens.typographyBodyMedium;
      case DSTextVariant.bodySmall:
        return tokens.typographyBodySmall;
      case DSTextVariant.labelLarge:
        return tokens.typographyLabelLarge;
      case DSTextVariant.labelMedium:
        return tokens.typographyLabelMedium;
      case DSTextVariant.labelSmall:
        return tokens.typographyLabelSmall;
      case DSTextVariant.caption:
        return tokens.typographyCaption;
      case DSTextVariant.overline:
        return tokens.typographyOverline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle(context).copyWith(color: color);

    if (selectable) {
      return SelectableText(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
