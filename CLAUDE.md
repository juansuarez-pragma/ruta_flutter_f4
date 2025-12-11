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
    │       ├── ds_theme_data.dart   # ThemeExtension (85+ tokens semánticos)
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
  // ... 85+ tokens (incluye estados hover/pressed/disabled)

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

// Estados de Botones (hover/pressed/disabled)
tokens.buttonPrimaryBackgroundHover      // Hover del botón primario
tokens.buttonPrimaryBackgroundPressed    // Pressed del botón primario
tokens.buttonPrimaryBackgroundDisabled   // Disabled del botón primario
tokens.buttonDangerBackgroundHover       // Hover del botón danger
tokens.buttonDangerBackgroundPressed     // Pressed del botón danger
tokens.buttonDangerBackgroundDisabled    // Disabled del botón danger
tokens.buttonDangerTextDisabled          // Texto disabled del botón danger

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

## Accesibilidad (WCAG 2.1)

El sistema de diseño implementa características de accesibilidad siguiendo las pautas WCAG 2.1:

### Touch Targets
Todos los elementos interactivos cumplen con el tamaño mínimo de 44px:
```dart
// DSSizes - Tamaños de botón WCAG compliant
static const double buttonSm = 44;  // Mínimo WCAG
static const double buttonMd = 44;  // Mínimo WCAG
static const double buttonLg = 48;
```

### Semantics para Screen Readers
Los componentes incluyen información semántica para lectores de pantalla:

```dart
// DSIconButton - Semantics automático
DSIconButton(
  icon: Icons.favorite,
  tooltip: 'Agregar a favoritos',  // Usado como label semántico
  onPressed: () {},
)

// DSTextField - semanticLabel personalizable
DSTextField(
  label: 'Email',
  semanticLabel: 'Campo de correo electrónico',  // Para screen readers
  errorText: 'Email inválido',  // Anunciado automáticamente
)

// DSProductCard - imageSemanticLabel para imágenes
DSProductCard(
  imageUrl: product.image,
  title: product.title,
  imageSemanticLabel: 'Foto del producto: ${product.title}',
)

// DSBottomNav - Posición y estado anunciados
// "Home, selected, Tab 1 of 4"
// "Cart, 3 items, Tab 3 of 4"
```

### Componentes con Soporte de Accesibilidad
| Componente | Características |
|------------|-----------------|
| `DSButton` | Touch target 44px+, estados disabled |
| `DSIconButton` | Semantics, tooltip como label, loading state |
| `DSTextField` | semanticLabel, error/password hints |
| `DSProductCard` | imageSemanticLabel para imágenes |
| `DSBottomNav` | Posición de tab, badge count, estado seleccionado |

## Tests

```bash
# Ejecutar todos los tests
flutter test

# Con coverage
flutter test --coverage
```

### Cobertura de Tests (400+ tests)

| Categoría | Tests | Descripción |
|-----------|-------|-------------|
| **Atoms** | ~150 | DSButton, DSBadge, DSText, DSLoaders, DSIconButton, DSTextField |
| **Molecules** | ~80 | DSCard, DSProductCard, DSFilterChip, DSStates |
| **Organisms** | ~50 | DSAppBar, DSBottomNav, DSProductGrid |
| **Extensions** | ~20 | Context extensions, breakpoints |
| **Accessibility** | ~30 | Semantics, touch targets WCAG |
| **Responsive** | ~70 | Breakpoints, orientación, text scaling |

Los tests verifican:
- Creación correcta de temas claro y oscuro
- Presencia de DSThemeData como ThemeExtension
- Valores correctos de tokens primitivos (colores, espaciado, border radius)
- **Rendering de todos los componentes**
- **Interacciones y callbacks**
- **Variantes y tamaños**
- **Touch targets WCAG 2.1 (44px mínimo)**
- **Semantics para screen readers**

## Integración con Apps de Ejemplo

El sistema de diseño cuenta con dos aplicaciones de ejemplo:

1. **Showcase App** (dentro del paquete DS): `example/` - Demuestra todos los componentes
2. **App de Integración** (Fase 3): `/fase_3_paquete_flutter/fake_store_api_client/example/` - App real usando el DS

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

> **Nota**: Este paquete no tiene dependencias externas, maximizando compatibilidad.

## Documentación Relacionada

- **Documento de Diseño**: `/ruta-flutter/FASE_4_DISENO.md`
- **Ruta de Crecimiento**: `/ruta-flutter/Ruta de crecimiento.md`
- **Paquete API Client**: `/fase_3_paquete_flutter/fake_store_api_client/CLAUDE.md`
- **App de Ejemplo**: `/fase_3_paquete_flutter/fake_store_api_client/example/`

## Estado del Arte (Example App)

La aplicación de ejemplo incluye una sección **"Estado del Arte"** que proporciona una comparativa visual interactiva entre los componentes Flutter nativos y los componentes del Design System.

### Ubicación

```
example/lib/features/estado_del_arte/
├── estado_del_arte_page.dart     # Página principal
├── widgets/
│   ├── widgets.dart              # Barrel file
│   ├── comparison_playground.dart # Widget interactivo de comparación
│   ├── capability_table.dart     # Tabla de capacidades
│   ├── metric_badge.dart         # Badge para métricas
│   └── limitation_card.dart      # Card de limitaciones
└── sections/
    ├── sections.dart             # Barrel file
    ├── summary_section.dart      # Resumen con métricas
    ├── atoms_comparison_section.dart    # Comparativas de átomos
    ├── molecules_comparison_section.dart # Comparativas de moléculas
    ├── organisms_comparison_section.dart # Comparativas de organismos
    ├── capabilities_section.dart  # Tabla de capacidades
    └── limitations_section.dart   # Limitaciones del sistema
```

### Matriz de Comparación de Componentes

#### Componentes Basados en Flutter (10)

| Componente DS | Widget Flutter Base | Mejoras del DS |
|---------------|---------------------|----------------|
| `DSButton` | `ElevatedButton` / `OutlinedButton` / `TextButton` | 4 variantes, estados hover/pressed, loading integrado |
| `DSIconButton` | `IconButton` | 4 variantes, loading state, tooltips semánticos |
| `DSBadge` | `Badge` (Material 3) | 5 tipos semánticos, 3 tamaños |
| `DSTextField` | `TextField` | Validación visual, semanticLabel, estados de error |
| `DSCircularLoader` | `CircularProgressIndicator` | 4 tamaños, mensaje opcional, color de marca |
| `DSText` | `Text` | 12 variantes tipográficas predefinidas |
| `DSCard` | `Card` | 5 niveles elevación, hover states, onTap integrado |
| `DSFilterChip` | `FilterChip` | API simplificada, checkmark con color de marca |
| `DSAppBar` | `AppBar` | Búsqueda integrada, acciones configurables |
| `DSBottomNav` | `NavigationBar` | Badges con contadores, semántica de posición |

#### Componentes Nuevos sin Equivalente Flutter (6)

| Componente DS | Descripción | Valor Agregado |
|---------------|-------------|----------------|
| `DSSkeleton` | Placeholder animado | Shimmer effect para loading states |
| `DSProductCard` | Card de producto e-commerce | Imagen + título + precio + rating + badge |
| `DSEmptyState` | Vista de estado vacío | Ícono + título + descripción + acción |
| `DSErrorState` | Vista de error | Mensaje + detalles + botón retry |
| `DSLoadingState` | Vista de carga | Spinner centrado + mensaje opcional |
| `DSProductGrid` | Grid de productos | Manejo automático de loading/error/empty |

### Tabla de Capacidades

| Componente | Categoría | Estados Interactivos | Accesibilidad | Temas | Loading | Variantes |
|------------|-----------|---------------------|---------------|-------|---------|-----------|
| DSButton | Átomo | ✅ hover/pressed/disabled | ✅ | ✅ | ✅ | 4 × 3 |
| DSIconButton | Átomo | ✅ hover/pressed/disabled | ✅ | ✅ | ✅ | 4 × 3 |
| DSBadge | Átomo | ❌ | ❌ | ✅ | ❌ | 5 × 3 |
| DSTextField | Átomo | ✅ focus/error | ✅ | ✅ | ❌ | 1 |
| DSCircularLoader | Átomo | ❌ | ❌ | ✅ | N/A | 4 |
| DSText | Átomo | ❌ | ❌ | ✅ | ❌ | 12 |
| DSSkeleton | Átomo | ❌ | ❌ | ✅ | N/A | 2 |
| DSCard | Molécula | ✅ hover/pressed | ❌ | ✅ | ❌ | 5 |
| DSProductCard | Molécula | ✅ tap | ✅ | ✅ | ✅ | 1 |
| DSFilterChip | Molécula | ✅ hover/pressed/selected | ❌ | ✅ | ❌ | 1 |
| DSEmptyState | Molécula | ❌ | ❌ | ✅ | ❌ | 1 |
| DSErrorState | Molécula | ❌ | ❌ | ✅ | ❌ | 1 |
| DSLoadingState | Molécula | ❌ | ❌ | ✅ | N/A | 2 |
| DSAppBar | Organismo | ✅ | ❌ | ✅ | ❌ | 1 |
| DSBottomNav | Organismo | ✅ selected | ✅ | ✅ | ❌ | 1 |
| DSProductGrid | Organismo | ✅ | ✅ | ✅ | ✅ | 3 |

### Limitaciones Documentadas

| Área | Descripción | Impacto |
|------|-------------|---------|
| Animaciones | Sin transiciones personalizadas entre estados | UX básica |
| Responsividad | No hay breakpoint-aware automático | Manual por proyecto |
| Adaptabilidad | Sin NavigationRail para tablets | Limitado a móviles |
| Formularios | Sin wrapper TextFormField con validación | Validación manual |
| Rich Text | Sin soporte para TextSpan en DSText | Solo texto plano |
| Imágenes | Sin caché de imágenes integrado | Dependencia de network |
| i18n | Strings hardcodeados ("Reintentar") | Requiere i18n manual |
| Paginación | Sin scroll infinito en grids | Carga completa |

### Widget ComparisonPlayground

Widget interactivo que permite comparar Flutter nativo vs DS lado a lado:

```dart
ComparisonPlayground(
  title: 'Botones',
  subtitle: 'ElevatedButton vs DSButton',
  variants: ['Primary', 'Secondary', 'Ghost', 'Danger'],
  sizes: ['Small', 'Medium', 'Large'],
  hasLoadingToggle: true,
  hasDisabledToggle: true,
  flutterBuilder: (state) => ElevatedButton(...),
  flutterCodeBuilder: (state) => 'ElevatedButton(...)',
  dsBuilder: (state) => DSButton.primary(...),
  dsCodeBuilder: (state) => 'DSButton.primary(...)',
  advantages: ['API unificada', 'Estados hover', 'Loading integrado'],
  limitations: ['Sin gradientes', 'Sin autofocus'],
)
```

**Controles disponibles:**
- Selector de variante (dropdown)
- Selector de tamaño (dropdown)
- Toggle de loading
- Toggle de disabled
- Ver/ocultar código con botón de copiar

## Recursos Externos

- [Atomic Design - Brad Frost](https://atomicdesign.bradfrost.com/)
- [Flutter ThemeExtension](https://api.flutter.dev/flutter/material/ThemeExtension-class.html)
- [Material Design 3](https://m3.material.io/)
- [W3C Design Tokens Community Group](https://design-tokens.github.io/community-group/format/)
