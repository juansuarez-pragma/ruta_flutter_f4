import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

/// Badge visual para mostrar métricas del Design System.
///
/// Muestra un valor numérico con etiqueta e ícono opcional.
class MetricBadge extends StatelessWidget {
  /// Valor principal a mostrar (ej: "16").
  final String value;

  /// Etiqueta descriptiva (ej: "Componentes").
  final String label;

  /// Ícono opcional.
  final IconData? icon;

  /// Color de acento (default: colorBrandPrimary).
  final Color? color;

  const MetricBadge({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);
    final accentColor = color ?? tokens.colorBrandPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.lg,
        vertical: DSSpacing.md,
      ),
      decoration: BoxDecoration(
        color: tokens.colorSurfaceSecondary,
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: DSSizes.borderThin,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: DSSizes.iconLg,
              color: accentColor,
            ),
            const SizedBox(height: DSSpacing.xs),
          ],
          Text(
            value,
            style: tokens.typographyDisplaySmall.copyWith(
              color: accentColor,
              fontWeight: DSFontWeight.bold,
            ),
          ),
          const SizedBox(height: DSSpacing.xxs),
          Text(
            label,
            style: tokens.typographyLabelSmall.copyWith(
              color: tokens.colorTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
