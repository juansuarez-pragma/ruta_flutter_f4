import 'package:fake_store_design_system/src/foundations/foundations.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Card base del sistema de diseño.
///
/// Proporciona un contenedor con estilos consistentes para agrupar contenido.
///
/// ## Uso básico
///
/// ```dart
/// DSCard(
///   child: Column(
///     children: [
///       Text('Título'),
///       Text('Descripción'),
///     ],
///   ),
/// )
/// ```
///
/// ## Interactiva
///
/// ```dart
/// DSCard(
///   onTap: () => navigateToDetail(),
///   child: ListTile(title: Text('Item')),
/// )
/// ```
class DSCard extends StatelessWidget {
  /// Contenido de la card.
  final Widget child;

  /// Padding interno de la card.
  final EdgeInsetsGeometry? padding;

  /// Callback cuando se toca la card.
  final VoidCallback? onTap;

  /// Nivel de elevación (1-5).
  final int elevation;

  /// Color de fondo personalizado.
  final Color? backgroundColor;

  /// Radio del borde.
  final double borderRadius;

  /// Si debe mostrar borde.
  final bool showBorder;

  /// Ancho de la card.
  final double? width;

  /// Alto de la card.
  final double? height;

  /// Crea una card con el contenido y estilo especificados.
  ///
  /// - [child]: contenido de la card.
  /// - [padding]: padding interno, por defecto `DSSpacing.base`.
  /// - [onTap]: callback al tocar la card (opcional).
  /// - [elevation]: nivel de sombra de 0 a 5, por defecto `1`.
  /// - [backgroundColor]: color de fondo personalizado (opcional).
  /// - [borderRadius]: radio del borde, por defecto `DSBorderRadius.base`.
  /// - [showBorder]: muestra borde si es `true`, por defecto `true`.
  /// - [width]: ancho fijo de la card (opcional).
  /// - [height]: alto fijo de la card (opcional).
  const DSCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.elevation = 1,
    this.backgroundColor,
    this.borderRadius = DSBorderRadius.base,
    this.showBorder = true,
    this.width,
    this.height,
  });

  List<BoxShadow> _getElevation(DSThemeData tokens) {
    switch (elevation) {
      case 0:
        return DSElevation.none;
      case 1:
        return tokens.elevationLevel1;
      case 2:
        return tokens.elevationLevel2;
      case 3:
        return tokens.elevationLevel3;
      case 4:
        return tokens.elevationLevel4;
      case 5:
        return tokens.elevationLevel5;
      default:
        return tokens.elevationLevel1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bgColor = backgroundColor ?? tokens.cardBackground;

    Widget card = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(DSSpacing.base),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder
            ? Border.all(color: tokens.cardBorder)
            : null,
        boxShadow: _getElevation(tokens),
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: DSColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          hoverColor: tokens.cardBackgroundHover.withValues(
            alpha: DSColors.opacityHover,
          ),
          splashColor: tokens.cardBackgroundHover,
          highlightColor: tokens.cardBackgroundHover.withValues(
            alpha: DSColors.opacityHighlight,
          ),
          child: card,
        ),
      );
    }

    return card;
  }
}
