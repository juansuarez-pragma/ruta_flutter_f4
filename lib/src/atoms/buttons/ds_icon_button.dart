import 'package:flutter/material.dart';

import '../../tokens/tokens.dart';
import '../../utils/enums/enums.dart';
import '../../utils/extensions/extensions.dart';

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

    Color backgroundColor;
    Color foregroundColor;

    switch (variant) {
      case DSButtonVariant.primary:
        backgroundColor = isDisabled
            ? tokens.buttonPrimaryBackgroundDisabled
            : tokens.buttonPrimaryBackground;
        foregroundColor = isDisabled
            ? tokens.buttonPrimaryTextDisabled
            : tokens.buttonPrimaryText;
        break;
      case DSButtonVariant.secondary:
        backgroundColor = tokens.buttonSecondaryBackground;
        foregroundColor = isDisabled
            ? tokens.buttonSecondaryTextDisabled
            : tokens.buttonSecondaryText;
        break;
      case DSButtonVariant.ghost:
        backgroundColor = tokens.buttonGhostBackground;
        foregroundColor = isDisabled
            ? tokens.buttonGhostTextDisabled
            : tokens.buttonGhostText;
        break;
      case DSButtonVariant.danger:
        backgroundColor = isDisabled
            ? tokens.buttonPrimaryBackgroundDisabled
            : tokens.buttonDangerBackground;
        foregroundColor = isDisabled
            ? tokens.buttonPrimaryTextDisabled
            : tokens.buttonDangerText;
        break;
    }

    Widget button = SizedBox(
      width: _size,
      height: _size,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          customBorder: const CircleBorder(),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: _iconSize,
                    height: _iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                    ),
                  )
                : Icon(
                    icon,
                    size: _iconSize,
                    color: foregroundColor,
                  ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}
