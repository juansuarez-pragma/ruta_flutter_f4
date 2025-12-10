import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección de resumen con métricas del Design System.
class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Resumen del Design System',
          subtitle:
              'Métricas generales y distribución de componentes por categoría',
        ),
        const SizedBox(height: DSSpacing.lg),
        // Métricas principales
        Wrap(
          spacing: DSSpacing.md,
          runSpacing: DSSpacing.md,
          children: [
            MetricBadge(
              value: '16',
              label: 'Componentes\nTotales',
              icon: Icons.widgets_outlined,
              color: tokens.colorBrandPrimary,
            ),
            const MetricBadge(
              value: '10',
              label: 'Basados en\nFlutter',
              icon: Icons.flutter_dash,
              color: Colors.blue,
            ),
            MetricBadge(
              value: '6',
              label: 'Componentes\nNuevos',
              icon: Icons.add_circle_outline,
              color: tokens.colorFeedbackSuccess,
            ),
            MetricBadge(
              value: '85+',
              label: 'Tokens\nSemánticos',
              icon: Icons.palette_outlined,
              color: tokens.colorFeedbackWarning,
            ),
          ],
        ),
        const SizedBox(height: DSSpacing.xl),
        // Distribución por categoría
        Text(
          'Distribución por Categoría',
          style: tokens.typographyTitleSmall.copyWith(
            color: tokens.colorTextPrimary,
          ),
        ),
        const SizedBox(height: DSSpacing.md),
        Row(
          children: [
            _CategoryChip(
              label: 'Átomos',
              count: 7,
              color: tokens.colorFeedbackSuccess,
              tokens: tokens,
            ),
            const SizedBox(width: DSSpacing.sm),
            _CategoryChip(
              label: 'Moléculas',
              count: 6,
              color: tokens.colorFeedbackInfo,
              tokens: tokens,
            ),
            const SizedBox(width: DSSpacing.sm),
            _CategoryChip(
              label: 'Organismos',
              count: 3,
              color: tokens.colorFeedbackWarning,
              tokens: tokens,
            ),
          ],
        ),
        const SizedBox(height: DSSpacing.xl),
        // Barra de progreso visual
        _buildProgressBar(tokens),
        const SizedBox(height: DSSpacing.xxl),
      ],
    );
  }

  Widget _buildProgressBar(DSThemeData tokens) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cobertura del Sistema',
          style: tokens.typographyTitleSmall.copyWith(
            color: tokens.colorTextPrimary,
          ),
        ),
        const SizedBox(height: DSSpacing.md),
        Container(
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DSBorderRadius.full),
            color: tokens.colorSurfaceSecondary,
          ),
          child: Row(
            children: [
              // Átomos (7/16 = 43.75%)
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: tokens.colorFeedbackSuccess,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(DSBorderRadius.full),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '7',
                    style: tokens.typographyLabelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: DSFontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Moléculas (6/16 = 37.5%)
              Expanded(
                flex: 6,
                child: Container(
                  color: tokens.colorFeedbackInfo,
                  alignment: Alignment.center,
                  child: Text(
                    '6',
                    style: tokens.typographyLabelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: DSFontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Organismos (3/16 = 18.75%)
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: tokens.colorFeedbackWarning,
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(DSBorderRadius.full),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '3',
                    style: tokens.typographyLabelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: DSFontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DSSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _LegendItem(
              color: tokens.colorFeedbackSuccess,
              label: 'Átomos (44%)',
              tokens: tokens,
            ),
            _LegendItem(
              color: tokens.colorFeedbackInfo,
              label: 'Moléculas (37%)',
              tokens: tokens,
            ),
            _LegendItem(
              color: tokens.colorFeedbackWarning,
              label: 'Organismos (19%)',
              tokens: tokens,
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final DSThemeData tokens;

  const _CategoryChip({
    required this.label,
    required this.count,
    required this.color,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.md,
        vertical: DSSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DSBorderRadius.full),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: DSSizes.borderThin,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: tokens.typographyLabelSmall.copyWith(
                color: Colors.white,
                fontWeight: DSFontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: DSSpacing.sm),
          Text(
            label,
            style: tokens.typographyLabelMedium.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final DSThemeData tokens;

  const _LegendItem({
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(DSBorderRadius.xs),
          ),
        ),
        const SizedBox(width: DSSpacing.xs),
        Text(
          label,
          style: tokens.typographyCaption.copyWith(
            color: tokens.colorTextSecondary,
          ),
        ),
      ],
    );
  }
}
