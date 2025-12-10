import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Chip de filtro del sistema de diseño.
///
/// Ideal para seleccionar categorías u opciones de filtrado.
///
/// ## Uso básico
///
/// ```dart
/// DSFilterChip(
///   label: 'Electronics',
///   isSelected: selectedCategory == 'electronics',
///   onTap: () => selectCategory('electronics'),
/// )
/// ```
///
/// ## Con ícono
///
/// ```dart
/// DSFilterChip(
///   label: 'Favoritos',
///   icon: Icons.favorite,
///   isSelected: showFavorites,
///   onTap: () => toggleFavorites(),
/// )
/// ```
class DSFilterChip extends StatelessWidget {
  /// Texto del chip.
  final String label;

  /// Si el chip está seleccionado.
  final bool isSelected;

  /// Callback cuando se toca el chip.
  final VoidCallback? onTap;

  /// Ícono opcional.
  final IconData? icon;

  /// Si muestra un checkmark cuando está seleccionado.
  final bool showCheckmark;

  /// Crea un chip de filtro seleccionable.
  const DSFilterChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.showCheckmark = true,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onTap != null ? (_) => onTap!() : null,
      avatar: icon != null && !isSelected
          ? Icon(
              icon,
              size: DSSizes.iconSm,
              color: isSelected ? tokens.chipTextSelected : tokens.chipText,
            )
          : null,
      showCheckmark: showCheckmark,
      checkmarkColor: tokens.colorBrandPrimary,
      color: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          if (states.contains(WidgetState.pressed)) {
            return tokens.chipBackgroundPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return tokens.chipBackgroundHover;
          }
          return tokens.chipBackgroundSelected;
        }
        if (states.contains(WidgetState.pressed)) {
          return tokens.chipBackgroundPressed;
        }
        if (states.contains(WidgetState.hovered)) {
          return tokens.chipBackgroundHover;
        }
        return tokens.chipBackground;
      }),
      labelStyle: tokens.typographyLabelMedium.copyWith(
        color: isSelected ? tokens.chipTextSelected : tokens.chipText,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSBorderRadius.full),
        side: BorderSide(
          color: isSelected ? tokens.colorBrandPrimary : tokens.chipBorder,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.md,
        vertical: DSSpacing.sm,
      ),
    );
  }
}
