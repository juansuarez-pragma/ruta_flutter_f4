import 'package:fake_store_design_system/src/foundations/foundations.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Botón de ícono del sistema de diseño.
///
/// Un botón circular que solo contiene un ícono, ideal para acciones
/// rápidas como favoritos, compartir, etc.
///
/// ## Uso básico
///
/// ```dart
/// DSIconButton(
///   icon: Icons.favorite,
///   onPressed: () => toggleFavorite(),
/// )
/// ```
///
/// ## Con variante
///
/// ```dart
/// DSIconButton(
///   icon: Icons.delete,
///   variant: DSButtonVariant.danger,
///   onPressed: () => deleteItem(),
/// )
/// ```
class DSIconButton extends StatelessWidget {
  /// Ícono del botón.
  final IconData icon;

  /// Callback cuando se presiona el botón.
  final VoidCallback? onPressed;

  /// Variante del botón.
  final DSButtonVariant variant;

  /// Tamaño del botón.
  final DSButtonSize size;

  /// Tooltip del botón.
  final String? tooltip;

  /// Si el botón está en estado de carga.
  final bool isLoading;

  /// Crea un botón de ícono con la variante y tamaño especificados.
  ///
  /// Por defecto crea un botón ghost de tamaño mediano.
  ///
  /// - [icon]: ícono a mostrar.
  /// - [onPressed]: callback al presionar, `null` para deshabilitar.
  /// - [variant]: variante visual, por defecto `ghost`.
  /// - [size]: tamaño del botón, por defecto `medium`.
  /// - [tooltip]: texto de tooltip para accesibilidad (opcional).
  /// - [isLoading]: muestra indicador de carga si es `true`.
  const DSIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = DSButtonVariant.ghost,
    this.size = DSButtonSize.medium,
    this.tooltip,
    this.isLoading = false,
  });

  double get _size {
    switch (size) {
      case DSButtonSize.small:
        return DSSizes.buttonSm;
      case DSButtonSize.medium:
        return DSSizes.buttonMd;
      case DSButtonSize.large:
        return DSSizes.buttonLg;
    }
  }

  double get _iconSize {
    switch (size) {
      case DSButtonSize.small:
        return DSSizes.iconSm;
      case DSButtonSize.medium:
        return DSSizes.iconMd;
      case DSButtonSize.large:
        return DSSizes.iconBase;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDisabled = onPressed == null || isLoading;

    final colors = _getColors(tokens, isDisabled);

    // Etiqueta semántica para accesibilidad
    final semanticLabel = tooltip ?? _getDefaultSemanticLabel();

    Widget button = Semantics(
      button: true,
      enabled: !isDisabled,
      label: semanticLabel,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Material(
          color: colors.background,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: isDisabled ? null : onPressed,
            customBorder: const CircleBorder(),
            hoverColor: colors.hoverBackground,
            splashColor: colors.pressedBackground,
            highlightColor: colors.pressedBackground,
            excludeFromSemantics: true,
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: _iconSize,
                      height: _iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: DSSizes.borderMedium,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.foreground,
                        ),
                      ),
                    )
                  : Icon(
                      icon,
                      size: _iconSize,
                      color: colors.foreground,
                    ),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip, child: button);
    }

    return button;
  }

  String _getDefaultSemanticLabel() {
    final variantLabel = switch (variant) {
      DSButtonVariant.primary => 'primary',
      DSButtonVariant.secondary => 'secondary',
      DSButtonVariant.ghost => '',
      DSButtonVariant.danger => 'danger',
    };
    final stateLabel = isLoading ? 'loading' : '';
    return [variantLabel, 'button', stateLabel]
        .where((s) => s.isNotEmpty)
        .join(' ');
  }

  _IconButtonColors _getColors(DSThemeData tokens, bool isDisabled) {
    switch (variant) {
      case DSButtonVariant.primary:
        return _IconButtonColors(
          background: isDisabled
              ? tokens.buttonPrimaryBackgroundDisabled
              : tokens.buttonPrimaryBackground,
          hoverBackground: tokens.buttonPrimaryBackgroundHover,
          pressedBackground: tokens.buttonPrimaryBackgroundPressed,
          foreground: isDisabled
              ? tokens.buttonPrimaryTextDisabled
              : tokens.buttonPrimaryText,
        );
      case DSButtonVariant.secondary:
        return _IconButtonColors(
          background: tokens.buttonSecondaryBackground,
          hoverBackground: tokens.buttonSecondaryBackgroundHover,
          pressedBackground: tokens.buttonSecondaryBackgroundPressed,
          foreground: isDisabled
              ? tokens.buttonSecondaryTextDisabled
              : tokens.buttonSecondaryText,
        );
      case DSButtonVariant.ghost:
        return _IconButtonColors(
          background: tokens.buttonGhostBackground,
          hoverBackground: tokens.buttonGhostBackgroundHover,
          pressedBackground: tokens.buttonGhostBackgroundPressed,
          foreground: isDisabled
              ? tokens.buttonGhostTextDisabled
              : tokens.buttonGhostText,
        );
      case DSButtonVariant.danger:
        return _IconButtonColors(
          background: isDisabled
              ? tokens.buttonPrimaryBackgroundDisabled
              : tokens.buttonDangerBackground,
          hoverBackground: tokens.buttonDangerBackgroundHover,
          pressedBackground: tokens.buttonDangerBackgroundPressed,
          foreground: isDisabled
              ? tokens.buttonPrimaryTextDisabled
              : tokens.buttonDangerText,
        );
    }
  }
}

class _IconButtonColors {
  final Color background;
  final Color hoverBackground;
  final Color pressedBackground;
  final Color foreground;

  const _IconButtonColors({
    required this.background,
    required this.hoverBackground,
    required this.pressedBackground,
    required this.foreground,
  });
}
