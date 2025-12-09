# PLAN DE IMPLEMENTACIÓN DE MEJORAS
## Fake Store Design System v1.1.0

**Versión:** 1.0
**Fecha:** 09 de Diciembre de 2025
**Basado en:** Informe de Auditoría de Calidad v01

---

## RESUMEN EJECUTIVO

| Fase | Duración | Tracks Paralelos | Tareas | Prioridad |
|:----:|:--------:|:----------------:|:------:|:---------:|
| **1. Críticas** | 1 día | 2 | 6 | CRÍTICA |
| **2. Accesibilidad** | 1-2 días | 6 | 6 | ALTA |
| **3. Testing** | 3-5 días | 6 | ~115 tests | ALTA |
| **4. Documentación** | 0.5 días | 3 | 3 | MEDIA |
| **5. Futuras** | 2-3 días | 3 | 3 | BAJA |

### Optimización por Paralelización

| Sin paralelizar | Con paralelización | Ahorro |
|:---------------:|:------------------:|:------:|
| ~12 días | ~5-6 días | **~50%** |

### Impacto Esperado

| Métrica | Actual | Objetivo | Mejora |
|---------|:------:|:--------:|:------:|
| Puntuación global | 7.9/10 | 9.0/10 | +14% |
| Cobertura tests | ~15% | 70% | +367% |
| Accesibilidad | 6.5/10 | 8.5/10 | +31% |
| Warnings análisis | 2 | 0 | -100% |
| Bugs críticos | 2 | 0 | -100% |

---

## 1. ANÁLISIS DE DEPENDENCIAS

### 1.1 Grafo de Dependencias

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FASE 1: CRÍTICAS                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────┐                                                       │
│  │ T1: DSThemeData  │◄─────────────────────────────┐                       │
│  │ (agregar tokens) │                              │                       │
│  └────────┬─────────┘                              │                       │
│           │                                        │                       │
│           ▼                                        │                       │
│  ┌────────────────────────────────┐   ┌───────────┴───────────┐            │
│  │ T2: DSThemeLight              │   │ T3: DSThemeDark       │            │
│  │ (definir valores claro)       │   │ (definir valores osc) │            │
│  └────────────────┬───────────────┘   └───────────┬───────────┘            │
│                   │                               │                        │
│                   └───────────┬───────────────────┘                        │
│                               ▼                                            │
│                   ┌───────────────────────┐                                │
│                   │ T4: DSButton          │                                │
│                   │ (usar nuevos tokens)  │                                │
│                   └───────────────────────┘                                │
│                                                                             │
│  ┌───────────────────────────────┐  ← SIN DEPENDENCIAS (PARALELO)          │
│  │ T5: FakeStoreTheme            │                                         │
│  │ (assert → FlutterError)       │                                         │
│  └───────────────────────────────┘                                         │
│                                                                             │
│  ┌───────────────────────────────┐  ← SIN DEPENDENCIAS (PARALELO)          │
│  │ T6: Const Constructors        │                                         │
│  │ (fix warnings ejemplo)        │                                         │
│  └───────────────────────────────┘                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                      FASE 2: ACCESIBILIDAD (PARALELO)                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ A1: DSButton    │  │ A2: DSIconBtn   │  │ A3: DSTextField │             │
│  │ (touch target)  │  │ (Semantics)     │  │ (semanticLabel) │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ A4: DSProduct   │  │ A5: DSBottomNav │  │ A6: Contraste   │             │
│  │ Card (imagen)   │  │ (Semantics)     │  │ WCAG validator  │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  TODAS PUEDEN EJECUTARSE EN PARALELO - SIN DEPENDENCIAS ENTRE SÍ          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                        FASE 3: TESTING (PARALELO)                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  DEPENDE DE: Fase 1 completada (tokens y componentes actualizados)         │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ TEST-1: Atoms   │  │ TEST-2: Molecul │  │ TEST-3: Organism│             │
│  │ DSButton        │  │ DSCard          │  │ DSAppBar        │             │
│  │ DSIconButton    │  │ DSProductCard   │  │ DSProductGrid   │             │
│  │ DSText          │  │ DSFilterChip    │  │ DSBottomNav     │             │
│  │ DSBadge         │  │ DSEmptyState    │  │                 │             │
│  │ DSTextField     │  │ DSErrorState    │  │                 │             │
│  │ DSLoaders       │  │ DSLoadingState  │  │                 │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ TEST-4: Theme   │  │ TEST-5: Extensn │  │ TEST-6: Access  │             │
│  │ Light vs Dark   │  │ Context ext.    │  │ Semantics tests │             │
│  │ Token values    │  │ Breakpoints     │  │ Contrast tests  │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  TODAS PUEDEN EJECUTARSE EN PARALELO - SIN DEPENDENCIAS ENTRE SÍ          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                        FASE 4: DOCUMENTACIÓN                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐                                  │
│  │ D1: CLAUDE.md   │  │ D2: Changelog   │  ← PARALELO                      │
│  │ tokens chip     │  │ v1.1.0          │                                  │
│  └─────────────────┘  └─────────────────┘                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         FASE 5: MEJORAS FUTURAS                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │ F1: Golden Test │  │ F2: JSON Export │  │ F3: DSProduct   │             │
│  │ (regresión vis) │  │ (design tools)  │  │ Model interface │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                             │
│  DEPENDE DE: Fase 3 completada                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. CRONOGRAMA VISUAL

```
                    DÍA 1          DÍA 2          DÍA 3          DÍA 4          DÍA 5
                ┌──────────────┬──────────────┬──────────────┬──────────────┬──────────────┐
                │              │              │              │              │              │
   FASE 1       │ ████████████ │              │              │              │              │
   (Críticas)   │ Track A + B  │              │              │              │              │
                │   PARALELO   │              │              │              │              │
                │              │              │              │              │              │
                ├──────────────┼──────────────┤              │              │              │
                │              │              │              │              │              │
   FASE 2       │ ████████████ │ ████████████ │              │              │              │
   (Accesibil.) │    A1-A6     │    A1-A6     │              │              │              │
                │   PARALELO   │   PARALELO   │              │              │              │
                │              │              │              │              │              │
                ├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
                │              │              │              │              │              │
   FASE 3       │              │ ████████████ │ ████████████ │ ████████████ │ ████████████ │
   (Testing)    │              │   TEST 1-6   │   TEST 1-6   │   TEST 1-6   │   TEST 1-6   │
                │              │   PARALELO   │   PARALELO   │   PARALELO   │   PARALELO   │
                │              │              │              │              │              │
                ├──────────────┼──────────────┼──────────────┼──────────────┼──────────────┤
                │              │              │              │              │              │
   FASE 4       │              │              │              │              │ ████████████ │
   (Docs)       │              │              │              │              │    D1-D3     │
                │              │              │              │              │              │
                └──────────────┴──────────────┴──────────────┴──────────────┴──────────────┘

LEYENDA:
████ = Trabajo activo
Track A + B = Ejecución paralela de tracks independientes
```

---

## 3. FASE 1: CORRECCIONES CRÍTICAS

### Objetivo
Resolver bugs críticos que afectan funcionalidad del sistema de diseño.

### Track A (Secuencial - Cadena de dependencias)

| Paso | ID | Tarea | Archivo | Dependencia |
|:----:|:--:|-------|---------|:-----------:|
| 1 | T1.1 | Agregar tokens danger disabled | `ds_theme_data.dart` | Ninguna |
| 2 | T1.2 | Valores tema claro | `ds_theme_light.dart` | T1.1 |
| 3 | T1.3 | Valores tema oscuro | `ds_theme_dark.dart` | T1.1 |
| 4 | T1.4 | Actualizar DSButton | `ds_button.dart` | T1.2, T1.3 |

### Track B (Paralelo - Sin dependencias)

| Paso | ID | Tarea | Archivo | Dependencia |
|:----:|:--:|-------|---------|:-----------:|
| 1 | T1.5 | Assert → FlutterError | `fake_store_theme.dart` | Ninguna |
| 2 | T1.6 | Fix const constructors | `atoms_page.dart` | Ninguna |

### Detalle de Implementación

#### T1.1: DSThemeData - Agregar tokens

**Archivo:** `lib/src/foundations/theme/ds_theme_data.dart`

```dart
// Agregar después de buttonDangerText (línea ~213)

/// Fondo del botón de peligro deshabilitado
final Color buttonDangerBackgroundDisabled;

/// Texto del botón de peligro deshabilitado
final Color buttonDangerTextDisabled;
```

**Actualizar constructor, copyWith y lerp correspondientes.**

#### T1.2: DSThemeLight - Valores claro

**Archivo:** `lib/src/foundations/theme/ds_theme_light.dart`

```dart
// Agregar después de buttonDangerText: DSColors.white,

buttonDangerBackgroundDisabled: DSColors.error100,
buttonDangerTextDisabled: DSColors.error300,
```

#### T1.3: DSThemeDark - Valores oscuro

**Archivo:** `lib/src/foundations/theme/ds_theme_dark.dart`

```dart
buttonDangerBackgroundDisabled: DSColors.error900.withOpacity(0.3),
buttonDangerTextDisabled: DSColors.error700,
```

#### T1.4: DSButton - Usar nuevos tokens

**Archivo:** `lib/src/atoms/buttons/ds_button.dart:354-386`

```dart
Widget _buildDangerButton(...) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return tokens.buttonDangerBackgroundDisabled; // CORREGIDO
        }
        // ...
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return tokens.buttonDangerTextDisabled; // CORREGIDO
        }
        // ...
      }),
    ),
    child: _buildContent(
      tokens.buttonDangerText,
      tokens.buttonDangerTextDisabled, // CORREGIDO
      isDisabled,
    ),
  );
}
```

#### T1.5: FakeStoreTheme - FlutterError

**Archivo:** `lib/src/foundations/theme/fake_store_theme.dart`

```dart
static DSThemeData of(BuildContext context) {
  final dsTheme = maybeOf(context);
  if (dsTheme == null) {
    throw FlutterError.fromParts([
      ErrorSummary('DSThemeData not found in context.'),
      ErrorDescription(
        'No DSThemeData was found in the widget tree. '
        'This usually means FakeStoreTheme.light() or FakeStoreTheme.dark() '
        'is not set as the theme in MaterialApp.',
      ),
      ErrorHint(
        'Ensure your MaterialApp is configured like this:\n'
        '  MaterialApp(\n'
        '    theme: FakeStoreTheme.light(),\n'
        '    darkTheme: FakeStoreTheme.dark(),\n'
        '  )',
      ),
    ]);
  }
  return dsTheme;
}
```

#### T1.6: Const Constructors

**Archivo:** `example/lib/features/atoms/atoms_page.dart`

Agregar `const` en líneas 325 y 342.

### Estrategia de Commits - Fase 1

| Orden | Commit Message | Archivos |
|:-----:|----------------|----------|
| 1 | `feat(tokens): add buttonDanger disabled tokens to DSThemeData` | ds_theme_data.dart |
| 2 | `feat(theme): add buttonDanger disabled values for light theme` | ds_theme_light.dart |
| 3 | `feat(theme): add buttonDanger disabled values for dark theme` | ds_theme_dark.dart |
| 4 | `fix(button): use correct danger disabled tokens in DSButton` | ds_button.dart |
| 5 | `fix(theme): replace assert with FlutterError in FakeStoreTheme.of()` | fake_store_theme.dart |
| 6 | `style(example): add const constructors to fix analyzer warnings` | atoms_page.dart |

---

## 4. FASE 2: ACCESIBILIDAD (WCAG)

### Objetivo
Cumplimiento WCAG 2.1 nivel AA para todos los componentes interactivos.

### Tareas (Todas en Paralelo)

| ID | Tarea | Archivo | Cambio |
|:--:|-------|---------|--------|
| A2.1 | Touch targets | `ds_button.dart` | Altura mínima 44px |
| A2.2 | Semantics IconButton | `ds_icon_button.dart` | Wrapper Semantics |
| A2.3 | SemanticLabel TextField | `ds_text_field.dart` | Prop semanticLabel |
| A2.4 | SemanticLabel imagen | `ds_product_card.dart` | semanticLabel en Image |
| A2.5 | Semantics BottomNav | `ds_bottom_nav.dart` | Control excludeFromSemantics |
| A2.6 | Validador contraste | `test/accessibility/` | Tests de contraste |

### Estrategia de Commits - Fase 2

| Orden | Commit Message | Archivos |
|:-----:|----------------|----------|
| 1 | `fix(a11y): increase DSButton minimum touch target to 44px` | ds_button.dart |
| 2 | `feat(a11y): add Semantics wrapper to DSIconButton` | ds_icon_button.dart |
| 3 | `feat(a11y): add semanticLabel prop to DSTextField` | ds_text_field.dart |
| 4 | `feat(a11y): add semanticLabel to product images in DSProductCard` | ds_product_card.dart |
| 5 | `feat(a11y): add Semantics control to DSBottomNav items` | ds_bottom_nav.dart |
| 6 | `test(a11y): add WCAG contrast validation tests` | test/accessibility/ |

---

## 5. FASE 3: TESTING

### Objetivo
Alcanzar cobertura mínima del 70%.

### Estructura de Tests

```
test/
├── fake_store_design_system_test.dart  # Existente (11 tests)
├── atoms/
│   ├── ds_button_test.dart             # ~15 tests
│   ├── ds_icon_button_test.dart        # ~10 tests
│   ├── ds_text_test.dart               # ~12 tests
│   ├── ds_badge_test.dart              # ~10 tests
│   ├── ds_text_field_test.dart         # ~12 tests
│   └── loaders/
│       ├── ds_circular_loader_test.dart # ~6 tests
│       └── ds_skeleton_test.dart        # ~8 tests
├── molecules/
│   ├── ds_card_test.dart               # ~8 tests
│   ├── ds_product_card_test.dart       # ~10 tests
│   ├── ds_filter_chip_test.dart        # ~8 tests
│   └── empty_states/
│       ├── ds_empty_state_test.dart    # ~6 tests
│       ├── ds_error_state_test.dart    # ~6 tests
│       └── ds_loading_state_test.dart  # ~4 tests
├── organisms/
│   ├── ds_app_bar_test.dart            # ~8 tests
│   ├── ds_product_grid_test.dart       # ~10 tests
│   └── ds_bottom_nav_test.dart         # ~8 tests
├── theme/
│   ├── ds_theme_data_test.dart         # ~10 tests
│   └── theme_comparison_test.dart      # ~8 tests
├── extensions/
│   └── context_extension_test.dart     # ~10 tests
└── accessibility/
    ├── semantics_test.dart             # ~10 tests
    └── contrast_test.dart              # ~5 tests
```

### Estrategia de Commits - Fase 3

| Orden | Commit Message |
|:-----:|----------------|
| 1 | `test(atoms): add comprehensive widget tests for DSButton` |
| 2 | `test(atoms): add widget tests for DSIconButton` |
| 3 | `test(atoms): add widget tests for DSText` |
| 4 | `test(atoms): add widget tests for DSBadge` |
| 5 | `test(atoms): add widget tests for DSTextField` |
| 6 | `test(atoms): add widget tests for loaders` |
| 7 | `test(molecules): add widget tests for DSCard` |
| 8 | `test(molecules): add widget tests for DSProductCard` |
| 9 | `test(molecules): add widget tests for DSFilterChip` |
| 10 | `test(molecules): add widget tests for empty states` |
| 11 | `test(organisms): add widget tests for DSAppBar` |
| 12 | `test(organisms): add widget tests for DSProductGrid` |
| 13 | `test(organisms): add widget tests for DSBottomNav` |
| 14 | `test(theme): add theme comparison and token tests` |
| 15 | `test(extensions): add context extension tests` |

---

## 6. FASE 4: DOCUMENTACIÓN

### Tareas

| ID | Tarea | Archivo |
|:--:|-------|---------|
| D4.1 | Documentar tokens chip | `CLAUDE.md` |
| D4.2 | Crear changelog v1.1.0 | `CHANGELOG.md` |
| D4.3 | Actualizar ejemplos | `example/` |

### Estrategia de Commits - Fase 4

| Orden | Commit Message |
|:-----:|----------------|
| 1 | `docs: document chip tokens in CLAUDE.md` |
| 2 | `docs: add CHANGELOG.md for v1.1.0` |
| 3 | `docs(example): update example app with new features` |

---

## 7. FASE 5: MEJORAS FUTURAS

### Tareas (Opcionales)

| ID | Tarea | Descripción |
|:--:|-------|-------------|
| F5.1 | Golden Tests | Regresión visual con screenshots |
| F5.2 | JSON Export | Tokens en formato W3C DTCG |
| F5.3 | DSProductModel | Interface para tipado seguro en grid |

---

## 8. CHECKLIST DE VALIDACIÓN

### Post-Fase 1
- [ ] `flutter analyze` retorna 0 errores y 0 warnings
- [ ] `flutter test` pasa todos los tests existentes
- [ ] DSButton.danger disabled muestra colores correctos
- [ ] FakeStoreTheme.of() lanza FlutterError descriptivo

### Post-Fase 2
- [ ] Todos los botones tienen touch target ≥ 44px
- [ ] DSIconButton tiene Semantics wrapper
- [ ] Imágenes tienen semanticLabel
- [ ] Tests de contraste pasan WCAG AA

### Post-Fase 3
- [ ] Cobertura ≥ 70%
- [ ] Todos los componentes tienen widget tests
- [ ] Tests de estados (disabled, loading, hover)
- [ ] Tests de tema claro vs oscuro

### Post-Fase 4
- [ ] CLAUDE.md actualizado con tokens chip
- [ ] CHANGELOG.md creado para v1.1.0
- [ ] Ejemplos actualizados

---

## 9. COMANDOS ÚTILES

```bash
# Verificar análisis estático
flutter analyze

# Ejecutar tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage

# Generar reporte HTML de cobertura
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Verificar cobertura mínima
lcov --summary coverage/lcov.info | grep "lines"
```

---

**Documento generado:** 09 de Diciembre de 2025
**Versión del plan:** 1.0
