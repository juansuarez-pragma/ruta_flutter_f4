import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';

/// Página de demostración de componentes de organismo.
class OrganismsPage extends StatelessWidget {
  const OrganismsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(DSSpacing.lg),
      children: const [
        _AppBarSection(),
        _ProductGridSection(),
        _BottomNavSection(),
      ],
    );
  }
}

// =============================================================================
// APP BAR SECTION
// =============================================================================

class _AppBarSection extends StatelessWidget {
  const _AppBarSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'App Bar',
          subtitle: 'DSAppBar personalizado para la aplicación',
        ),
        // AppBar básico
        ComponentCard(
          title: 'AppBar Básico',
          description: 'AppBar con título simple',
          code: '''
DSAppBar(
  title: 'Productos',
)''',
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.colorBorderSecondary),
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: const DSAppBar(title: 'Productos'),
          ),
        ),
        // Con actions
        ComponentCard(
          title: 'AppBar con Actions',
          description: 'AppBar con botones de acción',
          code: '''
DSAppBar(
  title: 'Fake Store',
  actions: [
    DSIconButton(
      icon: Icons.search,
      variant: DSButtonVariant.ghost,
      onPressed: () {},
    ),
    DSIconButton(
      icon: Icons.shopping_cart,
      variant: DSButtonVariant.ghost,
      onPressed: () {},
    ),
  ],
)''',
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.colorBorderSecondary),
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: DSAppBar(
              title: 'Fake Store',
              actions: [
                DSIconButton(
                  icon: Icons.search,
                  variant: DSButtonVariant.ghost,
                  onPressed: () {},
                  tooltip: 'Buscar',
                ),
                DSIconButton(
                  icon: Icons.shopping_cart,
                  variant: DSButtonVariant.ghost,
                  onPressed: () {},
                  tooltip: 'Carrito',
                ),
              ],
            ),
          ),
        ),
        // Con leading
        ComponentCard(
          title: 'AppBar con Leading',
          description: 'AppBar con botón de navegación',
          code: '''
DSAppBar(
  title: 'Detalle del Producto',
  leading: DSIconButton(
    icon: Icons.arrow_back,
    variant: DSButtonVariant.ghost,
    onPressed: () => Navigator.pop(context),
  ),
)''',
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.colorBorderSecondary),
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: DSAppBar(
              title: 'Detalle del Producto',
              leading: DSIconButton(
                icon: Icons.arrow_back,
                variant: DSButtonVariant.ghost,
                onPressed: () {},
                tooltip: 'Volver',
              ),
              actions: [
                DSIconButton(
                  icon: Icons.favorite_border,
                  variant: DSButtonVariant.ghost,
                  onPressed: () {},
                  tooltip: 'Favorito',
                ),
                DSIconButton(
                  icon: Icons.share,
                  variant: DSButtonVariant.ghost,
                  onPressed: () {},
                  tooltip: 'Compartir',
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
// PRODUCT GRID SECTION
// =============================================================================

class _ProductGridSection extends StatelessWidget {
  const _ProductGridSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    // Productos de ejemplo
    final products = [
      const _MockProduct(
        imageUrl: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
        title: 'Backpack Premium',
        price: 109.95,
        rating: 3.9,
        reviewCount: 120,
      ),
      const _MockProduct(
        imageUrl:
            'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
        title: 'Slim Fit T-Shirt',
        price: 22.30,
        rating: 4.1,
        reviewCount: 259,
      ),
      const _MockProduct(
        imageUrl: 'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
        title: 'Mens Cotton Jacket',
        price: 55.99,
        rating: 4.7,
        reviewCount: 500,
      ),
      const _MockProduct(
        imageUrl:
            'https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg',
        title: 'Gold Dragon Ring',
        price: 695.00,
        rating: 4.6,
        reviewCount: 400,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Product Grid',
          subtitle: 'DSProductGrid para mostrar listados de productos',
        ),
        ComponentCard(
          title: 'Grid de Productos',
          description: 'Grid responsive con DSProductCard usando itemBuilder',
          code: '''
DSProductGrid<Product>(
  products: products,
  crossAxisCount: 2,
  childAspectRatio: 0.65,
  itemBuilder: (context, product, index) =>
    DSProductCard(
      imageUrl: product.imageUrl,
      title: product.title,
      price: product.price,
      rating: product.rating,
      reviewCount: product.reviewCount,
      onTap: () => viewProduct(product),
      onAddToCart: () => addToCart(product),
    ),
)''',
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              color: tokens.colorSurfaceSecondary,
              borderRadius: BorderRadius.circular(DSBorderRadius.base),
            ),
            padding: const EdgeInsets.all(DSSpacing.md),
            child: DSProductGrid<_MockProduct>(
              products: products,
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              itemBuilder: (context, product, index) => DSProductCard(
                imageUrl: product.imageUrl,
                title: product.title,
                price: product.price,
                rating: product.rating,
                reviewCount: product.reviewCount,
                onTap: () {},
                onAddToCart: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MockProduct {
  final String imageUrl;
  final String title;
  final double price;
  final double rating;
  final int reviewCount;

  const _MockProduct({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviewCount,
  });
}

// =============================================================================
// BOTTOM NAV SECTION
// =============================================================================

class _BottomNavSection extends StatefulWidget {
  const _BottomNavSection();

  @override
  State<_BottomNavSection> createState() => _BottomNavSectionState();
}

class _BottomNavSectionState extends State<_BottomNavSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Bottom Navigation',
          subtitle: 'DSBottomNav para navegación principal',
        ),
        // BottomNav básico
        ComponentCard(
          title: 'Bottom Navigation',
          description: 'Navegación inferior con 4 items',
          code: '''
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    DSBottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Inicio',
    ),
    DSBottomNavItem(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      label: 'Categorías',
    ),
    DSBottomNavItem(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      label: 'Carrito',
      badgeCount: 3,
    ),
    DSBottomNavItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Perfil',
    ),
  ],
)''',
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.colorBorderSecondary),
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: DSBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: const [
                DSBottomNavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Inicio',
                ),
                DSBottomNavItem(
                  icon: Icons.category_outlined,
                  selectedIcon: Icons.category,
                  label: 'Categorías',
                ),
                DSBottomNavItem(
                  icon: Icons.shopping_cart_outlined,
                  selectedIcon: Icons.shopping_cart,
                  label: 'Carrito',
                  badgeCount: 3,
                ),
                DSBottomNavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
        // Con elevación
        ComponentCard(
          title: 'Bottom Navigation con Elevación',
          description: 'Navegación con sombra',
          code: '''
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: (index) {},
  elevation: 2,
  items: [...],
)''',
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: tokens.colorBorderSecondary),
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            clipBehavior: Clip.antiAlias,
            child: DSBottomNav(
              currentIndex: 2,
              onTap: (index) {},
              elevation: 2,
              items: const [
                DSBottomNavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Inicio',
                ),
                DSBottomNavItem(icon: Icons.search, label: 'Buscar'),
                DSBottomNavItem(
                  icon: Icons.favorite_outline,
                  selectedIcon: Icons.favorite,
                  label: 'Favoritos',
                  badgeCount: 12,
                ),
                DSBottomNavItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: 'Ajustes',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: DSSpacing.xxl),
      ],
    );
  }
}
