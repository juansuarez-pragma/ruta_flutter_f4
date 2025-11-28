# Fake Store Design System - Showcase

Aplicación de demostración interactiva para el sistema de diseño Fake Store. Muestra todos los componentes disponibles con ejemplos de uso y código copiable.

## Características

- **Navegación por Tabs**: Tokens, Átomos, Moléculas y Organismos
- **Toggle de Tema**: Alternar entre modo claro y oscuro
- **Vista de Código**: Cada componente incluye código de ejemplo copiable
- **Ejemplos Interactivos**: Componentes funcionales para probar variantes

## Ejecutar el Showcase

### Web (Recomendado)

```bash
cd example
flutter run -d chrome
```

### Build de Producción

```bash
flutter build web
```

Los archivos generados estarán en `build/web/`.

## Estructura del Proyecto

```
example/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── app/
│   │   └── showcase_app.dart     # App principal con tabs y theme toggle
│   ├── core/
│   │   └── widgets/
│   │       ├── component_card.dart   # Card que muestra componente + código
│   │       ├── code_preview.dart     # Vista de código con botón copiar
│   │       ├── section_title.dart    # Título de sección
│   │       └── widgets.dart          # Barrel file
│   └── features/
│       ├── tokens/
│       │   └── tokens_page.dart      # Colores, tipografía, spacing, etc.
│       ├── atoms/
│       │   └── atoms_page.dart       # Buttons, badges, inputs, loaders
│       ├── molecules/
│       │   └── molecules_page.dart   # Cards, chips, empty states
│       └── organisms/
│           └── organisms_page.dart   # AppBar, grids, bottom nav
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

## Contenido por Tab

### Tokens
- **Colores**: Paleta primaria, neutral y semántica
- **Tipografía**: Todos los estilos de texto disponibles
- **Espaciado**: Sistema de espaciado basado en 4px
- **Border Radius**: Radios de borde disponibles
- **Elevación**: Niveles de sombra

### Átomos
- **DSButton**: Variantes primary, secondary, ghost, danger
- **DSIconButton**: Botones circulares con iconos
- **DSBadge**: Badges success, error, warning, info, neutral
- **DSTextField**: Campo de texto con validación
- **DSCircularLoader**: Indicador de carga circular
- **DSSkeleton**: Placeholder animado
- **DSText**: Componente de texto con variantes

### Moléculas
- **DSCard**: Card base con elevación
- **DSProductCard**: Card especializada para productos
- **DSFilterChip**: Chips seleccionables para filtros
- **DSEmptyState**: Estado vacío con acción
- **DSErrorState**: Estado de error con retry
- **DSLoadingState**: Estado de carga

### Organismos
- **DSAppBar**: Barra de aplicación personalizada
- **DSProductGrid**: Grid de productos con itemBuilder
- **DSBottomNav**: Navegación inferior con badges

## Uso de ComponentCard

Cada componente se muestra dentro de un `ComponentCard` que incluye:

```dart
ComponentCard(
  title: 'Nombre del Componente',
  description: 'Descripción breve',
  code: '''
DSComponent(
  prop: value,
)''',
  child: DSComponent(
    prop: value,
  ),
)
```

El botón de copiar permite copiar el código al portapapeles para usar en proyectos.

## Dependencias

- `fake_store_design_system`: Sistema de diseño (path local)
- `flutter_lints`: Reglas de análisis estático

## Requisitos

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
