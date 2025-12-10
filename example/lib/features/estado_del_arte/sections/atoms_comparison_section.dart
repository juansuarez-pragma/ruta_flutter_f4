import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección de comparativas de componentes atómicos.
class AtomsComparisonSection extends StatelessWidget {
  const AtomsComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Comparativa de Átomos',
          subtitle: 'Componentes básicos e indivisibles del sistema de diseño',
        ),
        const SizedBox(height: DSSpacing.lg),
        _buildButtonComparison(),
        _buildIconButtonComparison(),
        _buildBadgeComparison(),
        _buildTextFieldComparison(),
        _buildLoaderComparison(),
        _buildTextComparison(),
        _buildSkeletonComparison(),
      ],
    );
  }

  Widget _buildButtonComparison() {
    return ComparisonPlayground(
      title: 'Botones',
      subtitle: 'ElevatedButton / OutlinedButton / TextButton vs DSButton',
      variants: const ['Primary', 'Secondary', 'Ghost', 'Danger'],
      sizes: const ['Small', 'Medium', 'Large'],
      hasLoadingToggle: true,
      hasDisabledToggle: true,
      flutterBuilder: (state) => _buildFlutterButton(state),
      flutterCodeBuilder: (state) => _buildFlutterButtonCode(state),
      dsBuilder: (state) => _buildDsButton(state),
      dsCodeBuilder: (state) => _buildDsButtonCode(state),
      advantages: const [
        'API unificada',
        'Estados hover/pressed',
        'Loading integrado',
        '4 variantes',
        'Named constructors',
      ],
      limitations: const [
        'Sin gradientes',
        'Sin autofocus',
      ],
    );
  }

  Widget _buildFlutterButton(PlaygroundState state) {
    final isDisabled = state.isDisabled;
    final onPressed = isDisabled ? null : () {};

    switch (state.variant) {
      case 'Primary':
        return ElevatedButton(
          onPressed: onPressed,
          child: state.isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Botón'),
        );
      case 'Secondary':
        return OutlinedButton(
          onPressed: onPressed,
          child: const Text('Botón'),
        );
      case 'Ghost':
        return TextButton(
          onPressed: onPressed,
          child: const Text('Botón'),
        );
      case 'Danger':
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Botón'),
        );
      default:
        return ElevatedButton(
          onPressed: onPressed,
          child: const Text('Botón'),
        );
    }
  }

  String _buildFlutterButtonCode(PlaygroundState state) {
    switch (state.variant) {
      case 'Primary':
        return '''ElevatedButton(
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  child: ${state.isLoading ? 'CircularProgressIndicator()' : "Text('Botón')"},
)''';
      case 'Secondary':
        return '''OutlinedButton(
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  child: Text('Botón'),
)''';
      case 'Ghost':
        return '''TextButton(
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  child: Text('Botón'),
)''';
      case 'Danger':
        return '''ElevatedButton(
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
  ),
  child: Text('Botón'),
)''';
      default:
        return '';
    }
  }

  Widget _buildDsButton(PlaygroundState state) {
    final size = _mapSize(state.size);
    final onPressed = state.isDisabled ? null : () {};

    switch (state.variant) {
      case 'Primary':
        return DSButton.primary(
          text: 'Botón',
          size: size,
          isLoading: state.isLoading,
          onPressed: onPressed,
        );
      case 'Secondary':
        return DSButton.secondary(
          text: 'Botón',
          size: size,
          isLoading: state.isLoading,
          onPressed: onPressed,
        );
      case 'Ghost':
        return DSButton.ghost(
          text: 'Botón',
          size: size,
          isLoading: state.isLoading,
          onPressed: onPressed,
        );
      case 'Danger':
        return DSButton.danger(
          text: 'Botón',
          size: size,
          isLoading: state.isLoading,
          onPressed: onPressed,
        );
      default:
        return DSButton.primary(
          text: 'Botón',
          size: size,
          onPressed: onPressed,
        );
    }
  }

  String _buildDsButtonCode(PlaygroundState state) {
    final sizeStr = state.size.toLowerCase();
    final variant = state.variant.toLowerCase();
    return '''DSButton.$variant(
  text: 'Botón',
  size: DSButtonSize.$sizeStr,
  isLoading: ${state.isLoading},
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
)''';
  }

  Widget _buildIconButtonComparison() {
    return ComparisonPlayground(
      title: 'Botones de Ícono',
      subtitle: 'IconButton vs DSIconButton',
      variants: const ['Primary', 'Secondary', 'Ghost', 'Danger'],
      sizes: const ['Small', 'Medium', 'Large'],
      hasLoadingToggle: true,
      hasDisabledToggle: true,
      flutterBuilder: (state) => IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: state.isDisabled ? null : () {},
        color: state.variant == 'Danger' ? Colors.red : null,
      ),
      flutterCodeBuilder: (state) => '''IconButton(
  icon: Icon(Icons.favorite),
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  color: ${state.variant == 'Danger' ? 'Colors.red' : 'null'},
)''',
      dsBuilder: (state) => DSIconButton(
        icon: Icons.favorite,
        variant: _mapVariant(state.variant),
        size: _mapSize(state.size),
        isLoading: state.isLoading,
        onPressed: state.isDisabled ? null : () {},
        tooltip: 'Favorito',
      ),
      dsCodeBuilder: (state) => '''DSIconButton(
  icon: Icons.favorite,
  variant: DSButtonVariant.${state.variant.toLowerCase()},
  size: DSButtonSize.${state.size.toLowerCase()},
  isLoading: ${state.isLoading},
  onPressed: ${state.isDisabled ? 'null' : '() {}'},
  tooltip: 'Favorito',
)''',
      advantages: const [
        'Variantes de color',
        'Estados hover/pressed',
        'Loading state',
        'Semantics automático',
      ],
      limitations: const [
        'Solo forma circular',
        'Sin badge overlay',
      ],
    );
  }

  Widget _buildBadgeComparison() {
    return ComparisonPlayground(
      title: 'Badges',
      subtitle: 'Container manual vs DSBadge',
      variants: const ['Success', 'Error', 'Warning', 'Info', 'Neutral'],
      sizes: const ['Small', 'Medium', 'Large'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getBadgeColor(state.variant).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Badge',
          style: TextStyle(
            color: _getBadgeColor(state.variant),
            fontSize: 12,
          ),
        ),
      ),
      flutterCodeBuilder: (state) => '''Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: ${_getBadgeColorName(state.variant)}.withOpacity(0.2),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('Badge',
    style: TextStyle(color: ${_getBadgeColorName(state.variant)}),
  ),
)''',
      dsBuilder: (state) => DSBadge(
        text: 'Badge',
        type: _mapBadgeType(state.variant),
        size: _mapBadgeSize(state.size),
      ),
      dsCodeBuilder: (state) => '''DSBadge(
  text: 'Badge',
  type: DSBadgeType.${state.variant.toLowerCase()},
  size: DSBadgeSize.${state.size.toLowerCase()},
)''',
      advantages: const [
        '5 tipos semánticos',
        'Named constructors',
        '3 tamaños',
        'Soporte de íconos',
      ],
      limitations: const [
        'Sin badge count',
        'No interactivo',
      ],
    );
  }

  Widget _buildTextFieldComparison() {
    return ComparisonPlayground(
      title: 'Campos de Texto',
      subtitle: 'TextField vs DSTextField',
      variants: const ['Normal', 'Con Error', 'Disabled'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => SizedBox(
        width: 200,
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'ejemplo@correo.com',
            errorText: state.variant == 'Con Error' ? 'Email inválido' : null,
            border: const OutlineInputBorder(),
          ),
          enabled: state.variant != 'Disabled',
        ),
      ),
      flutterCodeBuilder: (state) => '''TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'ejemplo@correo.com',
    ${state.variant == 'Con Error' ? "errorText: 'Email inválido'," : ''}
    border: OutlineInputBorder(),
  ),
  enabled: ${state.variant != 'Disabled'},
)''',
      dsBuilder: (state) => SizedBox(
        width: 200,
        child: DSTextField(
          label: 'Email',
          hint: 'ejemplo@correo.com',
          errorText: state.variant == 'Con Error' ? 'Email inválido' : null,
          enabled: state.variant != 'Disabled',
        ),
      ),
      dsCodeBuilder: (state) => '''DSTextField(
  label: 'Email',
  hint: 'ejemplo@correo.com',
  ${state.variant == 'Con Error' ? "errorText: 'Email inválido'," : ''}
  enabled: ${state.variant != 'Disabled'},
)''',
      advantages: const [
        'Label externo',
        'Estados visuales',
        'Semantics automático',
        'Colores de tokens',
      ],
      limitations: const [
        'Sin FormField',
        'Sin autocomplete',
        'Label no floating',
      ],
    );
  }

  Widget _buildLoaderComparison() {
    return ComparisonPlayground(
      title: 'Loaders',
      subtitle: 'CircularProgressIndicator vs DSCircularLoader',
      variants: const ['Sin mensaje', 'Con mensaje'],
      sizes: const ['Small', 'Medium', 'Large'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) {
        final size = _getLoaderSize(state.size);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: const CircularProgressIndicator(),
            ),
            if (state.variant == 'Con mensaje') ...[
              const SizedBox(height: 8),
              const Text('Cargando...'),
            ],
          ],
        );
      },
      flutterCodeBuilder: (state) => '''Column(
  children: [
    SizedBox(
      width: ${_getLoaderSize(state.size)},
      height: ${_getLoaderSize(state.size)},
      child: CircularProgressIndicator(),
    ),
    ${state.variant == 'Con mensaje' ? "SizedBox(height: 8),\n    Text('Cargando...')," : ''}
  ],
)''',
      dsBuilder: (state) => DSCircularLoader(
        size: _mapLoaderSize(state.size),
        message: state.variant == 'Con mensaje' ? 'Cargando...' : null,
      ),
      dsCodeBuilder: (state) => '''DSCircularLoader(
  size: DSLoaderSize.${state.size.toLowerCase()},
  ${state.variant == 'Con mensaje' ? "message: 'Cargando...'," : ''}
)''',
      advantages: const [
        '4 tamaños predefinidos',
        'Mensaje integrado',
        'Stroke automático',
        'Color de marca',
      ],
      limitations: const [
        'Sin modo determinado',
        'Sin tamaño custom',
      ],
    );
  }

  Widget _buildTextComparison() {
    return ComparisonPlayground(
      title: 'Texto',
      subtitle: 'Text vs DSText',
      variants: const ['Heading', 'Body', 'Caption'],
      sizes: const ['Large', 'Medium', 'Small'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => Text(
        'Texto de ejemplo',
        style: TextStyle(
          fontSize: _getTextSize(state.variant, state.size),
          fontWeight: state.variant == 'Heading' ? FontWeight.bold : null,
        ),
      ),
      flutterCodeBuilder: (state) => '''Text(
  'Texto de ejemplo',
  style: TextStyle(
    fontSize: ${_getTextSize(state.variant, state.size)},
    fontWeight: ${state.variant == 'Heading' ? 'FontWeight.bold' : 'null'},
  ),
)''',
      dsBuilder: (state) => DSText(
        'Texto de ejemplo',
        variant: _mapTextVariant(state.variant, state.size),
      ),
      dsCodeBuilder: (state) => '''DSText(
  'Texto de ejemplo',
  variant: DSTextVariant.${_getTextVariantName(state.variant, state.size)},
)''',
      advantages: const [
        '17 variantes',
        'Named constructors',
        'Seleccionable opcional',
        'Jerarquía clara',
      ],
      limitations: const [
        'Sin RichText',
        'Sin animaciones',
      ],
    );
  }

  Widget _buildSkeletonComparison() {
    return ComparisonPlayground(
      title: 'Skeleton',
      subtitle: 'No existe equivalente nativo',
      variants: const ['Rectangular', 'Circular', 'Text', 'Title'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      noFlutterEquivalent: 'Requiere implementación manual con AnimatedBuilder',
      flutterBuilder: (state) => const SizedBox(),
      flutterCodeBuilder: (state) => '''// No hay equivalente nativo
// Requiere AnimatedBuilder + Container
// con animación de opacidad manual''',
      dsBuilder: (state) {
        switch (state.variant) {
          case 'Circular':
            return const DSSkeleton.circular(size: 48);
          case 'Text':
            return const DSSkeleton.text(width: 150);
          case 'Title':
            return const DSSkeleton.title(width: 200);
          default:
            return const DSSkeleton(width: 200, height: 100);
        }
      },
      dsCodeBuilder: (state) {
        switch (state.variant) {
          case 'Circular':
            return 'DSSkeleton.circular(size: 48)';
          case 'Text':
            return 'DSSkeleton.text(width: 150)';
          case 'Title':
            return 'DSSkeleton.title(width: 200)';
          default:
            return 'DSSkeleton(width: 200, height: 100)';
        }
      },
      advantages: const [
        'Componente nuevo',
        'Animación automática',
        'Named constructors',
        '4 variantes',
      ],
      limitations: const [
        'Sin shimmer effect',
        'Sin compound layout',
      ],
    );
  }

  // Helpers
  DSButtonSize _mapSize(String size) {
    switch (size) {
      case 'Small':
        return DSButtonSize.small;
      case 'Large':
        return DSButtonSize.large;
      default:
        return DSButtonSize.medium;
    }
  }

  DSButtonVariant _mapVariant(String variant) {
    switch (variant) {
      case 'Secondary':
        return DSButtonVariant.secondary;
      case 'Ghost':
        return DSButtonVariant.ghost;
      case 'Danger':
        return DSButtonVariant.danger;
      default:
        return DSButtonVariant.primary;
    }
  }

  DSBadgeType _mapBadgeType(String variant) {
    switch (variant) {
      case 'Success':
        return DSBadgeType.success;
      case 'Error':
        return DSBadgeType.error;
      case 'Warning':
        return DSBadgeType.warning;
      case 'Info':
        return DSBadgeType.info;
      default:
        return DSBadgeType.neutral;
    }
  }

  DSBadgeSize _mapBadgeSize(String size) {
    switch (size) {
      case 'Small':
        return DSBadgeSize.small;
      case 'Large':
        return DSBadgeSize.large;
      default:
        return DSBadgeSize.medium;
    }
  }

  Color _getBadgeColor(String variant) {
    switch (variant) {
      case 'Success':
        return Colors.green;
      case 'Error':
        return Colors.red;
      case 'Warning':
        return Colors.orange;
      case 'Info':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getBadgeColorName(String variant) {
    switch (variant) {
      case 'Success':
        return 'Colors.green';
      case 'Error':
        return 'Colors.red';
      case 'Warning':
        return 'Colors.orange';
      case 'Info':
        return 'Colors.blue';
      default:
        return 'Colors.grey';
    }
  }

  double _getLoaderSize(String size) {
    switch (size) {
      case 'Small':
        return 20;
      case 'Large':
        return 48;
      default:
        return 32;
    }
  }

  DSLoaderSize _mapLoaderSize(String size) {
    switch (size) {
      case 'Small':
        return DSLoaderSize.small;
      case 'Large':
        return DSLoaderSize.large;
      default:
        return DSLoaderSize.medium;
    }
  }

  double _getTextSize(String variant, String size) {
    if (variant == 'Heading') {
      switch (size) {
        case 'Large':
          return 28;
        case 'Small':
          return 20;
        default:
          return 24;
      }
    } else if (variant == 'Body') {
      switch (size) {
        case 'Large':
          return 18;
        case 'Small':
          return 14;
        default:
          return 16;
      }
    } else {
      return 12;
    }
  }

  DSTextVariant _mapTextVariant(String variant, String size) {
    if (variant == 'Heading') {
      switch (size) {
        case 'Large':
          return DSTextVariant.headingLarge;
        case 'Small':
          return DSTextVariant.headingSmall;
        default:
          return DSTextVariant.headingMedium;
      }
    } else if (variant == 'Body') {
      switch (size) {
        case 'Large':
          return DSTextVariant.bodyLarge;
        case 'Small':
          return DSTextVariant.bodySmall;
        default:
          return DSTextVariant.bodyMedium;
      }
    } else {
      return DSTextVariant.caption;
    }
  }

  String _getTextVariantName(String variant, String size) {
    if (variant == 'Heading') {
      return 'heading$size';
    } else if (variant == 'Body') {
      return 'body$size';
    } else {
      return 'caption';
    }
  }
}
