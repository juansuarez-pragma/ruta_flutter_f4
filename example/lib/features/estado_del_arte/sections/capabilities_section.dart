import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección con tabla de capacidades de todos los componentes.
class CapabilitiesSection extends StatelessWidget {
  const CapabilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Tabla de Capacidades',
          subtitle:
              'Comparativa de características por componente: estados interactivos, accesibilidad, temas, loading y variantes',
        ),
        const SizedBox(height: DSSpacing.lg),
        _buildLegend(context),
        const SizedBox(height: DSSpacing.md),
        const CapabilityTable(
          components: CapabilityTable.allComponents,
        ),
        const SizedBox(height: DSSpacing.xxl),
      ],
    );
  }

  Widget _buildLegend(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return Wrap(
      spacing: DSSpacing.lg,
      runSpacing: DSSpacing.sm,
      children: [
        _LegendItem(
          icon: Icons.check_circle,
          color: tokens.colorFeedbackSuccess,
          label: 'Soportado',
          tokens: tokens,
        ),
        _LegendItem(
          icon: Icons.remove_circle_outline,
          color: tokens.colorTextTertiary,
          label: 'No soportado',
          tokens: tokens,
        ),
        _CategoryLegend(
          color: tokens.colorFeedbackSuccess,
          label: 'Átomo',
          tokens: tokens,
        ),
        _CategoryLegend(
          color: tokens.colorFeedbackInfo,
          label: 'Molécula',
          tokens: tokens,
        ),
        _CategoryLegend(
          color: tokens.colorFeedbackWarning,
          label: 'Organismo',
          tokens: tokens,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final DSThemeData tokens;

  const _LegendItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: DSSizes.iconSm, color: color),
        const SizedBox(width: DSSpacing.xs),
        Text(
          label,
          style: tokens.typographyLabelSmall.copyWith(
            color: tokens.colorTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _CategoryLegend extends StatelessWidget {
  final Color color;
  final String label;
  final DSThemeData tokens;

  const _CategoryLegend({
    required this.color,
    required this.label,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DSSpacing.sm,
            vertical: DSSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(DSBorderRadius.full),
          ),
          child: Text(
            label,
            style: tokens.typographyLabelSmall.copyWith(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
