# Getting Started

Este tutorial te guiará paso a paso para crear tu primera pantalla usando el Fake Store Design System.

**Tiempo estimado:** 15 minutos
**Nivel:** Principiante
**Resultado:** Una pantalla de lista de productos funcional

## Tabla de Contenidos

- [Prerequisitos](#prerequisitos)
- [Paso 1: Crear proyecto](#paso-1-crear-proyecto)
- [Paso 2: Agregar el Design System](#paso-2-agregar-el-design-system)
- [Paso 3: Configurar el tema](#paso-3-configurar-el-tema)
- [Paso 4: Crear la página principal](#paso-4-crear-la-página-principal)
- [Paso 5: Agregar navegación](#paso-5-agregar-navegación)
- [Paso 6: Mostrar productos](#paso-6-mostrar-productos)
- [Paso 7: Agregar interactividad](#paso-7-agregar-interactividad)
- [Siguiente paso](#siguiente-paso)

---

## Prerequisitos

Antes de comenzar, asegúrate de tener:

- [ ] Flutter instalado ([guía oficial](https://flutter.dev/docs/get-started/install))
- [ ] Un editor de código (VS Code o Android Studio recomendados)
- [ ] Acceso al paquete `fake_store_design_system`

Verifica tu instalación:

```bash
flutter doctor
```

---

## Paso 1: Crear proyecto

Crea un nuevo proyecto Flutter:

```bash
flutter create mi_tienda
cd mi_tienda
```

Verifica que funcione:

```bash
flutter run
```

> 🎉 **Checkpoint:** Deberías ver la app de contador por defecto de Flutter.

---

## Paso 2: Agregar el Design System

Edita `pubspec.yaml` y agrega la dependencia:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fake_store_design_system:
    path: ../fake_store_design_system  # Ajusta según tu estructura
```

Instala las dependencias:

```bash
flutter pub get
```

> 💡 **Tip:** Si el paquete está en otra ubicación, ajusta la ruta relativa.

---

## Paso 3: Configurar el tema

Abre `lib/main.dart` y reemplaza **todo** el contenido con:

```dart
import 'package:flutter/material.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  runApp(const MiTiendaApp());
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Tienda',
      debugShowCheckedModeBanner: false,

      // ✨ Configuración del Design System
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: ThemeMode.system,

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DSText.headingLarge('¡Hola Design System!'),
      ),
    );
  }
}
```

Ejecuta la app:

```bash
flutter run
```

> 🎉 **Checkpoint:** Deberías ver "¡Hola Design System!" con la tipografía del DS.

---

## Paso 4: Crear la página principal

Ahora vamos a agregar el AppBar y estructura básica. Modifica `HomePage`:

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder a los tokens del tema
    final tokens = context.tokens;

    return Scaffold(
      // AppBar del Design System
      appBar: DSAppBar(
        title: 'Mi Tienda',
        actions: [
          DSIconButton(
            icon: Icons.search,
            tooltip: 'Buscar',
            onPressed: () {
              // TODO: Implementar búsqueda
            },
          ),
        ],
      ),

      // Fondo usando tokens
      backgroundColor: tokens.colorSurfacePrimary,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DSText.headingMedium('Bienvenido'),
            const SizedBox(height: DSSpacing.md),
            DSText.bodyMedium(
              'Tu tienda favorita',
              color: tokens.colorTextSecondary,
            ),
            const SizedBox(height: DSSpacing.xl),
            DSButton.primary(
              text: 'Ver productos',
              icon: Icons.shopping_bag,
              onPressed: () {
                // TODO: Navegar a productos
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

> 🎉 **Checkpoint:** Deberías ver el AppBar con título y botón de búsqueda.

---

## Paso 5: Agregar navegación

Vamos a agregar navegación inferior. Convierte `HomePage` a StatefulWidget:

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      appBar: DSAppBar(
        title: _getTitle(),
        actions: [
          DSIconButton(
            icon: Icons.search,
            tooltip: 'Buscar',
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: tokens.colorSurfacePrimary,

      // Contenido según tab seleccionado
      body: _buildBody(),

      // Navegación inferior del Design System
      bottomNavigationBar: DSBottomNav(
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
            badgeCount: 3,  // ← Badge con contador
          ),
          DSBottomNavItem(
            icon: Icons.person_outline,
            selectedIcon: Icons.person,
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0: return 'Mi Tienda';
      case 1: return 'Categorías';
      case 2: return 'Carrito';
      case 3: return 'Perfil';
      default: return 'Mi Tienda';
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: return _buildHome();
      case 1: return _buildCategories();
      case 2: return _buildCart();
      case 3: return _buildProfile();
      default: return _buildHome();
    }
  }

  Widget _buildHome() {
    return const Center(child: DSText.bodyMedium('Pantalla de Inicio'));
  }

  Widget _buildCategories() {
    return const Center(child: DSText.bodyMedium('Pantalla de Categorías'));
  }

  Widget _buildCart() {
    return const Center(child: DSText.bodyMedium('Pantalla de Carrito'));
  }

  Widget _buildProfile() {
    return const Center(child: DSText.bodyMedium('Pantalla de Perfil'));
  }
}
```

> 🎉 **Checkpoint:** Deberías poder navegar entre 4 tabs con el carrito mostrando un badge "3".

---

## Paso 6: Mostrar productos

Ahora vamos a crear una lista de productos. Primero, define un modelo simple:

```dart
// Agrega esto antes de MiTiendaApp
class Product {
  final String id;
  final String title;
  final double price;
  final String image;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.rating = 4.5,
  });
}

// Datos de ejemplo
final sampleProducts = [
  const Product(
    id: '1',
    title: 'Camiseta Premium',
    price: 29.99,
    image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    rating: 4.5,
  ),
  const Product(
    id: '2',
    title: 'Jeans Clásicos',
    price: 49.99,
    image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    rating: 4.2,
  ),
  const Product(
    id: '3',
    title: 'Mochila Laptop',
    price: 89.99,
    image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    rating: 4.8,
  ),
  const Product(
    id: '4',
    title: 'Reloj Digital',
    price: 199.99,
    image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    rating: 4.0,
  ),
];
```

Ahora actualiza `_buildHome()` para mostrar productos:

```dart
Widget _buildHome() {
  return DSProductGrid<Product>(
    products: sampleProducts,
    isLoading: false,
    error: null,
    onRetry: () {},
    emptyMessage: 'No hay productos',
    loadingMessage: 'Cargando productos...',
    itemBuilder: (context, product, index) => DSProductCard(
      imageUrl: product.image,
      title: product.title,
      price: product.price,
      rating: product.rating,
      reviewCount: 128,
      onTap: () {
        // Ver detalle del producto
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seleccionaste: ${product.title}')),
        );
      },
      onAddToCart: () {
        // Agregar al carrito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.title} agregado al carrito')),
        );
      },
    ),
  );
}
```

> 🎉 **Checkpoint:** Deberías ver un grid de 4 productos con imágenes, precios y ratings.

---

## Paso 7: Agregar interactividad

Finalmente, vamos a agregar categorías con chips filtrables. Actualiza `_buildCategories()`:

```dart
// Agrega este estado en _HomePageState
Set<String> _selectedCategories = {};

final categories = ['Ropa', 'Electrónica', 'Hogar', 'Deportes', 'Accesorios'];

Widget _buildCategories() {
  final tokens = context.tokens;

  return Padding(
    padding: const EdgeInsets.all(DSSpacing.base),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSText.titleMedium('Filtrar por categoría'),
        const SizedBox(height: DSSpacing.md),

        // Chips de filtro
        Wrap(
          spacing: DSSpacing.sm,
          runSpacing: DSSpacing.sm,
          children: categories.map((category) {
            final isSelected = _selectedCategories.contains(category);
            return DSFilterChip(
              label: category,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category);
                  } else {
                    _selectedCategories.add(category);
                  }
                });
              },
            );
          }).toList(),
        ),

        const SizedBox(height: DSSpacing.xl),

        // Mostrar selección
        if (_selectedCategories.isNotEmpty) ...[
          DSText.bodySmall(
            'Seleccionadas: ${_selectedCategories.join(", ")}',
            color: tokens.colorTextSecondary,
          ),
          const SizedBox(height: DSSpacing.md),
          DSButton.secondary(
            text: 'Limpiar filtros',
            icon: Icons.clear,
            onPressed: () {
              setState(() => _selectedCategories.clear());
            },
          ),
        ] else
          DSEmptyState(
            icon: Icons.filter_list,
            title: 'Sin filtros',
            description: 'Selecciona categorías para filtrar productos',
          ),
      ],
    ),
  );
}
```

> 🎉 **Checkpoint:** Puedes seleccionar/deseleccionar categorías con feedback visual.

---

## Código completo

<details>
<summary>Ver código completo de main.dart</summary>

```dart
import 'package:flutter/material.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

// Modelo de producto
class Product {
  final String id;
  final String title;
  final double price;
  final String image;
  final double rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.rating = 4.5,
  });
}

// Datos de ejemplo
final sampleProducts = [
  const Product(id: '1', title: 'Camiseta Premium', price: 29.99, image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg', rating: 4.5),
  const Product(id: '2', title: 'Jeans Clásicos', price: 49.99, image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg', rating: 4.2),
  const Product(id: '3', title: 'Mochila Laptop', price: 89.99, image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg', rating: 4.8),
  const Product(id: '4', title: 'Reloj Digital', price: 199.99, image: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg', rating: 4.0),
];

void main() {
  runApp(const MiTiendaApp());
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Tienda',
      debugShowCheckedModeBanner: false,
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Set<String> _selectedCategories = {};
  final categories = ['Ropa', 'Electrónica', 'Hogar', 'Deportes', 'Accesorios'];

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      appBar: DSAppBar(
        title: _getTitle(),
        actions: [
          DSIconButton(icon: Icons.search, tooltip: 'Buscar', onPressed: () {}),
        ],
      ),
      backgroundColor: tokens.colorSurfacePrimary,
      body: _buildBody(),
      bottomNavigationBar: DSBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          DSBottomNavItem(icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Inicio'),
          DSBottomNavItem(icon: Icons.category_outlined, selectedIcon: Icons.category, label: 'Categorías'),
          DSBottomNavItem(icon: Icons.shopping_cart_outlined, selectedIcon: Icons.shopping_cart, label: 'Carrito', badgeCount: 3),
          DSBottomNavItem(icon: Icons.person_outline, selectedIcon: Icons.person, label: 'Perfil'),
        ],
      ),
    );
  }

  String _getTitle() => ['Mi Tienda', 'Categorías', 'Carrito', 'Perfil'][_currentIndex];

  Widget _buildBody() => [_buildHome(), _buildCategories(), _buildCart(), _buildProfile()][_currentIndex];

  Widget _buildHome() {
    return DSProductGrid<Product>(
      products: sampleProducts,
      isLoading: false,
      error: null,
      onRetry: () {},
      itemBuilder: (context, product, index) => DSProductCard(
        imageUrl: product.image,
        title: product.title,
        price: product.price,
        rating: product.rating,
        reviewCount: 128,
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ver: ${product.title}'))),
        onAddToCart: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Agregado: ${product.title}'))),
      ),
    );
  }

  Widget _buildCategories() {
    final tokens = context.tokens;
    return Padding(
      padding: const EdgeInsets.all(DSSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DSText.titleMedium('Filtrar por categoría'),
          const SizedBox(height: DSSpacing.md),
          Wrap(
            spacing: DSSpacing.sm,
            runSpacing: DSSpacing.sm,
            children: categories.map((cat) => DSFilterChip(
              label: cat,
              isSelected: _selectedCategories.contains(cat),
              onTap: () => setState(() => _selectedCategories.contains(cat) ? _selectedCategories.remove(cat) : _selectedCategories.add(cat)),
            )).toList(),
          ),
          const SizedBox(height: DSSpacing.xl),
          if (_selectedCategories.isNotEmpty)
            DSButton.secondary(text: 'Limpiar', icon: Icons.clear, onPressed: () => setState(() => _selectedCategories.clear()))
          else
            DSEmptyState(icon: Icons.filter_list, title: 'Sin filtros', description: 'Selecciona categorías'),
        ],
      ),
    );
  }

  Widget _buildCart() => DSEmptyState(icon: Icons.shopping_cart_outlined, title: 'Carrito vacío', description: 'Agrega productos para continuar', actionText: 'Ver productos', onAction: () => setState(() => _currentIndex = 0));
  Widget _buildProfile() => const Center(child: DSText.bodyMedium('Perfil de usuario'));
}
```

</details>

---

## Siguiente paso

¡Felicitaciones! Has creado tu primera app usando el Fake Store Design System.

### Recursos para continuar

| Recurso | Descripción |
|---------|-------------|
| [API Reference](API_REFERENCE.md) | Documentación completa de todos los componentes |
| [How-To Guides](HOWTO.md) | Guías para tareas específicas |
| [Showcase](../example/README.md) | App de demostración con más ejemplos |

### Ideas para practicar

- [ ] Agregar pantalla de detalle de producto
- [ ] Implementar búsqueda funcional
- [ ] Conectar con una API real
- [ ] Agregar persistencia del carrito
- [ ] Implementar autenticación

---

**¿Tienes dudas?** Revisa la [API Reference](API_REFERENCE.md) o explora el [Showcase](../example/README.md).
