# Test Suite - Fake Store Design System

## Estructura de Tests

```
test/
├── accessibility/              # Tests de accesibilidad WCAG
│   └── contrast_test.dart      # Validación de ratios de contraste
├── atoms/                      # Tests de componentes atómicos
│   ├── ds_button_test.dart
│   ├── ds_icon_button_test.dart
│   ├── ds_badge_test.dart
│   ├── ds_text_field_test.dart
│   └── ...
├── molecules/                  # Tests de componentes moleculares
│   ├── ds_card_test.dart
│   ├── ds_product_card_test.dart
│   ├── ds_filter_chip_test.dart
│   └── ...
├── organisms/                  # Tests de organismos
│   ├── ds_product_grid_test.dart
│   └── ...
├── extensions/                 # Tests de extensions de contexto
│   └── context_extension_test.dart
├── theme/                      # Tests de temas
│   └── theme_comparison_test.dart
├── edge_cases/                 # Tests de casos límite
│   └── content_resilience_test.dart
├── golden/                     # Golden tests (regresión visual)
│   ├── golden_test_helper.dart
│   ├── atoms_golden_test.dart
│   ├── molecules_golden_test.dart
│   ├── organisms_golden_test.dart
│   ├── dark_theme_golden_test.dart
│   └── goldens/               # Archivos de referencia
│       └── *.png
├── tokens/                     # Tests de design tokens
│   └── tokens_test.dart
└── accessibility_test.dart     # Tests generales de accesibilidad
```

## Ejecutar Tests

```bash
# Todos los tests
flutter test

# Con cobertura
flutter test --coverage

# Ver reporte de cobertura
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Solo golden tests
flutter test test/golden/

# Actualizar golden files (después de cambios visuales intencionales)
flutter test --update-goldens

# Tests específicos
flutter test test/atoms/
flutter test test/accessibility/
```

## Categorías de Tests

| Categoría | Descripción | Cantidad |
|-----------|-------------|:--------:|
| Widget Tests | Verificación de rendering y comportamiento | 175+ |
| Golden Tests | Regresión visual automatizada | 27 |
| Accessibility | WCAG 2.1 compliance (contraste) | 35+ |
| Theme Tests | Verificación de tokens light/dark | 17 |
| Edge Cases | Contenido extremo y casos límite | 20 |

**Total: 311+ tests**

## Cobertura por Componente

### Átomos (100% cubiertos)
- DSButton: variantes, tamaños, estados, interacciones
- DSIconButton: variantes, tamaños, estados, accessibility
- DSBadge: tipos, tamaños, renderizado
- DSText: variantes, estilos, colores
- DSTextField: estados, validación, interacciones
- DSCircularLoader: tamaños
- DSSkeleton: formas, animación

### Moléculas (100% cubiertos)
- DSCard: elevación, bordes, contenido
- DSProductCard: imagen, precio, rating, badge, interacciones
- DSFilterChip: estados, selección
- DSEmptyState: contenido completo
- DSErrorState: mensaje, retry
- DSLoadingState: mensaje, indicador

### Organismos (100% cubiertos)
- DSAppBar: título, acciones, leading
- DSBottomNav: items, badges, selección
- DSProductGrid: grid, loading, error, empty

## Golden Tests

Los golden tests capturan el estado visual de los componentes y detectan cambios no intencionales.

### Archivos Golden Generados
- `ds_button_variants.png` - Variantes de botón
- `ds_button_sizes.png` - Tamaños de botón
- `ds_button_disabled.png` - Estados deshabilitados
- `ds_icon_button_variants.png` - Variantes de icon button
- `ds_badge_types.png` - Tipos de badge
- `ds_badge_sizes.png` - Tamaños de badge
- `ds_text_variants.png` - Variantes de texto
- `ds_circular_loader_sizes.png` - Tamaños de loader
- `ds_skeleton_shapes.png` - Formas de skeleton
- `ds_card_elevations.png` - Elevaciones de card
- `ds_filter_chip_states.png` - Estados de filter chip
- `ds_empty_state.png` - Estado vacío
- `ds_error_state.png` - Estado de error
- `ds_loading_state.png` - Estado de carga
- `ds_product_card.png` - Product card completo
- `ds_app_bar.png` - App bar con acciones
- `ds_app_bar_back.png` - App bar con back button
- `ds_bottom_nav.png` - Bottom navigation
- `ds_product_grid.png` - Grid de productos
- `ds_product_grid_loading.png` - Grid en estado loading
- `ds_product_grid_error.png` - Grid en estado error
- Dark theme variants (6 archivos adicionales)

### Actualizar Goldens

Cuando realices cambios visuales intencionales:

```bash
flutter test --update-goldens
git add test/golden/goldens/
git commit -m "test(golden): update golden files after visual changes"
```

## Tests de Accesibilidad

### Contraste WCAG 2.1
- Verificación de ratio 4.5:1 para texto normal (AA)
- Verificación de ratio 3:1 para texto grande/UI (AA)
- Cobertura para light y dark themes

### Semántica
- Labels de accesibilidad en botones
- Hints en campos de texto
- Tooltips en icon buttons

## Agregar Nuevos Tests

### 1. Usar el helper `buildTestableWidget()`

```dart
Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );
}
```

### 2. Organizar en grupos

```dart
void main() {
  group('DSComponent', () {
    group('Rendering', () {
      testWidgets('renders basic component', ...);
    });

    group('Variants', () {
      testWidgets('renders primary variant', ...);
    });

    group('States', () {
      testWidgets('renders disabled state', ...);
    });

    group('Interactions', () {
      testWidgets('calls onPressed when tapped', ...);
    });

    group('Accessibility', () {
      testWidgets('has semantic label', ...);
    });
  });
}
```

### 3. Seguir convención de nombres
- Widget tests: `component_test.dart`
- Golden tests: `component_golden_test.dart`
- Theme tests: `theme_*_test.dart`

### 4. Documentar casos de prueba
- Usar `reason` en expects para claridad
- Agregar comentarios para lógica compleja

## Métricas de Calidad

| Métrica | Valor |
|---------|:-----:|
| Tests totales | 311+ |
| Componentes cubiertos | 16/16 (100%) |
| Golden files | 27 |
| Ratio contraste validado | WCAG AA |
| Temas cubiertos | Light + Dark |
