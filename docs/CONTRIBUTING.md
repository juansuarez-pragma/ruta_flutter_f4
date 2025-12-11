# Guía de Contribución

Guía para contribuir al Design System Fake Store.

## Requisitos previos

- Flutter SDK 3.x+
- Dart SDK 3.x+
- Editor con soporte Dart (VS Code, Android Studio)

## Configuración inicial

```bash
# Clonar repositorio
git clone <repository-url>
cd fake_store_design_system

# Obtener dependencias
flutter pub get

# Verificar que todo funciona
flutter test
flutter analyze
```

---

## Workflow de desarrollo

### 1. Crear rama

```bash
git checkout -b feature/ds-nuevo-componente
# o
git checkout -b fix/ds-button-hover-state
```

### 2. Desarrollar

Seguir las convenciones descritas en `ARCHITECTURE.md`.

### 3. Verificar calidad

```bash
# Formatear código
dart format .

# Analizar código
flutter analyze

# Ejecutar tests
flutter test

# Verificar cobertura
flutter test --coverage
```

### 4. Commit

```bash
git add .
git commit -m "feat(atoms): add DSSwitch component"
```

### 5. Push y PR

```bash
git push origin feature/ds-nuevo-componente
# Crear Pull Request
```

---

## Agregar nuevo componente

### Paso 1: Crear archivo

```dart
// lib/src/atoms/switches/ds_switch.dart

import 'package:flutter/material.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';

/// Switch del sistema de diseño.
///
/// ## Uso básico
///
/// ```dart
/// DSSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
/// )
/// ```
class DSSwitch extends StatelessWidget {
  /// Si el switch está activo.
  final bool value;

  /// Callback cuando cambia el valor.
  final ValueChanged<bool>? onChanged;

  const DSSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: tokens.colorBrandPrimary,
      activeTrackColor: tokens.colorBrandPrimaryLight,
      inactiveThumbColor: tokens.colorIconSecondary,
      inactiveTrackColor: tokens.colorBorderSecondary,
    );
  }
}
```

### Paso 2: Exportar en barrel file

```dart
// lib/src/atoms/atoms.dart
export 'buttons/ds_button.dart';
export 'buttons/ds_icon_button.dart';
// ... otros exports
export 'switches/ds_switch.dart';  // <- Nuevo
```

### Paso 3: Crear tests

```dart
// test/atoms/switches/ds_switch_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('DSSwitch', () {
    testWidgets('renders correctly when off', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          DSSwitch(
            value: false,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('renders correctly when on', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          DSSwitch(
            value: true,
            onChanged: (_) {},
          ),
        ),
      );

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
    });

    testWidgets('calls onChanged when toggled', (tester) async {
      bool value = false;

      await tester.pumpWidget(
        wrapWithTheme(
          StatefulBuilder(
            builder: (context, setState) {
              return DSSwitch(
                value: value,
                onChanged: (newValue) {
                  setState(() => value = newValue);
                },
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(value, isTrue);
    });

    testWidgets('is disabled when onChanged is null', (tester) async {
      await tester.pumpWidget(
        wrapWithTheme(
          DSSwitch(
            value: false,
            onChanged: null,
          ),
        ),
      );

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.onChanged, isNull);
    });
  });
}
```

### Paso 4: Crear documentación

```markdown
<!-- lib/src/atoms/switches/switch.md -->

# DSSwitch

Switch del sistema de diseño para toggles de configuración.

## Propósito

- Permitir activar/desactivar opciones binarias.
- Proporcionar feedback visual inmediato.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `value` | `bool` | — | Estado actual (requerido). |
| `onChanged` | `ValueChanged<bool>?` | `null` | Callback al cambiar. |

## Tokens usados

- `colorBrandPrimary` - Thumb activo
- `colorBrandPrimaryLight` - Track activo
- `colorIconSecondary` - Thumb inactivo
- `colorBorderSecondary` - Track inactivo

## Snippets

### Básico

```dart
DSSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

### Deshabilitado

```dart
DSSwitch(
  value: true,
  onChanged: null,
)
```
```

### Paso 5: Agregar a example app (opcional)

Agregar demostración en la app de ejemplo si el componente es significativo.

---

## Agregar nuevo token

### Paso 1: Token primitivo (si es nuevo valor)

```dart
// lib/src/tokens/ds_colors.dart
abstract final class DSColors {
  // ... existentes

  /// Nuevo color para feature específico
  static const Color feature500 = Color(0xFF123456);
}
```

### Paso 2: Token semántico en DSThemeData

```dart
// lib/src/foundations/theme/ds_theme_data.dart
class DSThemeData extends ThemeExtension<DSThemeData> {
  // ... existentes

  /// Color para el nuevo feature
  final Color colorFeature;

  const DSThemeData({
    // ... existentes
    required this.colorFeature,
  });

  @override
  DSThemeData copyWith({
    // ... existentes
    Color? colorFeature,
  }) {
    return DSThemeData(
      // ... existentes
      colorFeature: colorFeature ?? this.colorFeature,
    );
  }

  @override
  DSThemeData lerp(covariant DSThemeData? other, double t) {
    if (other is! DSThemeData) return this;
    return DSThemeData(
      // ... existentes
      colorFeature: Color.lerp(colorFeature, other.colorFeature, t)!,
    );
  }
}
```

### Paso 3: Valor en tema claro

```dart
// lib/src/foundations/theme/ds_theme_light.dart
abstract final class DSThemeLight {
  static const DSThemeData data = DSThemeData(
    // ... existentes
    colorFeature: DSColors.feature500,
  );
}
```

### Paso 4: Valor en tema oscuro

```dart
// lib/src/foundations/theme/ds_theme_dark.dart
abstract final class DSThemeDark {
  static const DSThemeData data = DSThemeData(
    // ... existentes
    colorFeature: DSColors.feature300,  // Ajustado para dark mode
  );
}
```

### Paso 5: Tests

```dart
// test/foundations/theme_test.dart
test('colorFeature is defined in light theme', () {
  expect(DSThemeLight.data.colorFeature, isNotNull);
});

test('colorFeature is defined in dark theme', () {
  expect(DSThemeDark.data.colorFeature, isNotNull);
});
```

---

## Estándares de código

### Dartdoc

Todos los elementos públicos deben tener documentación:

```dart
/// Descripción breve en una línea.
///
/// Descripción más larga si es necesario.
/// Puede incluir múltiples párrafos.
///
/// ## Uso básico
///
/// ```dart
/// Ejemplo de código
/// ```
///
/// ## Parámetros
///
/// - [param1]: Descripción del parámetro.
/// - [param2]: Descripción del parámetro.
```

### Formato

- Usar `dart format .` antes de commit
- Líneas máximo 80 caracteres
- Trailing commas en parámetros multilinea

### Imports

Orden de imports:

1. `dart:` (core libraries)
2. `package:flutter/` (Flutter)
3. `package:` (otras dependencias)
4. Imports relativos del proyecto

```dart
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
```

---

## Testing

### Estructura de test

```dart
void main() {
  group('ComponentName', () {
    // Setup común
    late SomeService mockService;

    setUp(() {
      mockService = MockService();
    });

    group('rendering', () {
      testWidgets('renders correctly', (tester) async {
        // ...
      });

      testWidgets('shows loading state', (tester) async {
        // ...
      });
    });

    group('interactions', () {
      testWidgets('calls onTap when pressed', (tester) async {
        // ...
      });
    });

    group('accessibility', () {
      testWidgets('has correct semantics', (tester) async {
        // ...
      });

      testWidgets('meets touch target size', (tester) async {
        // ...
      });
    });
  });
}
```

### Helper para tests

```dart
// test/helpers/test_helpers.dart

Widget wrapWithTheme(Widget child, {bool isDarkMode = false}) {
  return MaterialApp(
    theme: isDarkMode ? FakeStoreTheme.dark() : FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );
}

Widget wrapWithScaffold(Widget child) {
  return wrapWithTheme(
    Scaffold(body: Center(child: child)),
  );
}
```

---

## Commits

### Formato

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Uso |
| --- | --- |
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `docs` | Solo documentación |
| `style` | Formato, sin cambio de código |
| `refactor` | Refactoring sin cambio funcional |
| `test` | Agregar/modificar tests |
| `chore` | Mantenimiento, configs |

### Scopes

| Scope | Uso |
| --- | --- |
| `atoms` | Componentes atómicos |
| `molecules` | Componentes moleculares |
| `organisms` | Componentes de organismo |
| `tokens` | Design tokens |
| `theme` | Sistema de temas |
| `docs` | Documentación |
| `example` | App de ejemplo |

### Ejemplos

```bash
feat(atoms): add DSSwitch component

fix(molecules): correct DSCard hover state color

docs(atoms): add button.md documentation

test(organisms): add DSProductGrid loading state tests

refactor(tokens): reorganize color primitives
```

---

## Checklist para PR

- [ ] Código formateado (`dart format .`)
- [ ] Sin errores de análisis (`flutter analyze`)
- [ ] Tests pasan (`flutter test`)
- [ ] Cobertura adecuada para nuevas funcionalidades
- [ ] Documentación dartdoc completa
- [ ] Archivo .md si es componente significativo
- [ ] Exportado en barrel file correspondiente
- [ ] Commit messages siguen convención
- [ ] PR description clara y completa

---

## Recursos

- [ARCHITECTURE.md](./ARCHITECTURE.md) - Arquitectura del sistema
- [tokens.md](../lib/src/tokens/tokens.md) - Guía de tokens
- [theme.md](../lib/src/foundations/theme/theme.md) - Sistema de temas
- [Atomic Design](https://atomicdesign.bradfrost.com/) - Metodología
- [W3C Design Tokens](https://design-tokens.github.io/community-group/format/) - Estándar de tokens
