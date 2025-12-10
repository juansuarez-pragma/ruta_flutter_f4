import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Badge del sistema de diseño.
///
/// Un pequeño componente para mostrar estados, etiquetas o contadores.
///
/// ## Uso básico
///
/// ```dart
/// DSBadge(
///   text: 'Nuevo',
///   type: DSBadgeType.success,
/// )
/// ```
///
/// ## Con ícono
///
/// ```dart
/// DSBadge(
///   text: 'Agotado',
///   type: DSBadgeType.error,
///   icon: Icons.warning,
/// )
/// ```
class DSBadge extends StatelessWidget {
  /// Texto del badge.
  final String text;

  /// Tipo de badge que determina el color.
  final DSBadgeType type;

  /// Tamaño del badge.
  final DSBadgeSize size;

  /// Ícono opcional.
  final IconData? icon;

  /// Crea un badge con el tipo y tamaño especificados.
  ///
  /// Por defecto crea un badge neutral de tamaño mediano.
  const DSBadge({
    super.key,
    required this.text,
    this.type = DSBadgeType.neutral,
    this.size = DSBadgeSize.medium,
    this.icon,
  });

  /// Crea un badge de éxito.
  const DSBadge.success({
    super.key,
    required this.text,
    this.size = DSBadgeSize.medium,
    this.icon,
  }) : type = DSBadgeType.success;

  /// Crea un badge de error.
  const DSBadge.error({
    super.key,
    required this.text,
    this.size = DSBadgeSize.medium,
    this.icon,
  }) : type = DSBadgeType.error;

  /// Crea un badge de advertencia.
  const DSBadge.warning({
    super.key,
    required this.text,
    this.size = DSBadgeSize.medium,
    this.icon,
  }) : type = DSBadgeType.warning;

  /// Crea un badge de información.
  const DSBadge.info({
    super.key,
    required this.text,
    this.size = DSBadgeSize.medium,
    this.icon,
  }) : type = DSBadgeType.info;

  /// Crea un badge neutral.
  const DSBadge.neutral({
    super.key,
    required this.text,
    this.size = DSBadgeSize.medium,
    this.icon,
  }) : type = DSBadgeType.neutral;

  EdgeInsetsGeometry get _padding {
    switch (size) {
      case DSBadgeSize.small:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.sm,
          vertical: DSSpacing.xxs,
        );
      case DSBadgeSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.md,
          vertical: DSSpacing.xs,
        );
      case DSBadgeSize.large:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.base,
          vertical: DSSpacing.sm,
        );
    }
  }

  double get _fontSize {
    switch (size) {
      case DSBadgeSize.small:
        return DSFontSize.labelSmall;
      case DSBadgeSize.medium:
        return DSFontSize.labelMedium;
      case DSBadgeSize.large:
        return DSFontSize.labelLarge;
    }
  }

  double get _iconSize {
    switch (size) {
      case DSBadgeSize.small:
        return DSSizes.iconXs;
      case DSBadgeSize.medium:
        return DSSizes.iconSm;
      case DSBadgeSize.large:
        return DSSizes.iconMd;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    Color backgroundColor;
    Color textColor;

    switch (type) {
      case DSBadgeType.success:
        backgroundColor = tokens.colorFeedbackSuccessLight;
        textColor = tokens.colorFeedbackSuccess;
      case DSBadgeType.error:
        backgroundColor = tokens.colorFeedbackErrorLight;
        textColor = tokens.colorFeedbackError;
      case DSBadgeType.warning:
        backgroundColor = tokens.colorFeedbackWarningLight;
        textColor = tokens.colorFeedbackWarning;
      case DSBadgeType.info:
        backgroundColor = tokens.colorFeedbackInfoLight;
        textColor = tokens.colorFeedbackInfo;
      case DSBadgeType.neutral:
        backgroundColor = tokens.badgeBackground;
        textColor = tokens.badgeText;
    }

    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DSBorderRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: _iconSize, color: textColor),
            const SizedBox(width: DSSpacing.xs),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: _fontSize,
              fontWeight: DSFontWeight.medium,
              color: textColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
