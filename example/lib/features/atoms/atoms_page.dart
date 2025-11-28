import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/widgets.dart';

/// Página de demostración de componentes atómicos.
class AtomsPage extends StatelessWidget {
  const AtomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(DSSpacing.lg),
      children: const [
        _ButtonsSection(),
        _IconButtonsSection(),
        _BadgesSection(),
        _InputsSection(),
        _LoadersSection(),
        _TextSection(),
      ],
    );
  }
}

// =============================================================================
// BUTTONS SECTION
// =============================================================================

class _ButtonsSection extends StatelessWidget {
  const _ButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Botones',
          subtitle: 'DSButton con diferentes variantes, tamaños y estados',
        ),
        // Variantes
        ComponentCard(
          title: 'Variantes de Botón',
          description: 'Primary, Secondary, Ghost y Danger',
          code: '''
DSButton.primary(
  text: 'Primary',
  onPressed: () {},
)

DSButton.secondary(
  text: 'Secondary',
  onPressed: () {},
)

DSButton.ghost(
  text: 'Ghost',
  onPressed: () {},
)

DSButton.danger(
  text: 'Danger',
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              DSButton.primary(text: 'Primary', onPressed: () {}),
              DSButton.secondary(text: 'Secondary', onPressed: () {}),
              DSButton.ghost(text: 'Ghost', onPressed: () {}),
              DSButton.danger(text: 'Danger', onPressed: () {}),
            ],
          ),
        ),
        // Tamaños
        ComponentCard(
          title: 'Tamaños de Botón',
          description: 'Small, Medium y Large',
          code: '''
DSButton.primary(
  text: 'Small',
  size: DSButtonSize.small,
  onPressed: () {},
)

DSButton.primary(
  text: 'Medium',
  size: DSButtonSize.medium,
  onPressed: () {},
)

DSButton.primary(
  text: 'Large',
  size: DSButtonSize.large,
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DSButton.primary(
                text: 'Small',
                size: DSButtonSize.small,
                onPressed: () {},
              ),
              DSButton.primary(
                text: 'Medium',
                size: DSButtonSize.medium,
                onPressed: () {},
              ),
              DSButton.primary(
                text: 'Large',
                size: DSButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Con íconos
        ComponentCard(
          title: 'Botones con Íconos',
          description: 'Íconos al inicio o al final del texto',
          code: '''
DSButton.primary(
  text: 'Agregar',
  icon: Icons.add,
  onPressed: () {},
)

DSButton.primary(
  text: 'Siguiente',
  icon: Icons.arrow_forward,
  iconPosition: DSButtonIconPosition.end,
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              DSButton.primary(
                text: 'Agregar',
                icon: Icons.add,
                onPressed: () {},
              ),
              DSButton.secondary(
                text: 'Descargar',
                icon: Icons.download,
                onPressed: () {},
              ),
              DSButton.primary(
                text: 'Siguiente',
                icon: Icons.arrow_forward,
                iconPosition: DSButtonIconPosition.end,
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Estados
        ComponentCard(
          title: 'Estados de Botón',
          description: 'Disabled y Loading',
          code: '''
// Disabled
DSButton.primary(
  text: 'Disabled',
  onPressed: null, // null = disabled
)

// Loading
DSButton.primary(
  text: 'Cargando',
  isLoading: true,
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              const DSButton.primary(
                text: 'Disabled',
                onPressed: null,
              ),
              const DSButton.secondary(
                text: 'Disabled',
                onPressed: null,
              ),
              DSButton.primary(
                text: 'Cargando',
                isLoading: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Full Width
        ComponentCard(
          title: 'Botón Full Width',
          description: 'Botón que ocupa todo el ancho disponible',
          code: '''
DSButton.primary(
  text: 'Continuar',
  isFullWidth: true,
  onPressed: () {},
)''',
          child: DSButton.primary(
            text: 'Continuar',
            isFullWidth: true,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// ICON BUTTONS SECTION
// =============================================================================

class _IconButtonsSection extends StatelessWidget {
  const _IconButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Icon Buttons',
          subtitle: 'DSIconButton para acciones con solo ícono',
        ),
        ComponentCard(
          title: 'Variantes',
          description: 'Primary, Secondary, Ghost con tooltip',
          code: '''
DSIconButton(
  icon: Icons.favorite,
  variant: DSButtonVariant.primary,
  onPressed: () {},
  tooltip: 'Favorito',
)

DSIconButton(
  icon: Icons.share,
  variant: DSButtonVariant.secondary,
  onPressed: () {},
)

DSIconButton(
  icon: Icons.more_vert,
  variant: DSButtonVariant.ghost,
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              DSIconButton(
                icon: Icons.favorite,
                variant: DSButtonVariant.primary,
                onPressed: () {},
                tooltip: 'Favorito',
              ),
              DSIconButton(
                icon: Icons.share,
                variant: DSButtonVariant.secondary,
                onPressed: () {},
                tooltip: 'Compartir',
              ),
              DSIconButton(
                icon: Icons.more_vert,
                variant: DSButtonVariant.ghost,
                onPressed: () {},
                tooltip: 'Más opciones',
              ),
              DSIconButton(
                icon: Icons.delete,
                variant: DSButtonVariant.danger,
                onPressed: () {},
                tooltip: 'Eliminar',
              ),
            ],
          ),
        ),
        ComponentCard(
          title: 'Tamaños',
          description: 'Small, Medium y Large',
          code: '''
DSIconButton(
  icon: Icons.settings,
  size: DSButtonSize.small,
  onPressed: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DSIconButton(
                icon: Icons.settings,
                size: DSButtonSize.small,
                onPressed: () {},
              ),
              DSIconButton(
                icon: Icons.settings,
                size: DSButtonSize.medium,
                onPressed: () {},
              ),
              DSIconButton(
                icon: Icons.settings,
                size: DSButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// BADGES SECTION
// =============================================================================

class _BadgesSection extends StatelessWidget {
  const _BadgesSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Badges',
          subtitle: 'DSBadge para estados, etiquetas y contadores',
        ),
        // Tipos
        ComponentCard(
          title: 'Tipos de Badge',
          description: 'Success, Error, Warning, Info y Neutral',
          code: '''
DSBadge.success(text: 'Activo')
DSBadge.error(text: 'Agotado')
DSBadge.warning(text: 'Pocas unidades')
DSBadge.info(text: 'Nuevo')
DSBadge.neutral(text: 'Borrador')''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              DSBadge.success(text: 'Activo'),
              DSBadge.error(text: 'Agotado'),
              DSBadge.warning(text: 'Pocas unidades'),
              DSBadge.info(text: 'Nuevo'),
              DSBadge.neutral(text: 'Borrador'),
            ],
          ),
        ),
        // Tamaños
        ComponentCard(
          title: 'Tamaños de Badge',
          description: 'Small, Medium y Large',
          code: '''
DSBadge.success(
  text: 'Small',
  size: DSBadgeSize.small,
)

DSBadge.success(
  text: 'Medium',
  size: DSBadgeSize.medium,
)

DSBadge.success(
  text: 'Large',
  size: DSBadgeSize.large,
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DSBadge.success(text: 'Small', size: DSBadgeSize.small),
              DSBadge.success(text: 'Medium', size: DSBadgeSize.medium),
              DSBadge.success(text: 'Large', size: DSBadgeSize.large),
            ],
          ),
        ),
        // Con íconos
        ComponentCard(
          title: 'Badges con Íconos',
          description: 'Badges que incluyen un ícono',
          code: '''
DSBadge.success(
  text: 'Verificado',
  icon: Icons.check_circle,
)

DSBadge.error(
  text: 'Error',
  icon: Icons.error,
)''',
          child: Wrap(
            spacing: DSSpacing.md,
            runSpacing: DSSpacing.md,
            children: [
              DSBadge.success(text: 'Verificado', icon: Icons.check_circle),
              DSBadge.error(text: 'Error', icon: Icons.error),
              DSBadge.warning(text: 'Atención', icon: Icons.warning),
              DSBadge.info(text: 'Info', icon: Icons.info),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// INPUTS SECTION
// =============================================================================

class _InputsSection extends StatefulWidget {
  const _InputsSection();

  @override
  State<_InputsSection> createState() => _InputsSectionState();
}

class _InputsSectionState extends State<_InputsSection> {
  final _controller = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Campos de Texto',
          subtitle: 'DSTextField para entrada de datos',
        ),
        // Básico
        ComponentCard(
          title: 'Campo de Texto Básico',
          description: 'Con label, hint y helper text',
          code: '''
DSTextField(
  label: 'Email',
  hint: 'ejemplo@correo.com',
  helperText: 'Ingresa tu correo electrónico',
  onChanged: (value) {},
)''',
          child: DSTextField(
            label: 'Email',
            hint: 'ejemplo@correo.com',
            helperText: 'Ingresa tu correo electrónico',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
          ),
        ),
        // Con error
        const ComponentCard(
          title: 'Campo con Error',
          description: 'Mostrando mensaje de error de validación',
          code: '''
DSTextField(
  label: 'Email',
  hint: 'ejemplo@correo.com',
  errorText: 'El email no es válido',
)''',
          child: DSTextField(
            label: 'Email',
            hint: 'ejemplo@correo.com',
            errorText: 'El email no es válido',
          ),
        ),
        // Con íconos
        ComponentCard(
          title: 'Campo con Íconos',
          description: 'Íconos de prefijo y sufijo',
          code: '''
DSTextField(
  label: 'Buscar',
  hint: 'Buscar productos...',
  prefixIcon: Icons.search,
)

DSTextField(
  label: 'Contraseña',
  hint: '••••••••',
  obscureText: true,
  prefixIcon: Icons.lock,
  suffixIcon: Icons.visibility,
  onSuffixIconTap: () => toggleVisibility(),
)''',
          child: Column(
            children: [
              const DSTextField(
                label: 'Buscar',
                hint: 'Buscar productos...',
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: DSSpacing.lg),
              DSTextField(
                label: 'Contraseña',
                hint: '********',
                obscureText: _obscurePassword,
                prefixIcon: Icons.lock,
                suffixIcon:
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                onSuffixIconTap: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ],
          ),
        ),
        // Disabled
        const ComponentCard(
          title: 'Campo Deshabilitado',
          description: 'Campo de texto no editable',
          code: '''
DSTextField(
  label: 'Usuario',
  hint: 'usuario@ejemplo.com',
  enabled: false,
)''',
          child: DSTextField(
            label: 'Usuario',
            hint: 'usuario@ejemplo.com',
            enabled: false,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// LOADERS SECTION
// =============================================================================

class _LoadersSection extends StatelessWidget {
  const _LoadersSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Loaders',
          subtitle: 'Indicadores de carga y skeletons',
        ),
        // Circular Loader
        ComponentCard(
          title: 'Circular Loader',
          description: 'Indicador de carga circular en diferentes tamaños',
          code: '''
DSCircularLoader(size: DSLoaderSize.small)
DSCircularLoader(size: DSLoaderSize.medium)
DSCircularLoader(size: DSLoaderSize.large)

// Con mensaje
DSCircularLoader(
  size: DSLoaderSize.medium,
  message: 'Cargando...',
)''',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DSCircularLoader(size: DSLoaderSize.small),
              DSCircularLoader(size: DSLoaderSize.medium),
              DSCircularLoader(size: DSLoaderSize.large),
            ],
          ),
        ),
        // Con mensaje
        ComponentCard(
          title: 'Loader con Mensaje',
          description: 'Indicador de carga con texto descriptivo',
          code: '''
DSCircularLoader(
  size: DSLoaderSize.medium,
  message: 'Cargando productos...',
)''',
          child: Center(
            child: DSCircularLoader(
              size: DSLoaderSize.medium,
              message: 'Cargando productos...',
            ),
          ),
        ),
        // Skeleton
        ComponentCard(
          title: 'Skeleton',
          description: 'Placeholder animado para contenido en carga',
          code: '''
// Línea de texto
DSSkeleton(width: 200, height: 16)

// Avatar circular
DSSkeleton(
  width: 48,
  height: 48,
  borderRadius: DSBorderRadius.full,
)

// Card
DSSkeleton(
  width: double.infinity,
  height: 120,
)''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DSSkeleton(
                    width: 48,
                    height: 48,
                    borderRadius: DSBorderRadius.full,
                  ),
                  SizedBox(width: DSSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DSSkeleton(width: 150, height: 16),
                      SizedBox(height: DSSpacing.sm),
                      DSSkeleton(width: 100, height: 12),
                    ],
                  ),
                ],
              ),
              SizedBox(height: DSSpacing.lg),
              DSSkeleton(
                width: double.infinity,
                height: 120,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// TEXT SECTION
// =============================================================================

class _TextSection extends StatelessWidget {
  const _TextSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Texto',
          subtitle: 'DSText con variantes tipográficas predefinidas',
        ),
        const ComponentCard(
          title: 'Named Constructors',
          description: 'Constructores nombrados para cada variante',
          code: '''
DSText.displayLarge('Display Large')
DSText.headingLarge('Heading Large')
DSText.headingMedium('Heading Medium')
DSText.titleLarge('Title Large')
DSText.bodyMedium('Body Medium')
DSText.labelMedium('Label Medium')
DSText.caption('Caption')''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSText.headingLarge('Heading Large'),
              SizedBox(height: DSSpacing.sm),
              DSText.headingMedium('Heading Medium'),
              SizedBox(height: DSSpacing.sm),
              DSText.titleLarge('Title Large'),
              SizedBox(height: DSSpacing.sm),
              DSText.titleMedium('Title Medium'),
              SizedBox(height: DSSpacing.sm),
              DSText.bodyLarge('Body Large - Texto de párrafo principal'),
              SizedBox(height: DSSpacing.sm),
              DSText.bodyMedium('Body Medium - Texto de párrafo secundario'),
              SizedBox(height: DSSpacing.sm),
              DSText.label('Label Medium'),
              SizedBox(height: DSSpacing.sm),
              DSText.caption('Caption - Texto pequeño para notas'),
            ],
          ),
        ),
        // Con color personalizado
        ComponentCard(
          title: 'Texto con Color',
          description: 'Aplicando colores personalizados',
          code: '''
DSText(
  'Texto primario',
  variant: DSTextVariant.bodyMedium,
  color: tokens.colorBrandPrimary,
)

DSText(
  'Texto de éxito',
  variant: DSTextVariant.bodyMedium,
  color: tokens.colorFeedbackSuccess,
)''',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DSText(
                'Texto con color de marca',
                variant: DSTextVariant.bodyMedium,
                color: tokens.colorBrandPrimary,
              ),
              const SizedBox(height: DSSpacing.sm),
              DSText(
                'Texto de éxito',
                variant: DSTextVariant.bodyMedium,
                color: tokens.colorFeedbackSuccess,
              ),
              const SizedBox(height: DSSpacing.sm),
              DSText(
                'Texto de error',
                variant: DSTextVariant.bodyMedium,
                color: tokens.colorFeedbackError,
              ),
              const SizedBox(height: DSSpacing.sm),
              DSText(
                'Texto secundario',
                variant: DSTextVariant.bodyMedium,
                color: tokens.colorTextSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
