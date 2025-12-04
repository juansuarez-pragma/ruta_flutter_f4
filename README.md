# Fake Store Design System

Sistema de diseño Flutter para la aplicación Fake Store. Proporciona tokens de diseño, componentes UI reutilizables y soporte para temas claro/oscuro siguiendo la metodología Atomic Design.

## Características

- **Design Tokens**: Sistema completo de tokens (colores, tipografía, espaciado, elevación, bordes, animaciones)
- **Atomic Design**: Componentes organizados en átomos, moléculas y organismos
- **Temas**: Soporte para modo claro y oscuro con transiciones suaves
- **ThemeExtension**: Integración nativa con el sistema de temas de Flutter
- **Context Extensions**: Acceso fácil a tokens via `context.tokens`
- **Tipado fuerte**: APIs tipadas con documentación inline (DSThemeData en lugar de dynamic)
- **Estados Interactivos**: Soporte completo para hover/pressed en web y desktop

## Instalación

Agrega la dependencia a tu `pubspec.yaml`:

```yaml
dependencies:
  fake_store_design_system:
    path: ../fake_store_design_system
```

## Uso Básico

### Configuración de Temas

```dart
import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
```

### Acceso a Tokens

```dart
Widget build(BuildContext context) {
  // Acceso via extensión de contexto
  final tokens = context.tokens;

  return Container(
    color: tokens.colorSurfacePrimary,
    padding: EdgeInsets.all(DSSpacing.base),
    child: DSText(
      'Hello World',
      variant: DSTextVariant.headingLarge,
    ),
  );
}
```

### Helpers de Contexto

```dart
// Verificar modo de tema
if (context.isDarkMode) {
  // Ajustes para modo oscuro
}

// Verificar tamaño de pantalla
if (context.isTablet) {
  // Layout para tablet
}
```

## Componentes

### Átomos

Los bloques de construcción más básicos:

```dart
// Botones
DSButton.primary(
  text: 'Continuar',
  onPressed: () => handleContinue(),
)

DSButton.secondary(
  text: 'Cancelar',
  icon: Icons.close,
  onPressed: () => handleCancel(),
)

// Badges
DSBadge.success(text: 'Nuevo')
DSBadge.error(text: 'Agotado')
DSBadge.warning(text: 'Pocas unidades')

// Texto
DSText(
  'Título de sección',
  variant: DSTextVariant.headingMedium,
)

// Input
DSTextField(
  label: 'Email',
  hintText: 'ejemplo@correo.com',
  prefixIcon: Icons.email,
  onChanged: (value) => handleEmail(value),
)

// Loaders
DSCircularLoader(
  size: DSLoaderSize.medium,
  message: 'Cargando...',
)

DSSkeleton(
  width: double.infinity,
  height: 100,
)
```

Documentación detallada de átomos:
- Typography: `lib/src/atoms/typography/text.md`
- Loaders: `lib/src/atoms/loaders/loader.md`
- Inputs: `lib/src/atoms/inputs/text_field.md`
- Buttons: `lib/src/atoms/buttons/button.md`
- Badges: `lib/src/atoms/badges/badge.md`

### Moléculas

Combinaciones de átomos:

```dart
// Cards
DSCard(
  onTap: () => handleTap(),
  child: content,
)

// Product Card
DSProductCard(
  imageUrl: 'https://...',
  title: 'Producto',
  price: 29.99,
  rating: 4.5,
  reviewCount: 128,
  onTap: () => viewProduct(),
  onAddToCart: () => addToCart(),
)

// Filter Chips
DSFilterChip(
  label: 'Electrónica',
  isSelected: true,
  onTap: () => filterByCategory(),
)

// Estados
DSEmptyState(
  icon: Icons.inbox_outlined,
  title: 'No hay productos',
  description: 'Intenta con otra búsqueda',
  actionText: 'Buscar de nuevo',
  onAction: () => search(),
)

DSErrorState(
  message: 'Error al cargar',
  onRetry: () => reload(),
)

DSLoadingState(
  message: 'Cargando productos...',
)
```

### Organismos

Componentes complejos:

```dart
// AppBar
Scaffold(
  appBar: DSAppBar(
    title: 'Fake Store',
    actions: [
      DSIconButton(
        icon: Icons.search,
        onPressed: () => openSearch(),
      ),
    ],
  ),
)

// Product Grid
DSProductGrid<Product>(
  products: products,
  isLoading: isLoading,
  error: errorMessage,
  onProductTap: (product) => viewProduct(product),
  onRetry: () => loadProducts(),
)

// Bottom Navigation
DSBottomNav(
  currentIndex: selectedIndex,
  onTap: (index) => setState(() => selectedIndex = index),
  items: [
    DSBottomNavItem(icon: Icons.home, label: 'Inicio'),
    DSBottomNavItem(icon: Icons.category, label: 'Categorías'),
    DSBottomNavItem(
      icon: Icons.shopping_cart,
      label: 'Carrito',
      badgeCount: 3,
    ),
    DSBottomNavItem(icon: Icons.person, label: 'Perfil'),
  ],
)
```

## Tokens de Diseño

### Colores

```dart
// Primarios
DSColors.primary500  // Color principal
DSColors.primary100  // Variante clara
DSColors.primary900  // Variante oscura

// Neutrales
DSColors.neutral100 - DSColors.neutral900

// Semánticos
DSColors.success500  // Éxito
DSColors.error500    // Error
DSColors.warning500  // Advertencia
DSColors.info500     // Información
```

### Espaciado

Basado en escala de 4px:

```dart
DSSpacing.xxs   // 2px
DSSpacing.xs    // 4px
DSSpacing.sm    // 8px
DSSpacing.md    // 12px
DSSpacing.base  // 16px
DSSpacing.lg    // 20px
DSSpacing.xl    // 24px
DSSpacing.xxl   // 32px
```

### Tipografía

```dart
DSFontSize.displayLarge   // 48px
DSFontSize.headingLarge   // 32px
DSFontSize.titleLarge     // 22px
DSFontSize.bodyLarge      // 16px
DSFontSize.labelMedium    // 14px

DSFontWeight.regular  // 400
DSFontWeight.medium   // 500
DSFontWeight.semibold // 600
DSFontWeight.bold     // 700
```

### Border Radius

```dart
DSBorderRadius.none  // 0px
DSBorderRadius.sm    // 4px
DSBorderRadius.md    // 8px
DSBorderRadius.base  // 12px
DSBorderRadius.lg    // 16px
DSBorderRadius.full  // 9999px (pill)
```

## Arquitectura

```
lib/
├── fake_store_design_system.dart  # Barrel file principal
└── src/
    ├── tokens/                     # Design tokens
    │   ├── ds_colors.dart
    │   ├── ds_spacing.dart
    │   ├── ds_typography.dart
    │   ├── ds_border_radius.dart
    │   ├── ds_elevation.dart
    │   ├── ds_duration.dart
    │   └── ds_sizes.dart
    │
    ├── foundations/                # Sistema de temas
    │   └── theme/
    │       ├── ds_theme_data.dart  # ThemeExtension
    │       ├── ds_theme_light.dart
    │       ├── ds_theme_dark.dart
    │       └── fake_store_theme.dart
    │
    ├── atoms/                      # Componentes atómicos
    │   ├── buttons/
    │   ├── badges/
    │   ├── inputs/
    │   ├── typography/
    │   └── loaders/
    │
    ├── molecules/                  # Componentes moleculares
    │   ├── cards/
    │   ├── chips/
    │   └── empty_states/
    │
    ├── organisms/                  # Componentes de organismo
    │   ├── headers/
    │   ├── grids/
    │   └── navigation/
    │
    └── utils/                      # Utilidades
        ├── extensions/
        └── enums/
```

## Showcase

El paquete incluye una aplicación de demostración interactiva en la carpeta `example/`:

```bash
cd example
flutter run -d chrome
```

La aplicación showcase muestra:
- **Tokens**: Colores, tipografía, espaciado, border radius y elevación
- **Átomos**: Buttons, badges, inputs, loaders y tipografía
- **Moléculas**: Cards, chips y estados vacíos/error/carga
- **Organismos**: AppBar, grids y navegación

Cada componente incluye código de ejemplo copiable y toggle de tema claro/oscuro.

Ver [example/README.md](example/README.md) para más detalles.

## Contribuir

1. Sigue la estructura de carpetas existente
2. Documenta todos los componentes con dartdoc
3. Incluye ejemplos de uso en la documentación
4. Asegúrate de que los tests pasen antes de hacer commit

## Licencia

Propietario - Proyecto educativo
