import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección de comparativas de componentes moleculares.
class MoleculesComparisonSection extends StatelessWidget {
  const MoleculesComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Comparativa de Moléculas',
          subtitle: 'Combinación de átomos con funcionalidad específica',
        ),
        const SizedBox(height: DSSpacing.lg),
        _buildCardComparison(),
        _buildProductCardComparison(),
        _buildFilterChipComparison(),
        _buildEmptyStateComparison(),
        _buildErrorStateComparison(),
        _buildLoadingStateComparison(),
      ],
    );
  }

  Widget _buildCardComparison() {
    return ComparisonPlayground(
      title: 'Cards',
      subtitle: 'Card vs DSCard',
      variants: const ['Sin tap', 'Con tap'],
      sizes: const ['Elevation 0', 'Elevation 1', 'Elevation 2'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => SizedBox(
        width: 180,
        child: Card(
          elevation: _getElevation(state.size),
          child: InkWell(
            onTap: state.variant == 'Con tap' ? () {} : null,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(height: 8),
                  Text('Contenido de la card'),
                ],
              ),
            ),
          ),
        ),
      ),
      flutterCodeBuilder: (state) => '''Card(
  elevation: ${_getElevation(state.size)},
  child: InkWell(
    onTap: ${state.variant == 'Con tap' ? '() {}' : 'null'},
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(Icons.info_outline),
          Text('Contenido'),
        ],
      ),
    ),
  ),
)''',
      dsBuilder: (state) => SizedBox(
        width: 180,
        child: DSCard(
          elevation: _getDsElevation(state.size),
          onTap: state.variant == 'Con tap' ? () {} : null,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline),
              SizedBox(height: 8),
              Text('Contenido de la card'),
            ],
          ),
        ),
      ),
      dsCodeBuilder: (state) => '''DSCard(
  elevation: ${_getDsElevation(state.size)},
  onTap: ${state.variant == 'Con tap' ? '() {}' : 'null'},
  child: Column(
    children: [
      Icon(Icons.info_outline),
      Text('Contenido'),
    ],
  ),
)''',
      advantages: const [
        '5 niveles de elevación',
        'Interactividad integrada',
        'Hover states',
        'Border opcional',
      ],
      limitations: const [
        'Sin clip behavior',
        'Sin outline variant',
      ],
    );
  }

  Widget _buildProductCardComparison() {
    return ComparisonPlayground(
      title: 'Product Card',
      subtitle: 'No existe equivalente nativo',
      variants: const ['Básica', 'Con badge', 'Con carrito'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      noFlutterEquivalent: 'Requiere composición manual de Card + Image + Text',
      flutterBuilder: (state) => const SizedBox(),
      flutterCodeBuilder: (state) => '''// No hay equivalente nativo
// Requiere composición manual:
// Card + Stack + Image.network +
// Column + Text + Rating widget''',
      dsBuilder: (state) => SizedBox(
        width: 180,
        height: 260,
        child: DSProductCard(
          imageUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
          title: 'Producto de ejemplo',
          price: 99.99,
          rating: 4.5,
          reviewCount: 120,
          badge: state.variant == 'Con badge' ? 'Nuevo' : null,
          badgeType: DSBadgeType.success,
          onTap: () {},
          onAddToCart: state.variant == 'Con carrito' ? () {} : null,
        ),
      ),
      dsCodeBuilder: (state) => '''DSProductCard(
  imageUrl: 'https://...',
  title: 'Producto de ejemplo',
  price: 99.99,
  rating: 4.5,
  reviewCount: 120,
  ${state.variant == 'Con badge' ? "badge: 'Nuevo',\n  badgeType: DSBadgeType.success," : ''}
  onTap: () {},
  ${state.variant == 'Con carrito' ? 'onAddToCart: () {},' : ''}
)''',
      advantages: const [
        'Componente completo',
        'Loading de imagen',
        'Error fallback',
        'Semantics de imagen',
        'Badge integrado',
      ],
      limitations: const [
        'Diseño fijo',
        'Sin precio con descuento',
        'Solo un badge',
      ],
    );
  }

  Widget _buildFilterChipComparison() {
    return ComparisonPlayground(
      title: 'Filter Chips',
      subtitle: 'FilterChip vs DSFilterChip',
      variants: const ['No seleccionado', 'Seleccionado'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => FilterChip(
        label: const Text('Categoría'),
        selected: state.variant == 'Seleccionado',
        onSelected: (_) {},
      ),
      flutterCodeBuilder: (state) => '''FilterChip(
  label: Text('Categoría'),
  selected: ${state.variant == 'Seleccionado'},
  onSelected: (_) {},
)''',
      dsBuilder: (state) => DSFilterChip(
        label: 'Categoría',
        isSelected: state.variant == 'Seleccionado',
        onTap: () {},
      ),
      dsCodeBuilder: (state) => '''DSFilterChip(
  label: 'Categoría',
  isSelected: ${state.variant == 'Seleccionado'},
  onTap: () {},
)''',
      advantages: const [
        'API simplificada',
        'Estados hover/pressed',
        'Checkmark con color de marca',
        'Pill shape',
      ],
      limitations: const [
        'Sin delete icon',
        'Solo filter (no input)',
      ],
    );
  }

  Widget _buildEmptyStateComparison() {
    return ComparisonPlayground(
      title: 'Empty State',
      subtitle: 'No existe equivalente nativo',
      variants: const ['Sin acción', 'Con acción'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      noFlutterEquivalent: 'Requiere composición manual de Column + Icon + Text',
      flutterBuilder: (state) => const SizedBox(),
      flutterCodeBuilder: (state) => '''// No hay equivalente nativo
// Requiere composición manual:
// Center + Column + Icon +
// Text (título) + Text (descripción) +
// ElevatedButton''',
      dsBuilder: (state) => SizedBox(
        height: 300,
        child: DSEmptyState(
          icon: Icons.shopping_cart_outlined,
          title: 'Carrito vacío',
          description: 'Agrega productos',
          actionText: state.variant == 'Con acción' ? 'Ver productos' : null,
          onAction: state.variant == 'Con acción' ? () {} : null,
          iconSize: DSSizes.iconXl,
        ),
      ),
      dsCodeBuilder: (state) => '''DSEmptyState(
  icon: Icons.shopping_cart_outlined,
  title: 'Carrito vacío',
  description: 'Agrega productos para continuar',
  ${state.variant == 'Con acción' ? "actionText: 'Ver productos',\n  onAction: () {}," : ''}
)''',
      advantages: const [
        'Pattern completo',
        'Layout consistente',
        'Botón opcional',
        'Ícono grande',
      ],
      limitations: const [
        'Sin ilustración custom',
        'Solo un botón',
      ],
    );
  }

  Widget _buildErrorStateComparison() {
    return ComparisonPlayground(
      title: 'Error State',
      subtitle: 'No existe equivalente nativo',
      variants: const ['Sin retry', 'Con retry'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      noFlutterEquivalent: 'Requiere composición manual con manejo de error',
      flutterBuilder: (state) => const SizedBox(),
      flutterCodeBuilder: (state) => '''// No hay equivalente nativo
// Requiere composición manual:
// Center + Column +
// Icon(Icons.error_outline, color: Colors.red) +
// Text (mensaje) + ElevatedButton (retry)''',
      dsBuilder: (state) => SizedBox(
        height: 300,
        child: DSErrorState(
          message: 'Error al cargar',
          details: 'Verifica tu conexión',
          onRetry: state.variant == 'Con retry' ? () {} : null,
        ),
      ),
      dsCodeBuilder: (state) => '''DSErrorState(
  message: 'Error al cargar productos',
  details: 'Verifica tu conexión',
  ${state.variant == 'Con retry' ? 'onRetry: () {},' : ''}
)''',
      advantages: const [
        'Pattern completo',
        'Color de error',
        'Retry integrado',
        'Detalles opcionales',
      ],
      limitations: const [
        'Sin código de error',
        'Sin botón secundario',
      ],
    );
  }

  Widget _buildLoadingStateComparison() {
    return ComparisonPlayground(
      title: 'Loading State',
      subtitle: 'CircularProgressIndicator centrado vs DSLoadingState',
      variants: const ['Sin mensaje', 'Con mensaje'],
      sizes: const ['Medium', 'Large'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              if (state.variant == 'Con mensaje') ...[
                const SizedBox(height: 8),
                const Text('Cargando...', style: TextStyle(fontSize: 12)),
              ],
            ],
          ),
        ),
      ),
      flutterCodeBuilder: (state) => '''Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircularProgressIndicator(),
      ${state.variant == 'Con mensaje' ? "SizedBox(height: 16),\n      Text('Cargando...')," : ''}
    ],
  ),
)''',
      dsBuilder: (state) => SizedBox(
        height: 150,
        child: DSLoadingState(
          message: state.variant == 'Con mensaje' ? 'Cargando productos...' : null,
          size: state.size == 'Large' ? DSLoaderSize.large : DSLoaderSize.medium,
        ),
      ),
      dsCodeBuilder: (state) => '''DSLoadingState(
  ${state.variant == 'Con mensaje' ? "message: 'Cargando productos...'," : ''}
  size: DSLoaderSize.${state.size.toLowerCase()},
)''',
      advantages: const [
        'Pattern completo',
        'Mensaje integrado',
        'Padding automático',
        'Centrado',
      ],
      limitations: const [
        'Sin modo determinado',
        'Sin skeleton mode',
      ],
    );
  }

  double _getElevation(String size) {
    switch (size) {
      case 'Elevation 0':
        return 0;
      case 'Elevation 2':
        return 4;
      default:
        return 2;
    }
  }

  int _getDsElevation(String size) {
    switch (size) {
      case 'Elevation 0':
        return 0;
      case 'Elevation 2':
        return 2;
      default:
        return 1;
    }
  }
}
