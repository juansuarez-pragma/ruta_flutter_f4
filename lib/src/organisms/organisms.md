# Organismos del Sistema de Diseño

Componentes de alto nivel que combinan múltiples átomos y moléculas para formar secciones completas de interfaz.

---

# DSAppBar

Barra de aplicación del sistema de diseño con estilos consistentes.

## Propósito

- Proporcionar navegación y contexto de pantalla.
- Mostrar título y acciones principales.
- Mantener consistencia visual en toda la aplicación.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `title` | `String?` | `null` | Título de texto. |
| `titleWidget` | `Widget?` | `null` | Widget de título personalizado. |
| `leading` | `Widget?` | `null` | Widget izquierdo (ej: botón back). |
| `automaticallyImplyLeading` | `bool` | `true` | Si muestra botón back automático. |
| `actions` | `List<Widget>?` | `null` | Lista de acciones (derecha). |
| `centerTitle` | `bool` | `true` | Si centra el título. |
| `elevation` | `double` | `0` | Elevación de la barra. |
| `backgroundColor` | `Color?` | `colorSurfacePrimary` | Color de fondo. |
| `foregroundColor` | `Color?` | `colorTextPrimary` | Color de texto/íconos. |
| `bottom` | `PreferredSizeWidget?` | `null` | Widget inferior (ej: TabBar). |
| `toolbarHeight` | `double` | `kToolbarHeight` | Altura de la barra. |

## Tokens usados

- **Fondo**: `colorSurfacePrimary`.
- **Texto**: `colorTextPrimary`, `typographyTitleLarge`.
- **Transparencia**: `DSColors.transparent` (surfaceTintColor).

## Implementa

`PreferredSizeWidget` - Compatible con `Scaffold.appBar`.

## Cuándo usar

- Todas las pantallas que requieren navegación.
- Pantallas con acciones contextuales.
- Flujos con TabBar integrado.

## Cuándo NO usar

- Pantallas sin navegación (splash, onboarding simple).
- Dentro de otros AppBars (evitar anidación).

## Anti-patrones

- Demasiadas acciones (máximo 2-3 íconos).
- Títulos muy largos que se truncan.
- Usar elevation alta sin propósito.

## Snippets rápidos

### AppBar básico

```dart
Scaffold(
  appBar: DSAppBar(title: 'Productos'),
  body: ...,
)
```

### Con acciones

```dart
DSAppBar(
  title: 'Productos',
  actions: [
    DSIconButton(
      icon: Icons.search,
      onPressed: () => openSearch(),
    ),
    DSIconButton(
      icon: Icons.shopping_cart,
      onPressed: () => openCart(),
    ),
  ],
)
```

### Con TabBar

```dart
DSAppBar(
  title: 'Categorías',
  bottom: TabBar(
    tabs: [
      Tab(text: 'Todos'),
      Tab(text: 'Electrónica'),
      Tab(text: 'Ropa'),
    ],
  ),
)
```

### Sin botón back automático

```dart
DSAppBar(
  title: 'Inicio',
  automaticallyImplyLeading: false,
)
```

### Con título personalizado

```dart
DSAppBar(
  titleWidget: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.store),
      SizedBox(width: DSSpacing.sm),
      Text('Fake Store'),
    ],
  ),
)
```

---

# DSBottomNav

Barra de navegación inferior con soporte para badges y accesibilidad.

## Propósito

- Proporcionar navegación principal entre secciones.
- Mostrar indicadores de contenido (badges con contadores).
- Comunicar estado de selección claramente.

## API

### DSBottomNav

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `currentIndex` | `int` | — | Índice seleccionado (requerido). |
| `onTap` | `ValueChanged<int>` | — | Callback de selección (requerido). |
| `items` | `List<DSBottomNavItem>` | — | Lista de items (requerido). |
| `backgroundColor` | `Color?` | `colorSurfacePrimary` | Color de fondo. |
| `elevation` | `double` | `0` | Elevación (activa sombra). |

### DSBottomNavItem

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `IconData` | — | Ícono del item (requerido). |
| `selectedIcon` | `IconData?` | `null` | Ícono cuando está seleccionado. |
| `label` | `String` | — | Etiqueta del item (requerido). |
| `badgeCount` | `int?` | `null` | Contador del badge. |

## Tokens usados

- **Fondo**: `colorSurfacePrimary`.
- **Borde superior**: `colorBorderSecondary`, `DSSizes.borderThin`.
- **Ícono seleccionado**: `colorBrandPrimary`.
- **Ícono no seleccionado**: `colorIconSecondary`.
- **Badge fondo**: `colorFeedbackError`.
- **Badge texto**: `colorTextInverse`.
- **Tipografía**: `DSFontSize.labelSmall`, `DSFontWeight.medium|regular`.
- **Ícono**: `DSSizes.iconBase`.
- **Espaciado badge**: `DSSpacing.xs`, `DSSpacing.xxs`.
- **Radio badge**: `DSBorderRadius.full`.
- **Elevación**: `elevationLevel2` (si `elevation > 0`).

## Accesibilidad

El componente implementa accesibilidad completa:

```dart
Semantics(
  selected: isSelected,
  button: true,
  label: '${item.label}$badgeInfo$selectedInfo, $positionInfo',
  // Ejemplo: "Cart, 3 items, selected, Tab 3 of 4"
)
```

- **Posición**: "Tab X of Y" para orientación.
- **Badge**: "N items" cuando hay contador.
- **Estado**: "selected" cuando está activo.

## Estructura visual

```
┌─────────────────────────────────────────────────────┐
│  [🏠]      [📦]      [🛒]         [👤]              │
│  Home    Products   Cart(3)     Profile            │
│                       ↑                             │
│                    Badge con contador               │
└─────────────────────────────────────────────────────┘
```

## Cuándo usar

- Navegación principal de la aplicación.
- 3-5 destinos principales.
- Cuando el usuario necesita cambiar frecuentemente entre secciones.

## Cuándo NO usar

- Menos de 3 destinos (usa otro patrón).
- Más de 5 destinos (considera drawer o tabs).
- Flujos lineales (usa botones de navegación).

## Anti-patrones

- Labels muy largos que se truncan.
- Demasiados badges activos simultáneamente.
- Íconos que no representan la sección.

## Snippets rápidos

### Navegación básica

```dart
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    DSBottomNavItem(icon: Icons.home, label: 'Inicio'),
    DSBottomNavItem(icon: Icons.category, label: 'Categorías'),
    DSBottomNavItem(icon: Icons.shopping_cart, label: 'Carrito'),
    DSBottomNavItem(icon: Icons.person, label: 'Perfil'),
  ],
)
```

### Con badges

```dart
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: onTabSelected,
  items: [
    DSBottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Inicio',
    ),
    DSBottomNavItem(
      icon: Icons.notifications_outlined,
      selectedIcon: Icons.notifications,
      label: 'Alertas',
      badgeCount: unreadCount, // Muestra badge si > 0
    ),
    DSBottomNavItem(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      label: 'Carrito',
      badgeCount: cartItemCount,
    ),
    DSBottomNavItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Perfil',
    ),
  ],
)
```

### Con elevación

```dart
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: onTabSelected,
  elevation: 1, // Activa sombra
  items: [...],
)
```

### Integración con Scaffold

```dart
Scaffold(
  appBar: DSAppBar(title: 'Fake Store'),
  body: IndexedStack(
    index: selectedIndex,
    children: [
      HomePage(),
      CategoriesPage(),
      CartPage(),
      ProfilePage(),
    ],
  ),
  bottomNavigationBar: DSBottomNav(
    currentIndex: selectedIndex,
    onTap: (index) => setState(() => selectedIndex = index),
    items: navItems,
  ),
)
```

---

# DSProductGrid

Grid de productos con manejo integrado de estados de carga, error y vacío.

## Propósito

- Mostrar catálogos de productos en formato grid.
- Manejar automáticamente estados de UI (loading, error, empty).
- Proporcionar API genérica adaptable a cualquier modelo de producto.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `products` | `List<T>?` | `null` | Lista de productos. |
| `isLoading` | `bool` | `false` | Si está cargando. |
| `error` | `String?` | `null` | Mensaje de error. |
| `onProductTap` | `void Function(T)?` | `null` | Callback al tocar producto. |
| `onAddToCart` | `void Function(T)?` | `null` | Callback de agregar al carrito. |
| `onRetry` | `VoidCallback?` | `null` | Callback para reintentar. |
| `crossAxisCount` | `int` | `2` | Número de columnas. |
| `childAspectRatio` | `double` | `0.65` | Proporción de cada item. |
| `crossAxisSpacing` | `double` | `DSSpacing.md` | Espacio horizontal. |
| `mainAxisSpacing` | `double` | `DSSpacing.md` | Espacio vertical. |
| `padding` | `EdgeInsetsGeometry` | `DSSpacing.base` | Padding del grid. |
| `itemBuilder` | `Widget Function(BuildContext, T, int)?` | `null` | Builder personalizado. |
| `emptyMessage` | `String` | `'No hay productos...'` | Mensaje de estado vacío. |
| `loadingMessage` | `String` | `'Cargando productos...'` | Mensaje de carga. |

## Comportamiento de estados

```
┌─────────────────────────────────────────────┐
│                                             │
│   isLoading == true                         │
│         ↓                                   │
│   DSLoadingState(message: loadingMessage)   │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│   error != null                             │
│         ↓                                   │
│   DSErrorState(message: error, onRetry)     │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│   products == null || products.isEmpty      │
│         ↓                                   │
│   DSEmptyState(title: emptyMessage)         │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│   products.isNotEmpty                       │
│         ↓                                   │
│   GridView.builder con DSProductCard        │
│                                             │
└─────────────────────────────────────────────┘
```

## Tokens usados

- **Grid**: `DSSpacing.md` (spacing), `DSSpacing.base` (padding).
- **Estados**: Hereda de `DSLoadingState`, `DSErrorState`, `DSEmptyState`.
- **Cards**: Hereda de `DSProductCard`.

## Builder por defecto

Si no se proporciona `itemBuilder`, el componente intenta acceder dinámicamente:

```dart
DSProductCard(
  imageUrl: product.image,      // Requiere propiedad 'image'
  title: product.title,         // Requiere propiedad 'title'
  price: product.price,         // Requiere propiedad 'price'
  rating: product.rating?.rate, // Opcional
  reviewCount: product.rating?.count, // Opcional
)
```

## Cuándo usar

- Catálogos de productos.
- Resultados de búsqueda.
- Listados de categorías.
- Cualquier colección de productos.

## Cuándo NO usar

- Listas verticales simples (usa ListView).
- Un solo producto (usa DSProductCard directamente).
- Grids no relacionados con productos (usa GridView).

## Anti-patrones

- Ignorar el estado de error (siempre manejar).
- No proporcionar `onRetry` cuando hay error.
- Columnas excesivas en móvil (máximo 2-3).

## Snippets rápidos

### Grid básico

```dart
DSProductGrid(
  products: products,
  onProductTap: (product) => viewProduct(product),
)
```

### Con todos los estados

```dart
DSProductGrid(
  products: products,
  isLoading: isLoading,
  error: errorMessage,
  onProductTap: (product) => viewProduct(product),
  onAddToCart: (product) => addToCart(product),
  onRetry: () => loadProducts(),
)
```

### Con builder personalizado

```dart
DSProductGrid<MyProduct>(
  products: products,
  itemBuilder: (context, product, index) {
    return DSProductCard(
      imageUrl: product.imageUrl,
      title: product.name,
      price: product.currentPrice,
      badge: product.isOnSale ? 'Oferta' : null,
      badgeType: DSBadgeType.error,
      onTap: () => onProductTap(product),
    );
  },
)
```

### Configuración de grid

```dart
DSProductGrid(
  products: products,
  crossAxisCount: 3,          // 3 columnas
  childAspectRatio: 0.55,     // Más alto
  crossAxisSpacing: DSSpacing.sm,
  mainAxisSpacing: DSSpacing.sm,
  padding: EdgeInsets.all(DSSpacing.sm),
  onProductTap: viewProduct,
)
```

### Mensajes personalizados

```dart
DSProductGrid(
  products: searchResults,
  emptyMessage: 'No encontramos productos con "$query"',
  loadingMessage: 'Buscando productos...',
  isLoading: isSearching,
  onProductTap: viewProduct,
)
```

### Integración completa

```dart
class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product>? products;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await api.getProducts();
      setState(() {
        products = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Error al cargar productos';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSAppBar(title: 'Productos'),
      body: DSProductGrid(
        products: products,
        isLoading: isLoading,
        error: error,
        onProductTap: (p) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: p),
          ),
        ),
        onAddToCart: (p) => cartService.add(p),
        onRetry: loadProducts,
      ),
    );
  }
}
```

## Tabla de configuraciones responsive

| Dispositivo | crossAxisCount | childAspectRatio | Recomendación |
| --- | --- | --- | --- |
| Móvil portrait | 2 | 0.65 | Default |
| Móvil landscape | 3 | 0.7 | Más columnas |
| Tablet portrait | 3 | 0.65 | Similar a móvil |
| Tablet landscape | 4 | 0.7 | Grid más denso |
| Desktop | 4-6 | 0.75 | Según ancho disponible |

```dart
// Ejemplo responsive
DSProductGrid(
  products: products,
  crossAxisCount: context.isTablet ? 3 : 2,
  childAspectRatio: context.isTablet ? 0.7 : 0.65,
  onProductTap: viewProduct,
)
```
