import 'package:flutter/material.dart';

import '../../tokens/tokens.dart';
import '../../utils/extensions/extensions.dart';

/// AppBar del sistema de diseño.
///
/// Proporciona una barra de aplicación consistente con el sistema de diseño.
///
/// ## Uso básico
///
/// ```dart
/// Scaffold(
///   appBar: DSAppBar(title: 'Productos'),
///   body: ...,
/// )
/// ```
///
/// ## Con acciones
///
/// ```dart
/// DSAppBar(
///   title: 'Productos',
///   actions: [
///     DSIconButton(
///       icon: Icons.search,
///       onPressed: () => openSearch(),
///     ),
///     DSIconButton(
///       icon: Icons.shopping_cart,
///       onPressed: () => openCart(),
///     ),
///   ],
/// )
/// ```
class DSAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Título de la AppBar.
  final String? title;

  /// Widget de título personalizado.
  final Widget? titleWidget;

  /// Widget leading (izquierda).
  final Widget? leading;

  /// Si debe mostrar el botón de retroceso automáticamente.
  final bool automaticallyImplyLeading;

  /// Lista de acciones (derecha).
  final List<Widget>? actions;

  /// Si el título debe estar centrado.
  final bool centerTitle;

  /// Elevación de la AppBar.
  final double elevation;

  /// Color de fondo personalizado.
  final Color? backgroundColor;

  /// Color del texto y los íconos.
  final Color? foregroundColor;

  /// Widget inferior (ej: TabBar).
  final PreferredSizeWidget? bottom;

  /// Altura de la AppBar.
  final double toolbarHeight;

  const DSAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: tokens.typographyTitleLarge.copyWith(
                    color: foregroundColor ?? tokens.colorTextPrimary,
                  ),
                )
              : null),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? tokens.colorSurfacePrimary,
      foregroundColor: foregroundColor ?? tokens.colorTextPrimary,
      surfaceTintColor: DSColors.transparent,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
    );
  }
}
