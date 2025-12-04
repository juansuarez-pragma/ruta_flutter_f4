import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';

/// Página de demostración de componentes moleculares.
class MoleculesPage extends StatelessWidget {
  const MoleculesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(DSSpacing.lg),
      children: const [
        _CardsSection(),
        _ProductCardsSection(),
        _ChipsSection(),
        _EmptyStatesSection(),
      ],
    );
  }
}

// =============================================================================
// CARDS SECTION
// =============================================================================

class _CardsSection extends StatelessWidget {
  const _CardsSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Cards',
          subtitle: 'DSCard como contenedor base para contenido',
        ),
        // Card básica
        ComponentCard(
          title: 'Card Básica',
          description: 'Contenedor simple con elevación y bordes redondeados',
          code: '''
DSCard(
  padding: EdgeInsets.all(DSSpacing.lg),
  child: Text('Contenido de la card'),
)''',
          child: DSCard(
            padding: const EdgeInsets.all(DSSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: tokens.colorIconSecondary),
                const SizedBox(width: DSSpacing.md),
                Expanded(
                  child: Text(
                    'Esta es una card básica con contenido de ejemplo.',
                    style: tokens.typographyBodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Card interactiva
        ComponentCard(
          title: 'Card Interactiva',
          description: 'Card con callback onTap para navegación',
          code: '''
DSCard(
  padding: EdgeInsets.all(DSSpacing.lg),
  onTap: () => print('Card tapped'),
  child: Text('Toca esta card'),
)''',
          child: DSCard(
            padding: const EdgeInsets.all(DSSpacing.lg),
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.touch_app, color: tokens.colorBrandPrimary),
                const SizedBox(width: DSSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Interactiva',
                        style: tokens.typographyTitleMedium,
                      ),
                      const SizedBox(height: DSSpacing.xs),
                      Text(
                        'Toca para ver el efecto de hover/press',
                        style: tokens.typographyBodySmall.copyWith(
                          color: tokens.colorTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: tokens.colorIconSecondary),
              ],
            ),
          ),
        ),
        // Niveles de elevación
        const ComponentCard(
          title: 'Niveles de Elevación',
          description: 'Cards con diferentes niveles de sombra',
          code: '''
DSCard(
  elevation: 0,
  child: Text('Sin elevación'),
)

DSCard(
  elevation: 1,
  child: Text('Elevación 1'),
)

DSCard(
  elevation: 2,
  child: Text('Elevación 2'),
)''',
          child: Wrap(
            spacing: DSSpacing.lg,
            runSpacing: DSSpacing.lg,
            children: [
              _ElevatedCard(level: 0),
              _ElevatedCard(level: 1),
              _ElevatedCard(level: 2),
              _ElevatedCard(level: 3),
            ],
          ),
        ),
      ],
    );
  }
}

class _ElevatedCard extends StatelessWidget {
  final int level;

  const _ElevatedCard({required this.level});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DSCard(
      elevation: level,
      padding: const EdgeInsets.all(DSSpacing.lg),
      child: SizedBox(
        width: 120,
        child: Column(
          children: [
            Text('Nivel $level', style: tokens.typographyTitleSmall),
            const SizedBox(height: DSSpacing.xs),
            Text(
              'elevation: $level',
              style: tokens.typographyCaption.copyWith(
                color: tokens.colorTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// PRODUCT CARDS SECTION
// =============================================================================

class _ProductCardsSection extends StatelessWidget {
  const _ProductCardsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Product Cards',
          subtitle: 'DSProductCard para mostrar productos',
        ),
        // Product Card básica
        ComponentCard(
          title: 'Product Card Básica',
          description: 'Card de producto con imagen, título y precio',
          code: '''
DSProductCard(
  imageUrl: 'https://example.com/image.jpg',
  title: 'Producto de Ejemplo',
  price: 99.99,
  onTap: () => viewProduct(),
)''',
          child: SizedBox(
            height: 280,
            child: Row(
              children: [
                Expanded(
                  child: DSProductCard(
                    imageUrl:
                        'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                    title: 'Backpack Premium',
                    price: 109.95,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: DSSpacing.lg),
                Expanded(
                  child: DSProductCard(
                    imageUrl:
                        'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
                    title: 'Slim Fit T-Shirt',
                    price: 22.30,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        // Con rating y badge
        ComponentCard(
          title: 'Con Rating y Badge',
          description: 'Product card completa con todas las opciones',
          code: '''
DSProductCard(
  imageUrl: 'https://example.com/image.jpg',
  title: 'Producto Premium',
  price: 149.99,
  rating: 4.5,
  reviewCount: 120,
  badge: 'Nuevo',
  badgeType: DSBadgeType.success,
  onTap: () => viewProduct(),
  onAddToCart: () => addToCart(),
)''',
          child: SizedBox(
            height: 300,
            child: Row(
              children: [
                Expanded(
                  child: DSProductCard(
                    imageUrl:
                        'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
                    title: 'Mens Cotton Jacket',
                    price: 55.99,
                    rating: 4.7,
                    reviewCount: 500,
                    badge: 'Nuevo',
                    badgeType: DSBadgeType.success,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                ),
                const SizedBox(width: DSSpacing.lg),
                Expanded(
                  child: DSProductCard(
                    imageUrl:
                        'https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg',
                    title: 'Gold Dragon Ring',
                    price: 695.00,
                    rating: 4.6,
                    reviewCount: 400,
                    badge: 'Oferta',
                    badgeType: DSBadgeType.warning,
                    onTap: () {},
                    onAddToCart: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// CHIPS SECTION
// =============================================================================

class _ChipsSection extends StatefulWidget {
  const _ChipsSection();

  @override
  State<_ChipsSection> createState() => _ChipsSectionState();
}

class _ChipsSectionState extends State<_ChipsSection> {
  String _selectedCategory = 'electronics';

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('all', 'Todos', Icons.grid_view),
      ('electronics', 'Electrónicos', Icons.devices),
      ('jewelery', 'Joyería', Icons.diamond),
      ('mens', "Hombres", Icons.man),
      ('womens', 'Mujeres', Icons.woman),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Filter Chips',
          subtitle: 'DSFilterChip para filtros seleccionables',
        ),
        // Chips básicos
        ComponentCard(
          title: 'Filter Chips',
          description: 'Chips para seleccionar categorías u opciones',
          code: '''
DSFilterChip(
  label: 'Electrónicos',
  isSelected: selectedCategory == 'electronics',
  onTap: () => selectCategory('electronics'),
)

// Con ícono
DSFilterChip(
  label: 'Joyería',
  icon: Icons.diamond,
  isSelected: false,
  onTap: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.sm,
            runSpacing: DSSpacing.sm,
            children: categories.map((cat) {
              return DSFilterChip(
                label: cat.$2,
                icon: cat.$3,
                isSelected: _selectedCategory == cat.$1,
                onTap: () {
                  setState(() => _selectedCategory = cat.$1);
                },
              );
            }).toList(),
          ),
        ),
        // Solo texto
        ComponentCard(
          title: 'Chips sin Ícono',
          description: 'Chips simples solo con texto',
          code: '''
DSFilterChip(
  label: 'Opción A',
  isSelected: true,
  onTap: () {},
)''',
          child: Wrap(
            spacing: DSSpacing.sm,
            runSpacing: DSSpacing.sm,
            children: [
              DSFilterChip(
                label: 'Ordenar por precio',
                isSelected: false,
                onTap: () {},
              ),
              DSFilterChip(
                label: 'Más vendidos',
                isSelected: true,
                onTap: () {},
              ),
              DSFilterChip(
                label: 'Mejor valorados',
                isSelected: false,
                onTap: () {},
              ),
              DSFilterChip(label: 'Ofertas', isSelected: false, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// EMPTY STATES SECTION
// =============================================================================

class _EmptyStatesSection extends StatelessWidget {
  const _EmptyStatesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Empty States',
          subtitle: 'Estados vacíos, de error y de carga',
        ),
        // Empty State
        const ComponentCard(
          title: 'DSEmptyState',
          description: 'Vista para cuando no hay contenido',
          code: '''
DSEmptyState(
  icon: Icons.shopping_cart_outlined,
  title: 'Carrito vacío',
  description: 'Agrega productos para continuar',
  actionText: 'Ver productos',
  onAction: () => navigateToProducts(),
)''',
          child: DSEmptyState(
            icon: Icons.shopping_cart_outlined,
            title: 'Carrito vacío',
            description: 'Agrega productos para comenzar a comprar',
            actionText: 'Ver productos',
          ),
        ),
        // Error State
        ComponentCard(
          title: 'DSErrorState',
          description: 'Vista para mostrar errores con opción de reintentar',
          code: '''
DSErrorState(
  message: 'Error al cargar productos',
  details: 'Verifica tu conexión a internet',
  onRetry: () => loadProducts(),
)''',
          child: DSErrorState(
            message: 'Error al cargar productos',
            details: 'Verifica tu conexión a internet',
            onRetry: () {},
          ),
        ),
        // Loading State
        const ComponentCard(
          title: 'DSLoadingState',
          description: 'Vista de carga con mensaje opcional',
          code: '''
DSLoadingState(
  message: 'Cargando productos...',
)''',
          child: SizedBox(
            height: 200,
            child: DSLoadingState(message: 'Cargando productos...'),
          ),
        ),
        // Empty State variante
        const ComponentCard(
          title: 'DSEmptyState - Sin Resultados',
          description: 'Vista cuando una búsqueda no tiene resultados',
          code: '''
DSEmptyState(
  icon: Icons.search_off,
  title: 'Sin resultados',
  description: 'No encontramos productos con ese criterio',
)''',
          child: DSEmptyState(
            icon: Icons.search_off,
            title: 'Sin resultados',
            description:
                'No encontramos productos que coincidan con tu búsqueda',
          ),
        ),
      ],
    );
  }
}
