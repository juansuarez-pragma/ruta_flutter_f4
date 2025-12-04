# CLAUDE.md - Guía para Asistentes de IA

## Contexto del Proyecto

Este paquete es la **Fase 4** de la **Ruta de Crecimiento Flutter**, un proyecto educativo progresivo para desarrolladores Flutter. La ruta completa consta de las siguientes fases:

### Fases del Proyecto

| Fase | Nombre | Descripción | Repositorio |
|------|--------|-------------|-------------|
| 1 | Fundamentos Dart | Conceptos básicos de Dart | - |
| 2 | Consumo de API | Aplicación CLI con Clean Architecture | `fase_2_consumo_api/` |
| 3 | Paquete Flutter | Cliente HTTP como paquete reutilizable | `fase_3_paquete_flutter/` |
| **4** | **Design System** | **Sistema de diseño con Atomic Design** | **Este repositorio** |
| 5 | (Pendiente) | Aplicación completa Flutter | - |

### Relación entre Fases

```
Fase 2 (CLI)
    ↓ Evoluciona a
Fase 3 (Paquete) ←── fake_store_api_client
    ↓ Se integra con
Fase 4 (Design System) ←── fake_store_design_system (ESTE PAQUETE)
    ↓ Ambos se usan en
Fase 3/example/ (App de demostración)
```

## Descripción del Paquete

Este es un **Sistema de Diseño Flutter** para la aplicación Fake Store. Implementa:

- **Metodología Atomic Design** (átomos → moléculas → organismos)
- **Design Tokens** (colores, tipografía, espaciado, elevación)
- **Temas claro/oscuro** usando ThemeExtension
- **Integración completa** con la app de ejemplo de Fase 3

## Comandos Esenciales

```bash
# Obtener dependencias
flutter pub get

# Ejecutar tests
flutter test

# Analizar código
flutter analyze

# Formatear código
dart format .

# Ejecutar app de ejemplo (desde fase_3)
cd ../../../fase_3_paquete_flutter/fake_store_api_client/example
flutter run
```

## Arquitectura del Paquete

```
lib/
├── fake_store_design_system.dart    # Barrel file principal
└── src/
    ├── tokens/                       # Design Tokens (valores primitivos)
    │   ├── ds_colors.dart           # Paleta de colores (96+ colores)
    │   ├── ds_spacing.dart          # Sistema de espaciado (4px grid)
    │   ├── ds_typography.dart       # Fuentes, pesos, tamaños
    │   ├── ds_border_radius.dart    # Radios de borde
    │   ├── ds_elevation.dart        # Niveles de sombra
    │   ├── ds_duration.dart         # Duraciones de animación
    │   └── ds_sizes.dart            # Tamaños estándar
    │
    ├── foundations/                  # Sistema de Temas
    │   └── theme/
    │       ├── ds_theme_data.dart   # ThemeExtension (83+ tokens semánticos)
    │       ├── ds_theme_light.dart  # Tema claro completo
    │       ├── ds_theme_dark.dart   # Tema oscuro completo
    │       └── fake_store_theme.dart # Clase de conveniencia
    │
    ├── atoms/                        # Componentes Atómicos
    │   ├── buttons/
    │   │   ├── ds_button.dart       # Botón con variantes (primary, secondary, ghost, danger)
    │   │   └── ds_icon_button.dart  # Botón de ícono circular
    │   ├── badges/
    │   │   └── ds_badge.dart        # Badge con tipos (success, error, warning, info, neutral)
    │   ├── inputs/
    │   │   └── ds_text_field.dart   # Campo de texto con validación
    │   ├── typography/
    │   │   └── ds_text.dart         # Componente de texto con variantes
    │   └── loaders/
    │       ├── ds_circular_loader.dart  # Spinner circular
    │       └── ds_skeleton.dart     # Skeleton placeholder animado
    │
    ├── molecules/                    # Componentes Moleculares
    │   ├── cards/
    │   │   ├── ds_card.dart         # Card base con elevación
    │   │   └── ds_product_card.dart # Card especializada para productos
    │   ├── chips/
    │   │   └── ds_filter_chip.dart  # Chip seleccionable para filtros
    │   └── empty_states/
    │       ├── ds_empty_state.dart  # Vista de estado vacío
    │       ├── ds_error_state.dart  # Vista de estado de error con retry
    │       └── ds_loading_state.dart # Vista de estado de carga
    │
    ├── organisms/                    # Componentes de Organismo
    │   ├── headers/
    │   │   └── ds_app_bar.dart      # AppBar personalizado
    │   ├── grids/
    │   │   └── ds_product_grid.dart # Grid de productos con manejo de estados
    │   └── navigation/
    │       └── ds_bottom_nav.dart   # Navegación inferior con badges
    │
    └── utils/                        # Utilidades
        ├── extensions/
        │   └── context_extension.dart  # context.tokens, context.isDarkMode
        └── enums/
            └── *.dart               # Enums para variantes y tamaños
```

## Patrones de Diseño Implementados

### 1. Atomic Design (Brad Frost)
Componentes organizados en niveles de complejidad creciente:
- **Átomos**: Elementos UI básicos e indivisibles
- **Moléculas**: Combinación de átomos con funcionalidad específica
- **Organismos**: Secciones completas de interfaz

### 2. Design Tokens (W3C DTCG)
Sistema jerárquico de valores:
```dart
// Nivel 1: Primitivos (valores crudos)
DSColors.primary500  // #6366F1

// Nivel 2: Semánticos (propósito)
tokens.colorBrandPrimary  // Puede variar según tema

// Nivel 3: Componentes (uso específico)
tokens.buttonPrimaryBackground
```

### 3. ThemeExtension
Distribución de tokens via árbol de widgets:
```dart
class DSThemeData extends ThemeExtension<DSThemeData> {
  final Color colorSurfacePrimary;
  final Color colorTextPrimary;
  // ... 83+ tokens (incluye estados hover/pressed)

  @override
  ThemeExtension<DSThemeData> copyWith({...});

  @override
  ThemeExtension<DSThemeData> lerp(DSThemeData? other, double t);
}
```

### 4. Context Extension
Acceso simplificado desde cualquier widget:
```dart
extension DSContextExtension on BuildContext {
  DSThemeData get tokens => FakeStoreTheme.of(this);
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLightMode => !isDarkMode;
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
}
```

## Convenciones de Código

### Nomenclatura
- **Prefijo `DS`** para todos los componentes públicos: `DSButton`, `DSCard`, `DSText`
- **Prefijo `DS`** para todos los tokens: `DSColors`, `DSSpacing`, `DSTypography`
- **Variantes via enums**: `DSButtonVariant`, `DSBadgeType`, `DSTextVariant`
- **Tamaños via enums**: `DSButtonSize`, `DSLoaderSize`, `DSBadgeSize`

### Estructura de Componentes
```dart
/// Documentación con dartdoc incluyendo ejemplos
///
/// ## Uso básico
///
/// ```dart
/// DSComponent(
///   requiredProp: value,
/// )
/// ```
class DSComponent extends StatelessWidget {
  /// Descripción de la propiedad requerida.
  final String requiredProp;

  /// Descripción de la propiedad opcional.
  final int optionalProp;

  const DSComponent({
    super.key,
    required this.requiredProp,
    this.optionalProp = defaultValue,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;  // Siempre usar tokens
    // ...
  }
}
```

### Named Constructors
Cada componente ofrece constructores nombrados para casos comunes:
```dart
// DSButton
DSButton.primary(text: 'Guardar', onPressed: () {})
DSButton.secondary(text: 'Cancelar', onPressed: () {})
DSButton.ghost(text: 'Ver más', onPressed: () {})
DSButton.danger(text: 'Eliminar', onPressed: () {})

// DSBadge
DSBadge.success(text: 'Activo')
DSBadge.error(text: 'Agotado')
DSBadge.warning(text: 'Pocas unidades')
DSBadge.info(text: 'Nuevo')

// DSText
DSText.headingLarge('Título')
DSText.bodyMedium('Contenido')
```

### Barrel Files
Cada módulo usa barrel files para simplificar imports:
```dart
// En lugar de:
import 'package:fake_store_design_system/src/atoms/buttons/ds_button.dart';

// Usar:
import 'package:fake_store_design_system/fake_store_design_system.dart';
```

## APIs Principales

### Configuración de Temas
```dart
MaterialApp(
  theme: FakeStoreTheme.light(),
  darkTheme: FakeStoreTheme.dark(),
  themeMode: ThemeMode.system,  // Automático según preferencias del sistema
)
```

### Acceso a Tokens
```dart
@override
Widget build(BuildContext context) {
  final tokens = context.tokens;

  return Container(
    color: tokens.colorSurfacePrimary,
    padding: EdgeInsets.all(DSSpacing.base),
    child: DSText(
      'Contenido',
      variant: DSTextVariant.bodyMedium,
      color: tokens.colorTextPrimary,
    ),
  );
}
```

### Tokens Semánticos Disponibles
```dart
// Superficies
tokens.colorSurfacePrimary    // Fondo principal
tokens.colorSurfaceSecondary  // Fondo secundario
tokens.colorSurfaceTertiary   // Fondo terciario

// Textos
tokens.colorTextPrimary       // Texto principal
tokens.colorTextSecondary     // Texto secundario
tokens.colorTextTertiary      // Texto terciario
tokens.colorTextInverse       // Texto sobre fondos oscuros

// Marca
tokens.colorBrandPrimary      // Color de marca principal
tokens.colorBrandSecondary    // Color de marca secundario

// Feedback
tokens.colorFeedbackSuccess   // Éxito (verde)
tokens.colorFeedbackError     // Error (rojo)
tokens.colorFeedbackWarning   // Advertencia (amarillo)
tokens.colorFeedbackInfo      // Información (azul)

// Bordes
tokens.colorBorderPrimary     // Borde principal
tokens.colorBorderSecondary   // Borde secundario

// Íconos
tokens.colorIconPrimary       // Ícono principal
tokens.colorIconSecondary     // Ícono secundario

// Tipografía
tokens.typographyHeadingLarge // Estilo para encabezados grandes
tokens.typographyBodyMedium   // Estilo para cuerpo de texto

// Elevación
tokens.elevationLevel1        // Sombra nivel 1
tokens.elevationLevel2        // Sombra nivel 2

// Estados de Botones (hover/pressed)
tokens.buttonPrimaryBackgroundHover    // Hover del botón primario
tokens.buttonPrimaryBackgroundPressed  // Pressed del botón primario
tokens.buttonDangerBackgroundPressed   // Pressed del botón danger

// Estados de Chips (hover/pressed)
tokens.chipBackgroundHover     // Hover del chip
tokens.chipBackgroundPressed   // Pressed del chip
```

### Estados Interactivos (Hover/Active)

Los componentes implementan estados visuales para mejor UX en web/desktop:

```dart
// DSButton usa WidgetStateProperty para estados reactivos
style: ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return tokens.buttonPrimaryBackgroundDisabled;
    }
    if (states.contains(WidgetState.pressed)) {
      return tokens.buttonPrimaryBackgroundPressed;
    }
    if (states.contains(WidgetState.hovered)) {
      return tokens.buttonPrimaryBackgroundHover;
    }
    return tokens.buttonPrimaryBackground;
  }),
)
```

Componentes con soporte hover/active:
- `DSButton` - Todas las variantes (primary, secondary, ghost, danger)
- `DSIconButton` - Todas las variantes
- `DSCard` - Cuando tiene `onTap`
- `DSFilterChip` - Estados seleccionado y hover

## Tests

```bash
# Ejecutar todos los tests
flutter test

# Con coverage
flutter test --coverage
```

Los tests verifican:
- Creación correcta de temas claro y oscuro
- Presencia de DSThemeData como ThemeExtension
- Valores correctos de tokens primitivos (colores, espaciado, border radius)

## Integración con App de Ejemplo

El sistema de diseño está integrado con la app de ejemplo en:
`/fase_3_paquete_flutter/fake_store_api_client/example/`

### Mapeo de Componentes

| Componente Local | Componente DS | Descripción |
|------------------|---------------|-------------|
| `LoadingIndicator` | `DSLoadingState` | Indicador de carga |
| `ErrorView` | `DSErrorState` | Vista de error con retry |
| `EmptyState` | `DSEmptyState` | Estado vacío |
| `CategoryChip` | `DSFilterChip` | Chip de categoría |
| `ProductCard` | `DSProductCard` | Tarjeta de producto |
| `ProductGrid` | `DSProductGrid` | Grid de productos |
| `AppTheme` | `FakeStoreTheme` | Sistema de temas |

### Patrón de Integración (Composición)
Los componentes locales actúan como wrappers que delegan al Design System:
```dart
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DSProductCard(
      imageUrl: product.image,
      title: product.title,
      price: product.price,
      rating: product.rating.rate,
      reviewCount: product.rating.count,
      onTap: onTap,
    );
  }
}
```

## Extensión del Paquete

### Agregar Nuevo Token
1. Agregar constante en archivo de tokens (`ds_colors.dart`, `ds_spacing.dart`, etc.)
2. Si es semántico, agregar propiedad en `DSThemeData`
3. Definir valores para tema claro en `DSThemeLight`
4. Definir valores para tema oscuro en `DSThemeDark`
5. Actualizar `copyWith()` y `lerp()` en `DSThemeData`

### Agregar Nuevo Componente
1. Crear archivo en carpeta apropiada (atoms/molecules/organisms)
2. Usar prefijo `DS` en el nombre
3. Documentar con dartdoc incluyendo ejemplos de uso
4. Acceder a tokens via `context.tokens`
5. Exportar en barrel file correspondiente

### Agregar Nueva Variante
1. Agregar valor en enum correspondiente (`utils/enums/`)
2. Implementar lógica en switch/case del componente
3. Opcionalmente crear named constructor

## Dependencias

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| `flutter` | SDK | Framework base |
| `equatable` | ^2.0.7 | Comparación por valor en ThemeExtension |

## Documentación Relacionada

- **Documento de Diseño**: `/ruta-flutter/FASE_4_DISENO.md`
- **Ruta de Crecimiento**: `/ruta-flutter/Ruta de crecimiento.md`
- **Paquete API Client**: `/fase_3_paquete_flutter/fake_store_api_client/CLAUDE.md`
- **App de Ejemplo**: `/fase_3_paquete_flutter/fake_store_api_client/example/`

## Recursos Externos

- [Atomic Design - Brad Frost](https://atomicdesign.bradfrost.com/)
- [Flutter ThemeExtension](https://api.flutter.dev/flutter/material/ThemeExtension-class.html)
- [Material Design 3](https://m3.material.io/)
- [W3C Design Tokens Community Group](https://design-tokens.github.io/community-group/format/)
