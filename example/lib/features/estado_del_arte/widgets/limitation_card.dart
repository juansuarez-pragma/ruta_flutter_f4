import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

/// Card para mostrar limitaciones del Design System.
class LimitationCard extends StatelessWidget {
  /// Categoría de la limitación (ej: "Animaciones").
  final String category;

  /// Descripción de la limitación.
  final String description;

  /// Impacto de la limitación (ej: "UX básica").
  final String impact;

  /// Ícono representativo.
  final IconData icon;

  const LimitationCard({
    super.key,
    required this.category,
    required this.description,
    required this.impact,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(DSSpacing.md),
      decoration: BoxDecoration(
        color: tokens.colorSurfaceSecondary,
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        border: Border.all(
          color: tokens.colorBorderSecondary,
          width: DSSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DSSpacing.sm),
                decoration: BoxDecoration(
                  color: tokens.colorFeedbackWarningLight,
                  borderRadius: BorderRadius.circular(DSBorderRadius.sm),
                ),
                child: Icon(
                  icon,
                  size: DSSizes.iconMd,
                  color: tokens.colorFeedbackWarning,
                ),
              ),
              const SizedBox(width: DSSpacing.md),
              Expanded(
                child: Text(
                  category,
                  style: tokens.typographyTitleSmall.copyWith(
                    color: tokens.colorTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DSSpacing.md),
          Text(
            description,
            style: tokens.typographyBodySmall.copyWith(
              color: tokens.colorTextSecondary,
            ),
          ),
          const SizedBox(height: DSSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.sm,
              vertical: DSSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: tokens.colorFeedbackInfoLight,
              borderRadius: BorderRadius.circular(DSBorderRadius.full),
            ),
            child: Text(
              'Impacto: $impact',
              style: tokens.typographyLabelSmall.copyWith(
                color: tokens.colorFeedbackInfo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
