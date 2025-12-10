# GUÍA COMPLETA DE GOLDEN TESTS EN FLUTTER

## Documentación de Referencia para el Design System

**Fecha:** 10 de Diciembre de 2025
**Versión:** 1.0
**Autor:** Claude AI (Claude Opus 4.5)

---

## TABLA DE CONTENIDOS

1. [Introducción](#1-introducción)
2. [¿Qué son los Golden Tests?](#2-qué-son-los-golden-tests)
3. [Capacidades](#3-capacidades)
4. [Tipos de Golden Tests](#4-tipos-de-golden-tests)
5. [Limitaciones y Restricciones](#5-limitaciones-y-restricciones)
6. [Cómo se Construyen](#6-cómo-se-construyen)
7. [Cómo se Prueban](#7-cómo-se-prueban)
8. [Estado del Arte](#8-estado-del-arte)
9. [Herramientas y Paquetes](#9-herramientas-y-paquetes)
10. [Mejores Prácticas](#10-mejores-prácticas)
11. [Referencias](#11-referencias)

---

## 1. INTRODUCCIÓN

### 1.1 Propósito de este Documento

Este documento proporciona una guía completa sobre **Golden Tests** (también conocidos como **Snapshot Tests**) en Flutter, cubriendo desde conceptos básicos hasta técnicas avanzadas para su implementación en sistemas de diseño.

### 1.2 Contexto

| Aspecto | Descripción |
|---------|-------------|
| **Framework** | Flutter SDK |
| **Librería base** | `flutter_test` |
| **Función principal** | `matchesGoldenFile()` |
| **Propósito** | Regresión visual de UI |

---

## 2. ¿QUÉ SON LOS GOLDEN TESTS?

### 2.1 Definición

Un **Golden Test** (prueba dorada) es una técnica de testing que compara la apariencia visual actual de un widget contra una imagen de referencia previamente guardada, llamada **"golden file"** o **"archivo dorado"**.

> **Definición oficial de Flutter:**
> "A golden file is a master image that is considered the true rendering of a given widget, state, application, or other visual representation you have chosen to capture."

### 2.2 Analogía

```
┌─────────────────────────────────────────────────────────────┐
│                    GOLDEN TEST WORKFLOW                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   Widget Actual          Golden File           Resultado     │
│   ┌──────────┐          ┌──────────┐          ┌──────────┐  │
│   │  Button  │    vs    │  Button  │    =     │  ✅ PASS  │  │
│   │  [Save]  │          │  [Save]  │          │           │  │
│   └──────────┘          └──────────┘          └──────────┘  │
│                                                              │
│   Widget Modificado      Golden File           Resultado     │
│   ┌──────────┐          ┌──────────┐          ┌──────────┐  │
│   │  Button  │    vs    │  Button  │    =     │  ❌ FAIL  │  │
│   │ [Guardar]│          │  [Save]  │          │           │  │
│   └──────────┘          └──────────┘          └──────────┘  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.3 Diferencia con Otros Tests

| Tipo de Test | Qué Verifica | Granularidad |
|--------------|--------------|--------------|
| **Unit Test** | Lógica de negocio | Función/Clase |
| **Widget Test** | Comportamiento de widgets | Widget individual |
| **Golden Test** | Apariencia visual exacta | Píxeles renderizados |
| **Integration Test** | Flujos completos | App completa |

### 2.4 Cuándo Usar Golden Tests

| Escenario | Recomendado | Justificación |
|-----------|:-----------:|---------------|
| Componentes de Design System | ✅ | Garantiza consistencia visual |
| Widgets con estados múltiples | ✅ | Captura todas las variantes |
| Layouts complejos | ✅ | Detecta regresiones de layout |
| Widgets con animaciones | ⚠️ | Solo fotogramas específicos |
| Lógica de negocio | ❌ | Usar unit tests |
| Flujos de navegación | ❌ | Usar integration tests |

---

## 3. CAPACIDADES

### 3.1 Capacidades Nativas de Flutter

La función `matchesGoldenFile` de `flutter_test` proporciona:

| Capacidad | Descripción |
|-----------|-------------|
| **Comparación de Finder** | Captura widgets encontrados por Finder |
| **Comparación de Image** | Compara objetos `ui.Image` directamente |
| **Comparación de Future<Image>** | Soporta imágenes asíncronas |
| **Versionado** | Parámetro `version` para historial |
| **RepaintBoundary** | Usa el ancestro RepaintBoundary más cercano |

### 3.2 Firma de la Función

```dart
AsyncMatcher matchesGoldenFile(
  Object key, {    // Uri o String con la ruta del golden file
  int? version,    // Versión opcional para diferenciar históricos
})
```

### 3.3 Tipos de Input Soportados

```dart
// 1. Finder (widget)
await expectLater(
  find.byType(MyWidget),
  matchesGoldenFile('my_widget.png'),
);

// 2. Future<ui.Image>
await expectLater(
  imageFuture,
  matchesGoldenFile('rendered_image.png'),
);

// 3. ui.Image directo
await expectLater(
  myImage,
  matchesGoldenFile('direct_image.png'),
);
```

### 3.4 Capacidades de Generación

| Comando | Propósito |
|---------|-----------|
| `flutter test` | Ejecuta tests y compara con goldens existentes |
| `flutter test --update-goldens` | Genera/actualiza archivos golden |
| `flutter test --update-goldens test/specific_test.dart` | Actualiza golden específico |

---

## 4. TIPOS DE GOLDEN TESTS

### 4.1 Clasificación por Scope

#### 4.1.1 Golden Test de Widget Individual

```dart
testWidgets('DSButton renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DSButton.primary(
          text: 'Click me',
          onPressed: () {},
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(DSButton),
    matchesGoldenFile('goldens/ds_button_primary.png'),
  );
});
```

#### 4.1.2 Golden Test de Estados Múltiples

```dart
testWidgets('DSButton all states', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            DSButton.primary(text: 'Primary', onPressed: () {}),
            DSButton.secondary(text: 'Secondary', onPressed: () {}),
            DSButton.ghost(text: 'Ghost', onPressed: () {}),
            DSButton.danger(text: 'Danger', onPressed: () {}),
          ],
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(Column),
    matchesGoldenFile('goldens/ds_button_all_variants.png'),
  );
});
```

#### 4.1.3 Golden Test de Pantalla Completa

```dart
testWidgets('ProductDetailPage golden', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ProductDetailPage(product: mockProduct),
    ),
  );

  await expectLater(
    find.byType(ProductDetailPage),
    matchesGoldenFile('goldens/product_detail_page.png'),
  );
});
```

### 4.2 Clasificación por Plataforma (Alchemist)

| Tipo | Características | Uso |
|------|-----------------|-----|
| **Platform Tests** | Fuentes reales, alta fidelidad | Desarrollo local |
| **CI Tests** | Fuente Ahem (cuadrados), consistente | CI/CD pipelines |

```dart
// Platform test (local)
goldenTest(
  'DSCard platform test',
  fileName: 'ds_card',
  builder: () => DSCard(child: Text('Content')),
);

// CI test (cross-platform)
goldenTest(
  'DSCard CI test',
  fileName: 'ds_card_ci',
  builder: () => DSCard(child: Text('Content')),
  tags: ['ci'],
);
```

### 4.3 Clasificación por Interacción

#### 4.3.1 Golden Estático

```dart
// Captura el estado inicial
await expectLater(
  find.byType(MyWidget),
  matchesGoldenFile('widget_initial.png'),
);
```

#### 4.3.2 Golden con Interacción

```dart
// Captura después de interacción
await tester.tap(find.byType(ElevatedButton));
await tester.pumpAndSettle();

await expectLater(
  find.byType(MyWidget),
  matchesGoldenFile('widget_after_tap.png'),
);
```

#### 4.3.3 Golden con Hover (Desktop/Web)

```dart
// Captura estado hover
final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
await gesture.addPointer(location: Offset.zero);
await gesture.moveTo(tester.getCenter(find.byType(DSButton)));
await tester.pumpAndSettle();

await expectLater(
  find.byType(DSButton),
  matchesGoldenFile('button_hover.png'),
);
```

---

## 5. LIMITACIONES Y RESTRICCIONES

### 5.1 Limitaciones Técnicas

#### 5.1.1 Comparación Pixel-Perfect

| Problema | Descripción | Impacto |
|----------|-------------|---------|
| **Sin tolerancia nativa** | Flutter requiere coincidencia exacta de píxeles | Tests frágiles |
| **Anti-aliasing** | Diferencias sutiles en bordes | Falsos negativos |
| **Sombras** | Renderizado inconsistente entre plataformas | Fallos en CI |

```
┌─────────────────────────────────────────────────────────────┐
│ PROBLEMA: DIFERENCIA DE 1 PIXEL = TEST FALLIDO              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   Golden Original        Widget Actual         Resultado     │
│   ┌──────────────┐      ┌──────────────┐      ┌──────────┐  │
│   │ ████████████ │  vs  │ ████████████ │  =   │ ❌ FAIL   │  │
│   │ ██        ██ │      │ ██        ██ │      │           │  │
│   │ ████████████ │      │ ███████████▓ │ ←1px │ Diferencia│  │
│   └──────────────┘      └──────────────┘      └──────────┘  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### 5.1.2 Inconsistencia Cross-Platform

| Plataforma | Problema Común |
|------------|----------------|
| **macOS** | Font smoothing diferente |
| **Linux** | Renderizado de sombras distinto |
| **Windows** | Anti-aliasing específico |
| **Web** | Diferencias en Canvas |

```dart
// Golden generado en macOS
// ❌ Fallará en Linux CI
await expectLater(
  find.byType(Text),
  matchesGoldenFile('text_widget.png'),  // Inconsistente
);
```

#### 5.1.3 Dependencia de Versión de Flutter

| Escenario | Consecuencia |
|-----------|--------------|
| Actualización de Flutter | Goldens pueden invalidarse |
| Cambios en Skia | Renderizado diferente |
| Nuevos widgets Material | Apariencia modificada |

### 5.2 Restricciones de Uso

#### 5.2.1 Fuentes Personalizadas

```dart
// ⚠️ PROBLEMA: Fuentes no cargadas = Ahem por defecto
testWidgets('text with custom font', (tester) async {
  await tester.pumpWidget(
    Text('Hello', style: TextStyle(fontFamily: 'Roboto')),
  );
  // Sin cargar la fuente, se renderiza con Ahem (cuadrados)
});

// ✅ SOLUCIÓN: Cargar fuentes en flutter_test_config.dart
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();  // Cargar fuentes antes de tests
  return testMain();
}
```

#### 5.2.2 Imágenes de Red

```dart
// ❌ PROBLEMA: Imágenes de red no disponibles en tests
DSProductCard(
  imageUrl: 'https://example.com/image.jpg',  // No cargará
)

// ✅ SOLUCIÓN: Usar mock de imágenes
DSProductCard(
  imageUrl: 'assets/test_image.png',  // Imagen local
)

// O usar HttpOverrides
HttpOverrides.global = MockHttpOverrides();
```

#### 5.2.3 Animaciones

```dart
// ⚠️ PROBLEMA: Animaciones en progreso
await tester.pumpWidget(AnimatedWidget());
// El frame capturado depende del timing

// ✅ SOLUCIÓN: Esperar finalización
await tester.pumpAndSettle();  // Espera a que terminen animaciones

// O capturar frame específico
await tester.pump(Duration(milliseconds: 500));
```

### 5.3 Tabla de Limitaciones

| Limitación | Severidad | Workaround |
|------------|:---------:|------------|
| Cross-platform rendering | 🔴 Alta | Usar Ahem font / Docker |
| Pixel-perfect comparison | 🔴 Alta | Custom comparator con tolerancia |
| Font loading | 🟡 Media | `flutter_test_config.dart` |
| Network images | 🟡 Media | Mock HTTP / Assets locales |
| Animations | 🟡 Media | `pumpAndSettle()` |
| Flutter version changes | 🟡 Media | CI como source of truth |
| Large file sizes | 🟢 Baja | Comprimir goldens |
| Test execution time | 🟢 Baja | Paralelizar tests |

---

## 6. CÓMO SE CONSTRUYEN

### 6.1 Estructura Básica

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget golden test', (WidgetTester tester) async {
    // 1. ARRANGE: Preparar el widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyWidget(),
        ),
      ),
    );

    // 2. ACT: (Opcional) Realizar interacciones
    // await tester.tap(find.byType(Button));
    // await tester.pumpAndSettle();

    // 3. ASSERT: Comparar con golden
    await expectLater(
      find.byType(MyWidget),
      matchesGoldenFile('goldens/my_widget.png'),
    );
  });
}
```

### 6.2 Configuración del Proyecto

#### 6.2.1 Estructura de Carpetas Recomendada

```
test/
├── goldens/                    # Archivos golden generados
│   ├── atoms/
│   │   ├── ds_button_primary.png
│   │   ├── ds_button_secondary.png
│   │   └── ds_badge_all_types.png
│   ├── molecules/
│   │   ├── ds_card_default.png
│   │   └── ds_product_card.png
│   └── organisms/
│       └── ds_app_bar.png
├── golden_tests/               # Archivos de test
│   ├── atoms/
│   │   ├── ds_button_golden_test.dart
│   │   └── ds_badge_golden_test.dart
│   └── molecules/
│       └── ds_card_golden_test.dart
└── flutter_test_config.dart    # Configuración global
```

#### 6.2.2 Configuración Global (flutter_test_config.dart)

```dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Configurar tolerancia personalizada (opcional)
  // goldenFileComparator = CustomGoldenComparator();

  // Cargar fuentes personalizadas
  TestWidgetsFlutterBinding.ensureInitialized();
  await _loadFonts();

  return testMain();
}

Future<void> _loadFonts() async {
  // Cargar fuentes del Design System
  final fontLoader = FontLoader('Roboto')
    ..addFont(rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
  await fontLoader.load();
}
```

### 6.3 Patrones de Construcción

#### 6.3.1 Golden con Wrapper Consistente

```dart
/// Helper para crear contexto consistente
Widget buildTestableWidget(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? FakeStoreTheme.light(),
    home: Scaffold(
      body: Center(
        child: RepaintBoundary(
          child: child,
        ),
      ),
    ),
  );
}

// Uso en tests
testWidgets('DSButton golden', (tester) async {
  await tester.pumpWidget(
    buildTestableWidget(
      DSButton.primary(text: 'Save', onPressed: () {}),
    ),
  );

  await expectLater(
    find.byType(RepaintBoundary),
    matchesGoldenFile('goldens/ds_button_primary.png'),
  );
});
```

#### 6.3.2 Golden con Tamaño Fijo

```dart
testWidgets('fixed size golden', (tester) async {
  // Establecer tamaño de surface
  tester.view.physicalSize = Size(400, 300);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    ),
  );

  await expectLater(
    find.byType(Scaffold),
    matchesGoldenFile('goldens/my_widget_400x300.png'),
  );

  // Restaurar tamaño
  addTearDown(() => tester.view.resetPhysicalSize());
});
```

#### 6.3.3 Golden de Múltiples Estados

```dart
testWidgets('DSBadge all types golden', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              DSBadge.success(text: 'Success'),
              DSBadge.error(text: 'Error'),
              DSBadge.warning(text: 'Warning'),
              DSBadge.info(text: 'Info'),
              DSBadge.neutral(text: 'Neutral'),
            ],
          ),
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(Wrap),
    matchesGoldenFile('goldens/ds_badge_all_types.png'),
  );
});
```

### 6.4 Convención de Nombres

| Patrón | Ejemplo | Uso |
|--------|---------|-----|
| `{component}_{variant}.png` | `ds_button_primary.png` | Variante específica |
| `{component}_all_{category}.png` | `ds_badge_all_types.png` | Todas las variantes |
| `{component}_{state}.png` | `ds_button_disabled.png` | Estado específico |
| `{component}_{size}.png` | `ds_button_large.png` | Tamaño específico |
| `{component}_{theme}.png` | `ds_card_dark.png` | Tema específico |

---

## 7. CÓMO SE PRUEBAN

### 7.1 Comandos de Ejecución

| Comando | Propósito |
|---------|-----------|
| `flutter test` | Ejecutar todos los tests |
| `flutter test test/golden_tests/` | Ejecutar solo golden tests |
| `flutter test --update-goldens` | Generar/actualizar todos los goldens |
| `flutter test --update-goldens test/golden_tests/ds_button_test.dart` | Actualizar golden específico |

### 7.2 Flujo de Trabajo

```
┌─────────────────────────────────────────────────────────────┐
│                 GOLDEN TEST WORKFLOW                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. ESCRIBIR TEST                                           │
│     └─→ Crear archivo *_golden_test.dart                    │
│                                                              │
│  2. GENERAR GOLDEN INICIAL                                  │
│     └─→ flutter test --update-goldens                       │
│                                                              │
│  3. VERIFICAR GOLDEN                                        │
│     └─→ Revisar imagen generada manualmente                 │
│                                                              │
│  4. COMMIT GOLDEN                                           │
│     └─→ git add test/goldens/*.png                          │
│                                                              │
│  5. CI EJECUTA TESTS                                        │
│     └─→ flutter test (sin --update-goldens)                 │
│                                                              │
│  6. SI FALLA                                                │
│     ├─→ Cambio intencional: --update-goldens + commit       │
│     └─→ Regresión: Corregir código                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 7.3 Interpretación de Resultados

#### 7.3.1 Test Exitoso

```
✓ DSButton renders correctly (523ms)
```

#### 7.3.2 Test Fallido - Archivo No Existe

```
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following TestFailure object was thrown running a test:
Golden file not found: test/goldens/ds_button_primary.png

Run "flutter test --update-goldens" to create the golden file.
```

#### 7.3.3 Test Fallido - Diferencia Visual

```
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following TestFailure object was thrown running a test:
Golden "ds_button_primary.png": Pixel test failed, 2.5% diff detected.

Failure difference image saved to:
  test/failures/ds_button_primary_testFailure.png
```

### 7.4 Comparadores Personalizados

#### 7.4.1 Comparador con Tolerancia

```dart
// test/flutter_test_config.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class TolerantGoldenFileComparator extends LocalFileComparator {
  TolerantGoldenFileComparator(super.testFile);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    // Permitir hasta 0.5% de diferencia
    if (!result.passed && result.diffPercent <= 0.5) {
      debugPrint('Golden diff ${result.diffPercent}% within tolerance');
      return true;
    }

    return result.passed;
  }
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  goldenFileComparator = TolerantGoldenFileComparator(Uri.parse('test/'));
  return testMain();
}
```

### 7.5 Debugging de Golden Tests

```dart
testWidgets('debug golden test', (tester) async {
  await tester.pumpWidget(MyWidget());

  // Debug: Imprimir árbol de widgets
  debugDumpApp();

  // Debug: Verificar que el widget existe
  expect(find.byType(MyWidget), findsOneWidget);

  // Debug: Obtener tamaño del widget
  final size = tester.getSize(find.byType(MyWidget));
  debugPrint('Widget size: $size');

  await expectLater(
    find.byType(MyWidget),
    matchesGoldenFile('goldens/my_widget.png'),
  );
});
```

---

## 8. ESTADO DEL ARTE

### 8.1 Evolución de Golden Tests en Flutter

| Año | Hito | Descripción |
|-----|------|-------------|
| 2018 | Introducción | `matchesGoldenFile` añadido a flutter_test |
| 2019 | Flutter Gold | Sistema de gestión para el repositorio Flutter |
| 2020 | golden_toolkit | eBay publica paquete con mejoras |
| 2021 | Alchemist | Betterment/VGV lanzan solución para CI |
| 2023 | golden_test | Paquete con configuración multi-dispositivo |
| 2024 | Mejoras de tolerancia | Comunidad adopta comparadores personalizados |

### 8.2 Soluciones Actuales del Mercado

#### 8.2.1 Flutter Nativo (`flutter_test`)

| Aspecto | Valoración |
|---------|:----------:|
| Facilidad de uso | ⭐⭐⭐⭐⭐ |
| Funcionalidades | ⭐⭐⭐ |
| Cross-platform | ⭐⭐ |
| Mantenimiento | ⭐⭐⭐⭐⭐ |

```dart
// Uso básico
await expectLater(
  find.byType(Widget),
  matchesGoldenFile('golden.png'),
);
```

#### 8.2.2 golden_toolkit (eBay)

| Aspecto | Valoración |
|---------|:----------:|
| Facilidad de uso | ⭐⭐⭐⭐ |
| Funcionalidades | ⭐⭐⭐⭐ |
| Cross-platform | ⭐⭐⭐ |
| Documentación | ⭐⭐⭐⭐ |

```dart
// GoldenBuilder para múltiples escenarios
GoldenBuilder.grid(
  columns: 2,
  widthToHeightRatio: 1,
)
  ..addScenario('Primary', DSButton.primary(text: 'Click'))
  ..addScenario('Secondary', DSButton.secondary(text: 'Click'))
  ..addScenario('Disabled', DSButton.primary(text: 'Click', onPressed: null));
```

#### 8.2.3 Alchemist (Betterment/VGV)

| Aspecto | Valoración |
|---------|:----------:|
| Facilidad de uso | ⭐⭐⭐ |
| Funcionalidades | ⭐⭐⭐⭐⭐ |
| Cross-platform | ⭐⭐⭐⭐⭐ |
| CI/CD Integration | ⭐⭐⭐⭐⭐ |

```dart
// API declarativa con soporte CI
goldenTest(
  'DSButton renders correctly',
  fileName: 'ds_button',
  builder: () => GoldenTestGroup(
    children: [
      GoldenTestScenario(
        name: 'primary',
        child: DSButton.primary(text: 'Click', onPressed: () {}),
      ),
      GoldenTestScenario(
        name: 'secondary',
        child: DSButton.secondary(text: 'Click', onPressed: () {}),
      ),
    ],
  ),
);
```

### 8.3 Comparativa de Herramientas

| Característica | flutter_test | golden_toolkit | Alchemist |
|----------------|:------------:|:--------------:|:---------:|
| Setup mínimo | ✅ | ✅ | ⚠️ |
| Multi-escenario | ❌ | ✅ | ✅ |
| Theming automático | ❌ | ⚠️ | ✅ |
| CI consistency | ❌ | ⚠️ | ✅ |
| Gestures/Interactions | ⚠️ | ✅ | ✅ |
| Device frames | ❌ | ✅ | ✅ |
| Font replacement (CI) | ❌ | ❌ | ✅ |
| Mantenimiento activo | ✅ | ✅ | ✅ |

### 8.4 Tendencias Actuales (2024-2025)

#### 8.4.1 Docker para Consistencia

```dockerfile
# Dockerfile para golden tests
FROM ghcr.io/cirruslabs/flutter:stable

# Instalar fuentes
RUN apt-get update && apt-get install -y fonts-roboto

# Configurar ambiente
ENV FLUTTER_TEST_GOLDENS=true
```

```yaml
# CI workflow
golden-tests:
  runs-on: ubuntu-latest
  container:
    image: my-flutter-image
  steps:
    - uses: actions/checkout@v3
    - run: flutter test test/golden_tests/
```

#### 8.4.2 Tolerancia Adaptativa

```dart
// Tolerancia basada en tipo de cambio
class AdaptiveComparator extends LocalFileComparator {
  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    // Tolerancia diferenciada por tipo de golden
    final tolerance = _getToleranceForGolden(golden);
    return result.passed || result.diffPercent <= tolerance;
  }

  double _getToleranceForGolden(Uri golden) {
    if (golden.path.contains('text_')) return 1.0;  // Texto: 1%
    if (golden.path.contains('shadow_')) return 2.0; // Sombras: 2%
    return 0.5; // Default: 0.5%
  }
}
```

#### 8.4.3 Visual Regression Tools Integration

| Herramienta | Integración | Uso |
|-------------|-------------|-----|
| **Percy** | CI/CD | Review visual en PRs |
| **Chromatic** | Storybook | Design system documentation |
| **Applitools** | AI-powered | Detección inteligente de cambios |

### 8.5 Mejores Prácticas Emergentes

1. **CI como Source of Truth**: Generar goldens en CI, no local
2. **Ahem Font para CI**: Eliminar dependencia de fuentes del sistema
3. **Tolerancia Configurable**: No pixel-perfect para todos los casos
4. **Categorización de Goldens**: Separar por componente y variante
5. **Automatización de Updates**: Scripts para regenerar goldens en PRs

---

## 9. HERRAMIENTAS Y PAQUETES

### 9.1 Paquetes Principales

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| `flutter_test` | SDK | Testing nativo |
| `golden_toolkit` | ^0.15.0 | Multi-escenario, device frames |
| `alchemist` | ^0.10.0 | CI consistency, theming |
| `golden_test` | ^0.3.0 | Configuración multi-dispositivo |

### 9.2 Instalación

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  golden_toolkit: ^0.15.0
  alchemist: ^0.10.0
```

### 9.3 Configuración de golden_toolkit

```dart
// test/flutter_test_config.dart
import 'dart:async';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      return testMain();
    },
    config: GoldenToolkitConfiguration(
      enableRealShadows: false,
      skipGoldenAssertion: () => !Platform.isMacOS,
    ),
  );
}
```

### 9.4 Configuración de Alchemist

```dart
// test/flutter_test_config.dart
import 'dart:async';
import 'package:alchemist/alchemist.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final isRunningInCi = Platform.environment.containsKey('CI');

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: FakeStoreTheme.light(),
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isRunningInCi,
      ),
    ),
    run: testMain,
  );
}
```

---

## 10. MEJORES PRÁCTICAS

### 10.1 Organización

| Práctica | Recomendación |
|----------|---------------|
| **Estructura de carpetas** | Espejar estructura de `lib/` en `test/goldens/` |
| **Naming convention** | `{component}_{variant}_{state}.png` |
| **Separación** | Un archivo de test por componente |
| **Agrupación** | Variantes relacionadas en mismo golden |

### 10.2 Mantenibilidad

| Práctica | Beneficio |
|----------|-----------|
| **Wrapper helper** | Contexto consistente (theme, scaffold) |
| **Tamaño fijo** | Goldens determinísticos |
| **Ahem font en CI** | Cross-platform consistency |
| **Tolerancia configurable** | Menos falsos negativos |

### 10.3 CI/CD

| Práctica | Implementación |
|----------|----------------|
| **Docker image** | Ambiente idéntico para todos |
| **Caching de goldens** | Acelerar builds |
| **PR review de cambios** | Validar diffs visuales |
| **Regeneración automatizada** | Script para actualizar goldens |

### 10.4 Checklist para Golden Tests

```
□ Widget envuelto en MaterialApp/ThemeProvider
□ RepaintBoundary para control de bounds
□ Tamaño de surface definido (si aplica)
□ Fuentes cargadas correctamente
□ Imágenes de red mockeadas
□ Animaciones completadas (pumpAndSettle)
□ Nombre de archivo descriptivo
□ Golden commiteado a git
□ Test ejecuta en CI sin fallas
```

---

## 11. REFERENCIAS

### 11.1 Documentación Oficial

- [matchesGoldenFile - Flutter API](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)
- [Writing Golden File Tests - Flutter Wiki](https://github.com/flutter/flutter/blob/master/docs/contributing/testing/Writing-a-golden-file-test-for-package-flutter.md)
- [GoldenFileComparator - Flutter API](https://api.flutter.dev/flutter/flutter_test/GoldenFileComparator-class.html)

### 11.2 Paquetes

- [golden_toolkit - pub.dev](https://pub.dev/packages/golden_toolkit)
- [alchemist - pub.dev](https://pub.dev/packages/alchemist)
- [golden_test - pub.dev](https://pub.dev/packages/golden_test)

### 11.3 Artículos y Tutoriales

- [Flutter Golden Tests: A Comprehensive Guide - Medium](https://medium.com/profusion-engineering/golden-tests-in-flutter-a-comprehensive-guide-b4b50a932fd5)
- [How to use Alchemist for Flutter golden tests - VGV](https://www.verygood.ventures/blog/alchemist-golden-tests-tutorial)
- [Easy Flutter Golden Tests with Tolerance](https://tomasrepcik.dev/blog/2024/2024-09-19-flutter-golden-test-with-tolerance/)
- [Flutter Golden Tests with Codemagic CI/CD](https://blog.codemagic.io/flutter-golden-tests-with-codemagic-cicd/)

### 11.4 Issues y Discusiones

- [Golden files inconsistent across platforms - GitHub #36667](https://github.com/flutter/flutter/issues/36667)
- [Golden tests paint different pixels - GitHub #131559](https://github.com/flutter/flutter/issues/131559)

---

## 12. APÉNDICE: EJEMPLOS PARA DESIGN SYSTEM

### A.1 Golden Test para DSButton

```dart
// test/golden_tests/atoms/ds_button_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('DSButton Golden Tests', () {
    testWidgets('all variants', (tester) async {
      await tester.pumpWidget(
        buildGoldenTestWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DSButton.primary(text: 'Primary', onPressed: () {}),
              SizedBox(height: 8),
              DSButton.secondary(text: 'Secondary', onPressed: () {}),
              SizedBox(height: 8),
              DSButton.ghost(text: 'Ghost', onPressed: () {}),
              SizedBox(height: 8),
              DSButton.danger(text: 'Danger', onPressed: () {}),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('goldens/atoms/ds_button_all_variants.png'),
      );
    });

    testWidgets('all sizes', (tester) async {
      await tester.pumpWidget(
        buildGoldenTestWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DSButton.primary(
                text: 'Small',
                size: DSButtonSize.small,
                onPressed: () {},
              ),
              SizedBox(height: 8),
              DSButton.primary(
                text: 'Medium',
                size: DSButtonSize.medium,
                onPressed: () {},
              ),
              SizedBox(height: 8),
              DSButton.primary(
                text: 'Large',
                size: DSButtonSize.large,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(Column),
        matchesGoldenFile('goldens/atoms/ds_button_all_sizes.png'),
      );
    });

    testWidgets('disabled state', (tester) async {
      await tester.pumpWidget(
        buildGoldenTestWidget(
          child: DSButton.primary(
            text: 'Disabled',
            onPressed: null,
          ),
        ),
      );

      await expectLater(
        find.byType(DSButton),
        matchesGoldenFile('goldens/atoms/ds_button_disabled.png'),
      );
    });

    testWidgets('loading state', (tester) async {
      await tester.pumpWidget(
        buildGoldenTestWidget(
          child: DSButton.primary(
            text: 'Loading',
            isLoading: true,
            onPressed: () {},
          ),
        ),
      );

      await tester.pump(); // Para capturar el loader

      await expectLater(
        find.byType(DSButton),
        matchesGoldenFile('goldens/atoms/ds_button_loading.png'),
      );
    });
  });
}
```

### A.2 Helper para Golden Tests

```dart
// test/helpers/golden_test_helper.dart
import 'package:flutter/material.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildGoldenTestWidget({
  required Widget child,
  ThemeData? theme,
  Size? surfaceSize,
}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme ?? FakeStoreTheme.light(),
    home: Scaffold(
      body: Center(
        child: RepaintBoundary(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    ),
  );
}
```

---

**Documento generado:** 10 de Diciembre de 2025
**Autor:** Claude AI (Claude Opus 4.5)
**Propósito:** Documentación de referencia para Golden Tests en Flutter
