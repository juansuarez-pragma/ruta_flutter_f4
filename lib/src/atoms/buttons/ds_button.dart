import 'package:flutter/material.dart';

import 'package:fake_store_design_system/src/foundations/foundations.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';

/// Botón base del sistema de diseño.
///
/// Proporciona una API unificada para todos los tipos de botones con soporte
/// para diferentes variantes, tamaños, estados e íconos.
///
/// ## Uso básico
///
/// ```dart
/// DSButton.primary(
///   text: 'Continuar',
///   onPressed: () => handleContinue(),
/// )
/// ```
///
/// ## Con ícono
///
/// ```dart
/// DSButton.primary(
///   text: 'Agregar al carrito',
///   icon: Icons.shopping_cart,
///   onPressed: () => addToCart(),
/// )
/// ```
///
/// ## Estado de carga
///
/// ```dart
/// DSButton.primary(
///   text: 'Guardando...',
///   isLoading: true,
///   onPressed: null,
/// )
/// ```
class DSButton extends StatelessWidget {
  /// Texto del botón.
  final String text;

  /// Callback cuando se presiona el botón.
  ///
  /// Si es null, el botón estará deshabilitado.
  final VoidCallback? onPressed;

  /// Ícono opcional del botón.
  final IconData? icon;

  /// Posición del ícono.
  final DSButtonIconPosition iconPosition;

  /// Variante del botón.
  final DSButtonVariant variant;

  /// Tamaño del botón.
  final DSButtonSize size;

  /// Si el botón está en estado de carga.
  final bool isLoading;

  /// Si el botón ocupa todo el ancho disponible.
  final bool isFullWidth;

  const DSButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = DSButtonIconPosition.start,
    this.variant = DSButtonVariant.primary,
    this.size = DSButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  /// Crea un botón primario.
  const DSButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = DSButtonIconPosition.start,
    this.size = DSButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = DSButtonVariant.primary;

  /// Crea un botón secundario.
  const DSButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = DSButtonIconPosition.start,
    this.size = DSButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = DSButtonVariant.secondary;

  /// Crea un botón ghost.
  const DSButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = DSButtonIconPosition.start,
    this.size = DSButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = DSButtonVariant.ghost;

  /// Crea un botón de peligro.
  const DSButton.danger({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.iconPosition = DSButtonIconPosition.start,
    this.size = DSButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : variant = DSButtonVariant.danger;

  double get _height {
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

  double get _fontSize {
    switch (size) {
      case DSButtonSize.small:
        return DSFontSize.labelSmall;
      case DSButtonSize.medium:
        return DSFontSize.labelMedium;
      case DSButtonSize.large:
        return DSFontSize.labelLarge;
    }
  }

  EdgeInsetsGeometry get _padding {
    switch (size) {
      case DSButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.md,
          vertical: DSSpacing.xs,
        );
      case DSButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.base,
          vertical: DSSpacing.sm,
        );
      case DSButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: DSSpacing.xl,
          vertical: DSSpacing.md,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _height,
      child: _buildButton(context, tokens, isDisabled),
    );
  }

  Widget _buildButton(
    BuildContext context,
    DSThemeData tokens,
    bool isDisabled,
  ) {
    switch (variant) {
      case DSButtonVariant.primary:
        return _buildPrimaryButton(context, tokens, isDisabled);
      case DSButtonVariant.secondary:
        return _buildSecondaryButton(context, tokens, isDisabled);
      case DSButtonVariant.ghost:
        return _buildGhostButton(context, tokens, isDisabled);
      case DSButtonVariant.danger:
        return _buildDangerButton(context, tokens, isDisabled);
    }
  }

  Widget _buildPrimaryButton(
    BuildContext context,
    DSThemeData tokens,
    bool isDisabled,
  ) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonPrimaryBackgroundDisabled;
          }
          if (states.contains(WidgetState.pressed)) {
            return tokens.buttonPrimaryBackgroundPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return tokens.buttonPrimaryBackgroundHover;
          }
          return tokens.buttonPrimaryBackground;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonPrimaryTextDisabled;
          }
          return tokens.buttonPrimaryText;
        }),
        elevation: const WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(_padding),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
          ),
        ),
      ),
      child: _buildContent(
        tokens.buttonPrimaryText,
        tokens.buttonPrimaryTextDisabled,
        isDisabled,
      ),
    );
  }

  Widget _buildSecondaryButton(
    BuildContext context,
    DSThemeData tokens,
    bool isDisabled,
  ) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonSecondaryTextDisabled;
          }
          return tokens.buttonSecondaryText;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonSecondaryBackground;
          }
          if (states.contains(WidgetState.pressed)) {
            return tokens.buttonSecondaryBackgroundPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return tokens.buttonSecondaryBackgroundHover;
          }
          return tokens.buttonSecondaryBackground;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: tokens.buttonSecondaryTextDisabled,
              width: DSSizes.borderThin,
            );
          }
          return BorderSide(
            color: tokens.buttonSecondaryBorder,
            width: DSSizes.borderThin,
          );
        }),
        padding: WidgetStatePropertyAll(_padding),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
          ),
        ),
      ),
      child: _buildContent(
        tokens.buttonSecondaryText,
        tokens.buttonSecondaryTextDisabled,
        isDisabled,
      ),
    );
  }

  Widget _buildGhostButton(
    BuildContext context,
    DSThemeData tokens,
    bool isDisabled,
  ) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonGhostTextDisabled;
          }
          return tokens.buttonGhostText;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonGhostBackground;
          }
          if (states.contains(WidgetState.pressed)) {
            return tokens.buttonGhostBackgroundPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return tokens.buttonGhostBackgroundHover;
          }
          return tokens.buttonGhostBackground;
        }),
        padding: WidgetStatePropertyAll(_padding),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
          ),
        ),
      ),
      child: _buildContent(
        tokens.buttonGhostText,
        tokens.buttonGhostTextDisabled,
        isDisabled,
      ),
    );
  }

  Widget _buildDangerButton(
    BuildContext context,
    DSThemeData tokens,
    bool isDisabled,
  ) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonDangerBackgroundDisabled;
          }
          if (states.contains(WidgetState.pressed)) {
            return tokens.buttonDangerBackgroundPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return tokens.buttonDangerBackgroundHover;
          }
          return tokens.buttonDangerBackground;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return tokens.buttonDangerTextDisabled;
          }
          return tokens.buttonDangerText;
        }),
        elevation: const WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(_padding),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
          ),
        ),
      ),
      child: _buildContent(
        tokens.buttonDangerText,
        tokens.buttonDangerTextDisabled,
        isDisabled,
      ),
    );
  }

  Widget _buildContent(Color textColor, Color disabledColor, bool isDisabled) {
    if (isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isDisabled ? disabledColor : textColor,
          ),
        ),
      );
    }

    final color = isDisabled ? disabledColor : textColor;

    if (icon == null) {
      return Text(
        text,
        style: TextStyle(fontSize: _fontSize, fontWeight: DSFontWeight.medium),
      );
    }

    final iconWidget = Icon(icon, size: _iconSize, color: color);
    final textWidget = Text(
      text,
      style: TextStyle(fontSize: _fontSize, fontWeight: DSFontWeight.medium),
    );

    final children = iconPosition == DSButtonIconPosition.start
        ? [iconWidget, const SizedBox(width: DSSpacing.sm), textWidget]
        : [textWidget, const SizedBox(width: DSSpacing.sm), iconWidget];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
