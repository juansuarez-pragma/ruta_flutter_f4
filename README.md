# Fake Store Design System

[![Tests](https://img.shields.io/badge/tests-400%2B%20passed-brightgreen)](./test)
[![Coverage](https://img.shields.io/badge/coverage-90%25-brightgreen)](./coverage)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.0.0-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/license-Proprietary-red)](./LICENSE)

> Sistema de diseño Flutter con Atomic Design, design tokens y soporte para temas claro/oscuro.

## Quick Start

**3 pasos para empezar en 30 segundos:**

```yaml
# 1. Agregar dependencia en pubspec.yaml
dependencies:
  fake_store_design_system:
    path: ../fake_store_design_system
```

```dart
import 'package:fake_store_design_system/fake_store_design_system.dart';

// 2. Configurar tema en MaterialApp
MaterialApp(
  theme: FakeStoreTheme.light(),
  darkTheme: FakeStoreTheme.dark(),
  themeMode: ThemeMode.system,
  home: MyHomePage(),
)

// 3. Usar componentes
DSButton.primary(text: 'Comprar', onPressed: () {})
DSProductCard(title: 'Producto', price: 29.99, imageUrl: '...')
```

## Tabla de Contenidos

- [Características](#características)
- [Componentes](#componentes)
- [Tokens de Diseño](#tokens-de-diseño)
- [Acceso a Tokens](#acceso-a-tokens)
- [Arquitectura](#arquitectura)
- [Showcase](#showcase)
- [Documentación](#documentación)

## Características

| Característica | Descripción |
|----------------|-------------|
| **Atomic Design** | Componentes organizados en átomos, moléculas y organismos |
| **Design Tokens** | Sistema completo de colores, tipografía, espaciado y elevación |
| **Temas** | Soporte para modo claro y oscuro con ThemeExtension |
| **Accesibilidad** | Touch targets WCAG 2.1, semantics para screen readers |

## Componentes

### Átomos (bloques básicos)

```dart
// Botones - 4 variantes
DSButton.primary(text: 'Guardar', onPressed: () {})
DSButton.secondary(text: 'Cancelar', onPressed: () {})
DSButton.ghost(text: 'Ver más', onPressed: () {})
DSButton.danger(text: 'Eliminar', onPressed: () {})

// Badges - 5 tipos semánticos
DSBadge.success(text: 'Nuevo')
DSBadge.error(text: 'Agotado')
DSBadge.warning(text: 'Pocas unidades')

// Texto - 12 variantes tipográficas
DSText.headingLarge('Título')
DSText.bodyMedium('Contenido')

// Input con validación
DSTextField(label: 'Email', hintText: 'correo@ejemplo.com')

// Loaders
DSCircularLoader(size: DSLoaderSize.medium)
DSSkeleton(width: 200, height: 100)
```

### Moléculas (combinaciones)

```dart
// Card de producto completa
DSProductCard(
  imageUrl: 'https://...',
  title: 'Producto',
  price: 29.99,
  rating: 4.5,
  onTap: () => viewProduct(),
)

// Chips de filtro
DSFilterChip(label: 'Electrónica', isSelected: true, onTap: () {})

// Estados de UI
DSEmptyState(icon: Icons.inbox, title: 'Sin productos')
DSErrorState(message: 'Error al cargar', onRetry: () {})
DSLoadingState(message: 'Cargando...')
```

### Organismos (secciones completas)

```dart
// AppBar personalizado
DSAppBar(title: 'Mi Tienda', actions: [...])

// Grid de productos con estados
DSProductGrid<Product>(
  products: products,
  isLoading: isLoading,
  error: errorMessage,
  onRetry: () => reload(),
)

// Navegación inferior con badges
DSBottomNav(
  currentIndex: 0,
  items: [
    DSBottomNavItem(icon: Icons.home, label: 'Inicio'),
    DSBottomNavItem(icon: Icons.cart, label: 'Carrito', badgeCount: 3),
  ],
)
```

## Tokens de Diseño

### Colores

```dart
DSColors.primary500    // Color principal (#6366F1)
DSColors.neutral100    // Fondos claros
DSColors.success500    // Feedback éxito
DSColors.error500      // Feedback error
```

### Espaciado (escala 4px)

```dart
DSSpacing.xs    // 4px
DSSpacing.sm    // 8px
DSSpacing.base  // 16px
DSSpacing.lg    // 20px
DSSpacing.xl    // 24px
```

### Tipografía

```dart
DSFontSize.headingLarge  // 32px
DSFontSize.bodyLarge     // 16px
DSFontWeight.bold        // 700
```

### Border Radius

```dart
DSBorderRadius.sm    // 4px
DSBorderRadius.md    // 8px
DSBorderRadius.lg    // 16px
DSBorderRadius.full  // Pill (9999px)
```

## Acceso a Tokens

```dart
Widget build(BuildContext context) {
  final tokens = context.tokens;  // Acceso via extensión

  return Container(
    color: tokens.colorSurfacePrimary,
    padding: EdgeInsets.all(DSSpacing.base),
    child: DSText(
      'Hello World',
      color: tokens.colorTextPrimary,
    ),
  );
}

// Helpers de contexto
if (context.isDarkMode) { /* ajustes modo oscuro */ }
if (context.isTablet) { /* layout tablet */ }
```

## Arquitectura

```
lib/
├── fake_store_design_system.dart   # Barrel file (import único)
└── src/
    ├── tokens/                      # Colores, espaciado, tipografía
    ├── foundations/theme/           # ThemeExtension, temas claro/oscuro
    ├── atoms/                       # Buttons, badges, inputs, loaders
    ├── molecules/                   # Cards, chips, empty states
    ├── organisms/                   # AppBar, grids, navigation
    └── utils/                       # Extensions, enums
```

## Showcase

El paquete incluye una app de demostración interactiva:

```bash
cd example
flutter run -d chrome
```

La app muestra todos los componentes con ejemplos de código copiables y toggle de tema.

## Documentación

| Documento | Tipo | Descripción |
|-----------|------|-------------|
| [Getting Started](docs/GETTING_STARTED.md) | Tutorial | Tu primera app en 15 min |
| [API Reference](docs/API_REFERENCE.md) | Reference | Tokens y componentes completos |
| [How-To Guides](docs/HOWTO.md) | How-To | Guías para tareas específicas |
| [Architecture](docs/ARCHITECTURE.md) | Explanation | Decisiones de diseño |
| [Changelog](docs/CHANGELOG.md) | Historial | Cambios por versión |
| [Showcase](example/README.md) | Demo | App de demostración interactiva |

## Tests

```bash
flutter test              # Ejecutar 400+ tests
flutter test --coverage   # Con reporte de cobertura
```

## Contribuir

1. Seguir la estructura de carpetas existente
2. Usar prefijo `DS` para componentes públicos
3. Documentar con dartdoc incluyendo ejemplos
4. Asegurar que los tests pasen antes de commit

## Licencia

Propietario - Proyecto educativo de la Ruta de Crecimiento Flutter.
