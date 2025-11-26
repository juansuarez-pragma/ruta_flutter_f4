import 'package:flutter/material.dart';

import '../../atoms/atoms.dart';
import '../../tokens/tokens.dart';
import '../../utils/extensions/extensions.dart';

/// Vista para estados vacíos del sistema de diseño.
///
/// Se usa cuando no hay contenido para mostrar.
///
/// ## Uso básico
///
/// ```dart
/// DSEmptyState(
///   icon: Icons.shopping_cart_outlined,
///   title: 'Carrito vacío',
///   description: 'Agrega productos para continuar',
/// )
/// ```
///
/// ## Con acción
///
/// ```dart
/// DSEmptyState(
///   icon: Icons.search_off,
///   title: 'Sin resultados',
///   description: 'No encontramos productos con ese criterio',
///   actionText: 'Limpiar filtros',
///   onAction: () => clearFilters(),
/// )
/// ```
class DSEmptyState extends StatelessWidget {
  /// Ícono a mostrar.
  final IconData icon;

  /// Título del estado vacío.
  final String title;

  /// Descripción opcional.
  final String? description;

  /// Texto del botón de acción.
  final String? actionText;

  /// Callback del botón de acción.
  final VoidCallback? onAction;

  /// Tamaño del ícono.
  final double iconSize;

  const DSEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionText,
    this.onAction,
    this.iconSize = DSSizes.iconMega,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DSSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: tokens.colorIconDisabled,
            ),
            const SizedBox(height: DSSpacing.lg),
            DSText.headingSmall(
              title,
              textAlign: TextAlign.center,
              color: tokens.colorTextSecondary,
            ),
            if (description != null) ...[
              const SizedBox(height: DSSpacing.sm),
              DSText.bodyMedium(
                description!,
                textAlign: TextAlign.center,
                color: tokens.colorTextTertiary,
              ),
            ],
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: DSSpacing.xl),
              DSButton.primary(
                text: actionText!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
