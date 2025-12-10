import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección de comparativas de componentes de organismo.
class OrganismsComparisonSection extends StatelessWidget {
  const OrganismsComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Comparativa de Organismos',
          subtitle: 'Secciones completas de interfaz',
        ),
        const SizedBox(height: DSSpacing.lg),
        _buildAppBarComparison(),
        _buildBottomNavComparison(),
        _buildProductGridComparison(context),
      ],
    );
  }

  Widget _buildAppBarComparison() {
    return ComparisonPlayground(
      title: 'AppBar',
      subtitle: 'AppBar vs DSAppBar',
      variants: const ['Simple', 'Con acciones'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => SizedBox(
        height: 56,
        child: AppBar(
          title: const Text('Productos'),
          actions: state.variant == 'Con acciones'
              ? [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ]
              : null,
        ),
      ),
      flutterCodeBuilder: (state) => '''AppBar(
  title: Text('Productos'),
  ${state.variant == 'Con acciones' ? '''actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
  ],''' : ''}
)''',
      dsBuilder: (state) => SizedBox(
        height: 56,
        child: DSAppBar(
          title: 'Productos',
          actions: state.variant == 'Con acciones'
              ? [
                  DSIconButton(
                    icon: Icons.search,
                    onPressed: () {},
                    tooltip: 'Buscar',
                  ),
                  DSIconButton(
                    icon: Icons.shopping_cart,
                    onPressed: () {},
                    tooltip: 'Carrito',
                  ),
                ]
              : null,
        ),
      ),
      dsCodeBuilder: (state) => '''DSAppBar(
  title: 'Productos',
  ${state.variant == 'Con acciones' ? '''actions: [
    DSIconButton(icon: Icons.search, onPressed: () {}, tooltip: 'Buscar'),
    DSIconButton(icon: Icons.shopping_cart, onPressed: () {}, tooltip: 'Carrito'),
  ],''' : ''}
)''',
      advantages: const [
        'Estilos de tokens',
        'Flat design (elevation 0)',
        'Sin tint M3',
        'Title string',
      ],
      limitations: const [
        'Sin SliverAppBar',
        'Sin flexibleSpace',
      ],
    );
  }

  Widget _buildBottomNavComparison() {
    return ComparisonPlayground(
      title: 'Bottom Navigation',
      subtitle: 'NavigationBar vs DSBottomNav',
      variants: const ['Sin badge', 'Con badge'],
      sizes: const ['Default'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) => SizedBox(
        height: 80,
        child: NavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            const NavigationDestination(
              icon: Icon(Icons.category_outlined),
              selectedIcon: Icon(Icons.category),
              label: 'Categorías',
            ),
            NavigationDestination(
              icon: state.variant == 'Con badge'
                  ? const Badge(
                      label: Text('3'),
                      child: Icon(Icons.shopping_cart_outlined),
                    )
                  : const Icon(Icons.shopping_cart_outlined),
              selectedIcon: const Icon(Icons.shopping_cart),
              label: 'Carrito',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
      flutterCodeBuilder: (state) => '''NavigationBar(
  selectedIndex: 0,
  destinations: [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Inicio',
    ),
    // ... más destinos
    NavigationDestination(
      icon: ${state.variant == 'Con badge' ? "Badge(label: Text('3'), child: Icon(...))" : 'Icon(Icons.shopping_cart_outlined)'},
      label: 'Carrito',
    ),
  ],
)''',
      dsBuilder: (state) => SizedBox(
        height: 64,
        child: DSBottomNav(
          currentIndex: 0,
          onTap: (_) {},
          items: [
            const DSBottomNavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Inicio',
            ),
            const DSBottomNavItem(
              icon: Icons.category_outlined,
              selectedIcon: Icons.category,
              label: 'Categorías',
            ),
            DSBottomNavItem(
              icon: Icons.shopping_cart_outlined,
              selectedIcon: Icons.shopping_cart,
              label: 'Carrito',
              badgeCount: state.variant == 'Con badge' ? 3 : null,
            ),
            const DSBottomNavItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Perfil',
            ),
          ],
        ),
      ),
      dsCodeBuilder: (state) => '''DSBottomNav(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    DSBottomNavItem(icon: Icons.home_outlined, label: 'Inicio'),
    DSBottomNavItem(icon: Icons.category_outlined, label: 'Categorías'),
    DSBottomNavItem(
      icon: Icons.shopping_cart_outlined,
      label: 'Carrito',
      ${state.variant == 'Con badge' ? 'badgeCount: 3,' : ''}
    ),
    DSBottomNavItem(icon: Icons.person_outline, label: 'Perfil'),
  ],
)''',
      advantages: const [
        'Badge integrado',
        'Overflow 99+',
        'Semantics completo',
        'SafeArea incluido',
        'Más compacto (64px)',
      ],
      limitations: const [
        'Sin animación de transición',
        'Sin indicador deslizante',
        'Sin mode rail',
      ],
    );
  }

  Widget _buildProductGridComparison(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return ComparisonPlayground(
      title: 'Product Grid',
      subtitle: 'GridView vs DSProductGrid',
      variants: const ['Con datos', 'Loading', 'Error', 'Vacío'],
      sizes: const ['2 columnas'],
      hasLoadingToggle: false,
      hasDisabledToggle: false,
      flutterBuilder: (state) {
        if (state.variant == 'Loading') {
          return SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 8),
                  Text(
                    'Cargando...',
                    style: TextStyle(color: tokens.colorTextSecondary),
                  ),
                ],
              ),
            ),
          );
        }
        if (state.variant == 'Error') {
          return SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: tokens.colorFeedbackError, size: 48),
                  const SizedBox(height: 8),
                  const Text('Error al cargar'),
                  TextButton(onPressed: () {}, child: const Text('Reintentar')),
                ],
              ),
            ),
          );
        }
        if (state.variant == 'Vacío') {
          return SizedBox(
            height: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inventory_2_outlined, color: tokens.colorTextTertiary, size: 48),
                  const SizedBox(height: 8),
                  const Text('No hay productos'),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: 150,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 2,
            itemBuilder: (_, i) => Card(
              child: Center(child: Text('Item ${i + 1}')),
            ),
          ),
        );
      },
      flutterCodeBuilder: (state) {
        if (state.variant == 'Con datos') {
          return '''GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.65,
  ),
  itemCount: products.length,
  itemBuilder: (_, i) => ProductCard(product: products[i]),
)''';
        }
        return '''// Manejo manual de estados:
if (isLoading) return CircularProgressIndicator();
if (error != null) return ErrorWidget();
if (products.isEmpty) return EmptyWidget();
return GridView.builder(...);''';
      },
      dsBuilder: (state) {
        return SizedBox(
          height: 150,
          child: DSProductGrid<_MockProduct>(
            products: state.variant == 'Con datos' ? _mockProducts : null,
            isLoading: state.variant == 'Loading',
            error: state.variant == 'Error' ? 'Error al cargar' : null,
            onRetry: () {},
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            itemBuilder: (_, product, __) => DSCard(
              child: Center(child: Text(product.title)),
            ),
            emptyMessage: 'No hay productos',
            loadingMessage: 'Cargando...',
          ),
        );
      },
      dsCodeBuilder: (state) => '''DSProductGrid<Product>(
  products: ${state.variant == 'Con datos' ? 'products' : 'null'},
  isLoading: ${state.variant == 'Loading'},
  error: ${state.variant == 'Error' ? "'Error al cargar'" : 'null'},
  onRetry: () => loadProducts(),
  crossAxisCount: 2,
  itemBuilder: (_, product, __) => DSProductCard(...),
)''',
      advantages: const [
        'Estados integrados',
        'Loading automático',
        'Error con retry',
        'Empty state',
        'Genérico tipado',
      ],
      limitations: const [
        'Sin SliverGrid',
        'Sin paginación',
        'Sin pull-to-refresh',
        'Grid fijo',
      ],
    );
  }
}

// Mock data for demo
class _MockProduct {
  final String title;
  const _MockProduct(this.title);
}

final _mockProducts = [
  const _MockProduct('Producto 1'),
  const _MockProduct('Producto 2'),
];
