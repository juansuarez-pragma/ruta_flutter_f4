import 'package:fake_store_design_system/src/foundations/foundations.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Item de navegación inferior.
class DSBottomNavItem {
  /// Ícono del item.
  final IconData icon;

  /// Ícono cuando está seleccionado (opcional).
  final IconData? selectedIcon;

  /// Etiqueta del item.
  final String label;

  /// Contador de badge (ej: items en carrito).
  final int? badgeCount;

  /// Crea un item de navegación inferior con ícono y etiqueta.
  ///
  /// - [icon]: ícono del item.
  /// - [selectedIcon]: ícono cuando está seleccionado (opcional).
  /// - [label]: etiqueta del item.
  /// - [badgeCount]: contador de badge (opcional).
  const DSBottomNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.badgeCount,
  });
}

/// Barra de navegación inferior del sistema de diseño.
///
/// ## Uso básico
///
/// ```dart
/// DSBottomNav(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     DSBottomNavItem(icon: Icons.home, label: 'Inicio'),
///     DSBottomNavItem(icon: Icons.category, label: 'Categorías'),
///     DSBottomNavItem(icon: Icons.shopping_cart, label: 'Carrito', badgeCount: 3),
///     DSBottomNavItem(icon: Icons.person, label: 'Perfil'),
///   ],
/// )
/// ```
class DSBottomNav extends StatelessWidget {
  /// Índice actual seleccionado.
  final int currentIndex;

  /// Callback cuando se selecciona un item.
  final ValueChanged<int> onTap;

  /// Lista de items de navegación.
  final List<DSBottomNavItem> items;

  /// Color de fondo.
  final Color? backgroundColor;

  /// Elevación.
  final double elevation;

  /// Crea una barra de navegación inferior con los items especificados.
  ///
  /// - [currentIndex]: índice del item seleccionado.
  /// - [onTap]: callback cuando se selecciona un item.
  /// - [items]: lista de items de navegación.
  /// - [backgroundColor]: color de fondo personalizado (opcional).
  /// - [elevation]: nivel de elevación, por defecto `0`.
  const DSBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? tokens.colorSurfacePrimary,
        border: Border(
          top: BorderSide(
            color: tokens.colorBorderSecondary,
          ),
        ),
        boxShadow: elevation > 0 ? tokens.elevationLevel2 : null,
      ),
      child: SafeArea(
        child: SizedBox(
          height: DSSizes.bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return Expanded(
                child: _NavItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => onTap(index),
                  tokens: tokens,
                  index: index,
                  totalItems: items.length,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final DSBottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final DSThemeData tokens;
  final int index;
  final int totalItems;

  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.tokens,
    required this.index,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? tokens.colorBrandPrimary
        : tokens.colorIconSecondary;

    final icon = isSelected && item.selectedIcon != null
        ? item.selectedIcon!
        : item.icon;

    // Construir etiqueta semántica - usar label del item
    // El estado selected se comunica via Semantics.selected
    // El badge count se incluye como número si existe
    final badgeInfo = item.badgeCount != null && item.badgeCount! > 0
        ? ' (${item.badgeCount})'
        : '';

    return Semantics(
      selected: isSelected,
      button: true,
      label: '${item.label}$badgeInfo',
      child: InkWell(
        onTap: onTap,
        excludeFromSemantics: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: DSSizes.iconBase, color: color),
                if (item.badgeCount != null && item.badgeCount! > 0)
                  Positioned(
                    right: DSSizes.badgeOffsetX,
                    top: DSSizes.badgeOffsetY,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DSSpacing.xs,
                        vertical: DSSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: tokens.colorFeedbackError,
                        borderRadius: BorderRadius.circular(
                          DSBorderRadius.full,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: DSSizes.badgeMinSize,
                        minHeight: DSSizes.badgeMinSize,
                      ),
                      child: Text(
                        item.badgeCount! > 99 ? '99+' : '${item.badgeCount}',
                        style: TextStyle(
                          fontSize: DSFontSize.badgeText,
                          fontWeight: DSFontWeight.bold,
                          color: tokens.colorTextInverse,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: DSSpacing.xs),
            Text(
              item.label,
              style: TextStyle(
                fontSize: DSFontSize.labelSmall,
                fontWeight: isSelected
                    ? DSFontWeight.medium
                    : DSFontWeight.regular,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
