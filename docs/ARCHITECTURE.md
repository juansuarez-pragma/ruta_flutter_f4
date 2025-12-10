# Arquitectura del Design System

Guía de arquitectura del sistema de diseño Fake Store.

## Visión general

Este Design System implementa la metodología **Atomic Design** de Brad Frost combinada con un sistema de **Design Tokens** siguiendo el estándar W3C DTCG.

```
┌─────────────────────────────────────────────────────────────────┐
│                     ATOMIC DESIGN                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Tokens ──▶ Atoms ──▶ Molecules ──▶ Organisms ──▶ Templates   │
│                                                                 │
│   DSColors    DSButton   DSCard       DSAppBar     (App)        │
│   DSSpacing   DSBadge    DSProductCard DSBottomNav              │
│   DSTypo...   DSText     DSFilterChip  DSProductGrid            │
│               DSLoader   DSStates...                            │
│               DSTextField                                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Estructura de carpetas

```
lib/
├── fake_store_design_system.dart    # Barrel file principal
└── src/
    ├── tokens/                       # Nivel 1: Valores primitivos
    │   ├── ds_colors.dart           # Paleta de colores
    │   ├── ds_spacing.dart          # Sistema de espaciado
    │   ├── ds_typography.dart       # Tipografía
    │   ├── ds_border_radius.dart    # Radios de borde
    │   ├── ds_elevation.dart        # Sombras
    │   ├── ds_duration.dart         # Animaciones
    │   ├── ds_sizes.dart            # Tamaños estándar
    │   └── tokens.md                # Documentación
    │
    ├── foundations/                  # Nivel 2: Sistema de temas
    │   └── theme/
    │       ├── ds_theme_data.dart   # ThemeExtension
    │       ├── ds_theme_light.dart  # Tema claro
    │       ├── ds_theme_dark.dart   # Tema oscuro
    │       ├── fake_store_theme.dart # Clase de conveniencia
    │       └── theme.md             # Documentación
    │
    ├── atoms/                        # Nivel 3: Componentes básicos
    │   ├── buttons/
    │   │   ├── ds_button.dart
    │   │   ├── ds_icon_button.dart
    │   │   └── button.md
    │   ├── badges/
    │   │   ├── ds_badge.dart
    │   │   └── badge.md
    │   ├── typography/
    │   │   ├── ds_text.dart
    │   │   └── text.md
    │   ├── inputs/
    │   │   ├── ds_text_field.dart
    │   │   └── text_field.md
    │   └── loaders/
    │       ├── ds_circular_loader.dart
    │       ├── ds_skeleton.dart
    │       └── loader.md
    │
    ├── molecules/                    # Nivel 4: Combinaciones
    │   ├── cards/
    │   │   ├── ds_card.dart
    │   │   ├── ds_product_card.dart
    │   │   └── card.md
    │   ├── chips/
    │   │   ├── ds_filter_chip.dart
    │   │   └── chip.md
    │   └── empty_states/
    │       ├── ds_empty_state.dart
    │       ├── ds_error_state.dart
    │       ├── ds_loading_state.dart
    │       └── states.md
    │
    ├── organisms/                    # Nivel 5: Secciones completas
    │   ├── headers/
    │   │   └── ds_app_bar.dart
    │   ├── navigation/
    │   │   └── ds_bottom_nav.dart
    │   ├── grids/
    │   │   └── ds_product_grid.dart
    │   └── organisms.md
    │
    └── utils/                        # Utilidades
        ├── extensions/
        │   └── context_extension.dart
        └── enums/
            ├── badge_enums.dart
            ├── button_enums.dart
            ├── loader_enums.dart
            └── text_enums.dart
```

---

## Jerarquía de Design Tokens

### Nivel 1: Primitivos (Raw Values)

Valores crudos sin contexto semántico.

```dart
// ds_colors.dart
abstract final class DSColors {
  static const Color primary500 = Color(0xFF6200EE);
  static const Color neutral900 = Color(0xFF212121);
}

// ds_spacing.dart
abstract final class DSSpacing {
  static const double base = 16;
  static const double md = 12;
}
```

**Regla**: No usar directamente en widgets.

### Nivel 2: Semánticos (Contextual)

Valores con propósito definido, distribuidos via ThemeExtension.

```dart
// ds_theme_data.dart
class DSThemeData extends ThemeExtension<DSThemeData> {
  final Color colorBrandPrimary;      // <- primary500
  final Color colorTextPrimary;       // <- neutral900 (light) / neutral50 (dark)
  final Color colorSurfacePrimary;    // <- neutral50 (light) / neutral1000 (dark)
}
```

**Regla**: Usar via `context.tokens`.

### Nivel 3: Componentes (Component-specific)

Tokens específicos para estados de componentes.

```dart
// En DSThemeData
final Color buttonPrimaryBackground;       // <- colorBrandPrimary
final Color buttonPrimaryBackgroundHover;  // <- primary400
final Color buttonPrimaryBackgroundPressed; // <- primary600
```

**Regla**: Usados internamente por componentes.

---

## Atomic Design

### Átomos

Elementos UI más básicos e indivisibles.

| Componente | Descripción |
| --- | --- |
| `DSButton` | Botón con 4 variantes |
| `DSIconButton` | Botón circular de ícono |
| `DSBadge` | Badge con 5 tipos semánticos |
| `DSText` | Texto con 17 variantes |
| `DSTextField` | Campo de entrada |
| `DSCircularLoader` | Spinner de carga |
| `DSSkeleton` | Placeholder animado |

**Características**:
- No dependen de otros componentes DS
- Acceden directamente a tokens
- API simple y enfocada

### Moléculas

Combinaciones de átomos con funcionalidad específica.

| Componente | Composición |
| --- | --- |
| `DSCard` | Container + BoxDecoration + InkWell |
| `DSProductCard` | DSCard + Image + DSText + DSBadge + DSIconButton |
| `DSFilterChip` | FilterChip + tokens |
| `DSEmptyState` | Icon + DSText + DSButton |
| `DSErrorState` | Icon + DSText + DSButton |
| `DSLoadingState` | DSCircularLoader |

**Características**:
- Combinan 2+ átomos
- Lógica de presentación específica
- Pueden tener estado interno simple

### Organismos

Secciones completas de interfaz.

| Componente | Composición |
| --- | --- |
| `DSAppBar` | AppBar + tokens |
| `DSBottomNav` | Row + InkWell + Icon + Text + Badge |
| `DSProductGrid` | GridView + DSProductCard + DSStates |

**Características**:
- Combinan múltiples moléculas/átomos
- Manejo de estados (loading, error, empty)
- Pueden contener lógica de negocio delegada

---

## Patrones de implementación

### 1. Acceso a tokens

```dart
@override
Widget build(BuildContext context) {
  final tokens = context.tokens;  // Siempre primer línea

  return Container(
    color: tokens.colorSurfacePrimary,
    // ...
  );
}
```

### 2. Estados interactivos

```dart
// Usando WidgetStateProperty para Material widgets
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

### 3. Named constructors

```dart
class DSButton extends StatelessWidget {
  // Constructor principal con todos los parámetros
  const DSButton({
    required this.text,
    this.variant = DSButtonVariant.primary,
    // ...
  });

  // Constructores de conveniencia
  const DSButton.primary({required String text, ...})
      : this(text: text, variant: DSButtonVariant.primary, ...);

  const DSButton.secondary({required String text, ...})
      : this(text: text, variant: DSButtonVariant.secondary, ...);
}
```

### 4. Documentación dartdoc

```dart
/// Descripción breve del componente.
///
/// Descripción extendida con contexto de uso.
///
/// ## Uso básico
///
/// ```dart
/// ComponentName(
///   requiredProp: value,
/// )
/// ```
///
/// ## Con opciones
///
/// ```dart
/// ComponentName(
///   requiredProp: value,
///   optionalProp: otherValue,
/// )
/// ```
class ComponentName extends StatelessWidget {
  /// Descripción de la propiedad.
  final Type property;
}
```

---

## Convenciones de nomenclatura

### Componentes

| Tipo | Prefijo | Ejemplo |
| --- | --- | --- |
| Componente público | `DS` | `DSButton`, `DSCard` |
| Token primitivo | `DS` | `DSColors`, `DSSpacing` |
| Tema | `DS` | `DSThemeData`, `DSThemeLight` |
| Enum | `DS` | `DSButtonVariant`, `DSBadgeType` |
| Extensión | `DS` | `DSContextExtension` |

### Tokens semánticos

| Categoría | Patrón | Ejemplo |
| --- | --- | --- |
| Colores | `color{Category}{Variant}` | `colorTextPrimary` |
| Botones | `button{Variant}{Property}` | `buttonPrimaryBackground` |
| Cards | `card{Property}` | `cardBackground` |
| Inputs | `input{Property}` | `inputBorderFocused` |
| Chips | `chip{Property}` | `chipTextSelected` |
| Tipografía | `typography{Style}` | `typographyBodyMedium` |
| Elevación | `elevationLevel{N}` | `elevationLevel2` |

### Archivos

| Tipo | Patrón | Ejemplo |
| --- | --- | --- |
| Componente | `ds_{component}.dart` | `ds_button.dart` |
| Token | `ds_{category}.dart` | `ds_colors.dart` |
| Barrel | `{category}.dart` | `atoms.dart` |
| Documentación | `{component}.md` | `button.md` |

---

## Flujo de datos

```
┌─────────────────────────────────────────────────────────────────┐
│                        MaterialApp                              │
│  theme: FakeStoreTheme.light()                                 │
│  darkTheme: FakeStoreTheme.dark()                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         ThemeData                               │
│  extensions: [DSThemeData(...)]                                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Widget Tree                                 │
│                                                                 │
│  context.tokens ──────────────────────────────────────────▶    │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │  Organism: DSProductGrid                                  │ │
│  │  ┌─────────────────────────────────────────────────────┐  │ │
│  │  │  Molecule: DSProductCard                            │  │ │
│  │  │  ┌───────────────────────────────────────────────┐  │  │ │
│  │  │  │  Atom: DSBadge, DSText, DSIconButton          │  │  │ │
│  │  │  └───────────────────────────────────────────────┘  │  │ │
│  │  └─────────────────────────────────────────────────────┘  │ │
│  └───────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## Dependencias

El paquete mantiene dependencias mínimas:

```yaml
dependencies:
  flutter:
    sdk: flutter
  equatable: ^2.0.7  # Para comparación en ThemeExtension
```

**Filosofía**: Evitar dependencias externas para maximizar compatibilidad y minimizar tamaño.

---

## Testing

### Estructura de tests

```
test/
├── atoms/           # Tests unitarios de átomos
├── molecules/       # Tests de moléculas
├── organisms/       # Tests de organismos
├── tokens/          # Tests de tokens
├── foundations/     # Tests de temas
├── accessibility/   # Tests WCAG
├── responsive/      # Tests de breakpoints
└── golden/          # Golden tests (snapshots)
```

### Cobertura mínima

| Categoría | Cobertura esperada |
| --- | --- |
| Átomos | 90%+ |
| Moléculas | 85%+ |
| Organismos | 80%+ |
| Tokens | 100% |
| Temas | 100% |

---

## Extensibilidad

### Agregar nuevo token

1. Agregar en archivo de tokens primitivos
2. Agregar propiedad en `DSThemeData`
3. Definir valor en `DSThemeLight`
4. Definir valor en `DSThemeDark`
5. Actualizar `copyWith()` y `lerp()`

### Agregar nuevo componente

1. Crear archivo con prefijo `DS`
2. Acceder a tokens via `context.tokens`
3. Documentar con dartdoc + ejemplos
4. Crear tests unitarios
5. Exportar en barrel file
6. Agregar a documentación .md
