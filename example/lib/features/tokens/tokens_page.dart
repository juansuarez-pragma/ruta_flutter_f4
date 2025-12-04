import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';

/// Página de demostración de tokens del sistema de diseño.
class TokensPage extends StatelessWidget {
  const TokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(DSSpacing.lg),
      children: const [
        _ColorsSection(),
        _TypographySection(),
        _SpacingSection(),
        _ElevationSection(),
        _BorderRadiusSection(),
      ],
    );
  }
}

// =============================================================================
// COLORS SECTION
// =============================================================================

class _ColorsSection extends StatelessWidget {
  const _ColorsSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Colores',
          subtitle: 'Paleta de colores primitivos y semánticos del sistema',
        ),
        // Colores semánticos
        ComponentCard(
          title: 'Colores Semánticos',
          description:
              'Colores con significado contextual que cambian según el tema',
          code: '''
// Acceso via context.tokens
final tokens = context.tokens;

Container(color: tokens.colorBrandPrimary)
Container(color: tokens.colorSurfacePrimary)
Container(color: tokens.colorTextPrimary)
Container(color: tokens.colorFeedbackSuccess)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              _ColorBox(color: tokens.colorBrandPrimary, name: 'Brand Primary'),
              _ColorBox(
                color: tokens.colorBrandSecondary,
                name: 'Brand Secondary',
              ),
              _ColorBox(
                color: tokens.colorSurfacePrimary,
                name: 'Surface Primary',
                hasBorder: true,
              ),
              _ColorBox(
                color: tokens.colorSurfaceSecondary,
                name: 'Surface Secondary',
              ),
              _ColorBox(color: tokens.colorTextPrimary, name: 'Text Primary'),
              _ColorBox(
                color: tokens.colorFeedbackSuccess,
                name: 'Feedback Success',
              ),
              _ColorBox(
                color: tokens.colorFeedbackError,
                name: 'Feedback Error',
              ),
              _ColorBox(
                color: tokens.colorFeedbackWarning,
                name: 'Feedback Warning',
              ),
              _ColorBox(color: tokens.colorFeedbackInfo, name: 'Feedback Info'),
            ],
          ),
        ),
        // Paleta Primary
        const ComponentCard(
          title: 'Paleta Primary',
          description: 'Escala de colores primarios (púrpura)',
          code: '''
// Colores primitivos - NO usar directamente
// Usar tokens semánticos en su lugar

DSColors.primary50   // #F3E5F5
DSColors.primary100  // #E1BEE7
DSColors.primary500  // #6200EE (base)
DSColors.primary900  // #32009A''',
          child: Wrap(
            spacing: DSSpacing.sm,
            runSpacing: DSSpacing.sm,
            children: [
              _ColorBox(color: DSColors.primary50, name: '50', small: true),
              _ColorBox(color: DSColors.primary100, name: '100', small: true),
              _ColorBox(color: DSColors.primary200, name: '200', small: true),
              _ColorBox(color: DSColors.primary300, name: '300', small: true),
              _ColorBox(color: DSColors.primary400, name: '400', small: true),
              _ColorBox(color: DSColors.primary500, name: '500', small: true),
              _ColorBox(color: DSColors.primary600, name: '600', small: true),
              _ColorBox(color: DSColors.primary700, name: '700', small: true),
              _ColorBox(color: DSColors.primary800, name: '800', small: true),
              _ColorBox(color: DSColors.primary900, name: '900', small: true),
            ],
          ),
        ),
        // Paleta Neutral
        const ComponentCard(
          title: 'Paleta Neutral',
          description: 'Escala de grises para textos, bordes y fondos',
          code: '''
DSColors.neutral50   // #FAFAFA
DSColors.neutral500  // #9E9E9E
DSColors.neutral900  // #212121''',
          child: Wrap(
            spacing: DSSpacing.sm,
            runSpacing: DSSpacing.sm,
            children: [
              _ColorBox(
                color: DSColors.neutral50,
                name: '50',
                small: true,
                hasBorder: true,
              ),
              _ColorBox(color: DSColors.neutral100, name: '100', small: true),
              _ColorBox(color: DSColors.neutral200, name: '200', small: true),
              _ColorBox(color: DSColors.neutral300, name: '300', small: true),
              _ColorBox(color: DSColors.neutral400, name: '400', small: true),
              _ColorBox(color: DSColors.neutral500, name: '500', small: true),
              _ColorBox(color: DSColors.neutral600, name: '600', small: true),
              _ColorBox(color: DSColors.neutral700, name: '700', small: true),
              _ColorBox(color: DSColors.neutral800, name: '800', small: true),
              _ColorBox(color: DSColors.neutral900, name: '900', small: true),
            ],
          ),
        ),
        // Paleta Feedback
        const ComponentCard(
          title: 'Paleta Feedback',
          description:
              'Colores para estados de éxito, error, advertencia e información',
          code: '''
DSColors.success500  // #4CAF50
DSColors.error500    // #B00020
DSColors.warning500  // #FFC107
DSColors.info500     // #2196F3''',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ColorRow(
                      label: 'Success',
                      colors: [
                        DSColors.success100,
                        DSColors.success500,
                        DSColors.success700,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: DSSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _ColorRow(
                      label: 'Error',
                      colors: [
                        DSColors.error100,
                        DSColors.error500,
                        DSColors.error700,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: DSSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _ColorRow(
                      label: 'Warning',
                      colors: [
                        DSColors.warning100,
                        DSColors.warning500,
                        DSColors.warning700,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: DSSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _ColorRow(
                      label: 'Info',
                      colors: [
                        DSColors.info100,
                        DSColors.info500,
                        DSColors.info700,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final String name;
  final bool small;
  final bool hasBorder;

  const _ColorBox({
    required this.color,
    required this.name,
    this.small = false,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = small ? 48.0 : 72.0;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            border: hasBorder
                ? Border.all(color: tokens.colorBorderPrimary)
                : null,
          ),
        ),
        const SizedBox(height: DSSpacing.xs),
        SizedBox(
          width: size,
          child: Text(
            name,
            style: tokens.typographyCaption.copyWith(
              color: tokens.colorTextSecondary,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  final String label;
  final List<Color> colors;

  const _ColorRow({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(label, style: tokens.typographyLabelSmall),
        ),
        ...colors.map(
          (color) => Expanded(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: colors.indexOf(color) == 0
                    ? const BorderRadius.horizontal(
                        left: Radius.circular(DSBorderRadius.sm),
                      )
                    : colors.indexOf(color) == colors.length - 1
                    ? const BorderRadius.horizontal(
                        right: Radius.circular(DSBorderRadius.sm),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// TYPOGRAPHY SECTION
// =============================================================================

class _TypographySection extends StatelessWidget {
  const _TypographySection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Tipografía',
          subtitle: 'Escala tipográfica y estilos de texto',
        ),
        ComponentCard(
          title: 'Estilos de Texto',
          description: 'Usando DSText con diferentes variantes',
          code: '''
DSText.displayLarge('Display Large')
DSText.headingLarge('Heading Large')
DSText.titleMedium('Title Medium')
DSText.bodyMedium('Body Medium')
DSText.labelSmall('Label Small')
DSText.caption('Caption')''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TypographyRow(
                name: 'Display Large',
                size: '${DSFontSize.displayLarge.toInt()}px',
                style: tokens.typographyDisplayLarge,
              ),
              _TypographyRow(
                name: 'Display Medium',
                size: '${DSFontSize.displayMedium.toInt()}px',
                style: tokens.typographyDisplayMedium,
              ),
              const Divider(height: DSSpacing.lg),
              _TypographyRow(
                name: 'Heading Large',
                size: '${DSFontSize.headingLarge.toInt()}px',
                style: tokens.typographyHeadingLarge,
              ),
              _TypographyRow(
                name: 'Heading Medium',
                size: '${DSFontSize.headingMedium.toInt()}px',
                style: tokens.typographyHeadingMedium,
              ),
              _TypographyRow(
                name: 'Heading Small',
                size: '${DSFontSize.headingSmall.toInt()}px',
                style: tokens.typographyHeadingSmall,
              ),
              const Divider(height: DSSpacing.lg),
              _TypographyRow(
                name: 'Title Large',
                size: '${DSFontSize.titleLarge.toInt()}px',
                style: tokens.typographyTitleLarge,
              ),
              _TypographyRow(
                name: 'Title Medium',
                size: '${DSFontSize.titleMedium.toInt()}px',
                style: tokens.typographyTitleMedium,
              ),
              _TypographyRow(
                name: 'Title Small',
                size: '${DSFontSize.titleSmall.toInt()}px',
                style: tokens.typographyTitleSmall,
              ),
              const Divider(height: DSSpacing.lg),
              _TypographyRow(
                name: 'Body Large',
                size: '${DSFontSize.bodyLarge.toInt()}px',
                style: tokens.typographyBodyLarge,
              ),
              _TypographyRow(
                name: 'Body Medium',
                size: '${DSFontSize.bodyMedium.toInt()}px',
                style: tokens.typographyBodyMedium,
              ),
              _TypographyRow(
                name: 'Body Small',
                size: '${DSFontSize.bodySmall.toInt()}px',
                style: tokens.typographyBodySmall,
              ),
              const Divider(height: DSSpacing.lg),
              _TypographyRow(
                name: 'Label Large',
                size: '${DSFontSize.labelLarge.toInt()}px',
                style: tokens.typographyLabelLarge,
              ),
              _TypographyRow(
                name: 'Label Medium',
                size: '${DSFontSize.labelMedium.toInt()}px',
                style: tokens.typographyLabelMedium,
              ),
              _TypographyRow(
                name: 'Label Small',
                size: '${DSFontSize.labelSmall.toInt()}px',
                style: tokens.typographyLabelSmall,
              ),
              const Divider(height: DSSpacing.lg),
              _TypographyRow(
                name: 'Caption',
                size: '${DSFontSize.caption.toInt()}px',
                style: tokens.typographyCaption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypographyRow extends StatelessWidget {
  final String name;
  final String size;
  final TextStyle style;

  const _TypographyRow({
    required this.name,
    required this.size,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DSSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: tokens.typographyLabelSmall.copyWith(
                    color: tokens.colorTextSecondary,
                  ),
                ),
                Text(
                  size,
                  style: tokens.typographyCaption.copyWith(
                    color: tokens.colorTextTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: DSSpacing.lg),
          Expanded(
            child: Text(
              'Ejemplo de texto',
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SPACING SECTION
// =============================================================================

class _SpacingSection extends StatelessWidget {
  const _SpacingSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Espaciado',
          subtitle: 'Sistema de espaciado basado en múltiplos de 4px',
        ),
        ComponentCard(
          title: 'Escala de Espaciado',
          description: 'Valores de espaciado para padding, margin y gaps',
          code: '''
DSSpacing.none   // 0px
DSSpacing.xxs    // 2px
DSSpacing.xs     // 4px
DSSpacing.sm     // 8px
DSSpacing.md     // 12px
DSSpacing.base   // 16px
DSSpacing.lg     // 20px
DSSpacing.xl     // 24px
DSSpacing.xxl    // 32px
DSSpacing.xxxl   // 40px
DSSpacing.jumbo  // 48px''',
          child: Column(
            children: [
              _SpacingRow(name: 'none', value: DSSpacing.none),
              _SpacingRow(name: 'xxs', value: DSSpacing.xxs),
              _SpacingRow(name: 'xs', value: DSSpacing.xs),
              _SpacingRow(name: 'sm', value: DSSpacing.sm),
              _SpacingRow(name: 'md', value: DSSpacing.md),
              _SpacingRow(name: 'base', value: DSSpacing.base),
              _SpacingRow(name: 'lg', value: DSSpacing.lg),
              _SpacingRow(name: 'xl', value: DSSpacing.xl),
              _SpacingRow(name: 'xxl', value: DSSpacing.xxl),
              _SpacingRow(name: 'xxxl', value: DSSpacing.xxxl),
              _SpacingRow(name: 'jumbo', value: DSSpacing.jumbo),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpacingRow extends StatelessWidget {
  final String name;
  final double value;

  const _SpacingRow({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DSSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(name, style: tokens.typographyLabelSmall),
          ),
          SizedBox(
            width: 50,
            child: Text(
              '${value.toInt()}px',
              style: tokens.typographyCaption.copyWith(
                color: tokens.colorTextSecondary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              alignment: Alignment.centerLeft,
              child: Container(
                width: value * 4,
                height: 16,
                decoration: BoxDecoration(
                  color: tokens.colorBrandPrimary,
                  borderRadius: BorderRadius.circular(DSBorderRadius.xs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// ELEVATION SECTION
// =============================================================================

class _ElevationSection extends StatelessWidget {
  const _ElevationSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Elevación',
          subtitle: 'Niveles de sombra para profundidad visual',
        ),
        ComponentCard(
          title: 'Niveles de Elevación',
          description: 'Sombras para crear jerarquía visual',
          code: '''
// Usar desde tokens del tema
tokens.elevationLevel1  // Cards, Buttons
tokens.elevationLevel2  // Cards hover, Dropdowns
tokens.elevationLevel3  // Modals, Dialogs
tokens.elevationLevel4  // Navigation drawers''',
          child: Wrap(
            spacing: DSSpacing.lg,
            runSpacing: DSSpacing.lg,
            children: [
              const _ElevationBox(label: 'Level 0', elevation: []),
              _ElevationBox(
                label: 'Level 1',
                elevation: tokens.elevationLevel1,
              ),
              _ElevationBox(
                label: 'Level 2',
                elevation: tokens.elevationLevel2,
              ),
              _ElevationBox(
                label: 'Level 3',
                elevation: tokens.elevationLevel3,
              ),
              _ElevationBox(
                label: 'Level 4',
                elevation: tokens.elevationLevel4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ElevationBox extends StatelessWidget {
  final String label;
  final List<BoxShadow> elevation;

  const _ElevationBox({required this.label, required this.elevation});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: tokens.colorSurfacePrimary,
            borderRadius: BorderRadius.circular(DSBorderRadius.base),
            border: elevation.isEmpty
                ? Border.all(color: tokens.colorBorderSecondary)
                : null,
            boxShadow: elevation,
          ),
        ),
        const SizedBox(height: DSSpacing.sm),
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

// =============================================================================
// BORDER RADIUS SECTION
// =============================================================================

class _BorderRadiusSection extends StatelessWidget {
  const _BorderRadiusSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Border Radius',
          subtitle: 'Valores de redondeo para esquinas',
        ),
        ComponentCard(
          title: 'Escala de Border Radius',
          description: 'Valores predefinidos para bordes redondeados',
          code: '''
DSBorderRadius.none  // 0px
DSBorderRadius.xs    // 4px
DSBorderRadius.sm    // 8px
DSBorderRadius.base  // 12px
DSBorderRadius.md    // 10px
DSBorderRadius.lg    // 16px
DSBorderRadius.xl    // 20px
DSBorderRadius.full  // 9999px (circular)''',
          child: Wrap(
            spacing: DSSpacing.lg,
            runSpacing: DSSpacing.lg,
            children: [
              _BorderRadiusBox(label: 'none', radius: DSBorderRadius.none),
              _BorderRadiusBox(label: 'xs (4px)', radius: DSBorderRadius.xs),
              _BorderRadiusBox(label: 'sm (8px)', radius: DSBorderRadius.sm),
              _BorderRadiusBox(
                label: 'base (12px)',
                radius: DSBorderRadius.base,
              ),
              _BorderRadiusBox(label: 'lg (16px)', radius: DSBorderRadius.lg),
              _BorderRadiusBox(label: 'xl (20px)', radius: DSBorderRadius.xl),
              _BorderRadiusBox(label: 'full', radius: DSBorderRadius.full),
            ],
          ),
        ),
      ],
    );
  }
}

class _BorderRadiusBox extends StatelessWidget {
  final String label;
  final double radius;

  const _BorderRadiusBox({required this.label, required this.radius});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: tokens.colorBrandPrimary.withAlpha(51),
            border: Border.all(color: tokens.colorBrandPrimary, width: 2),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        const SizedBox(height: DSSpacing.sm),
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
