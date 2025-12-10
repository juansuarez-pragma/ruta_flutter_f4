# Sistema de Temas

Guía completa del sistema de temas del Design System Fake Store.

## Arquitectura

El sistema de temas se basa en `ThemeExtension` de Flutter para distribuir tokens semánticos a través del árbol de widgets.

```
┌─────────────────────────────────────────────────────────┐
│                   MaterialApp                           │
│  ┌───────────────────────────────────────────────────┐  │
│  │  theme: FakeStoreTheme.light()                    │  │
│  │  darkTheme: FakeStoreTheme.dark()                 │  │
│  │  themeMode: ThemeMode.system                      │  │
│  └───────────────────────────────────────────────────┘  │
│                         │                               │
│                         ▼                               │
│  ┌───────────────────────────────────────────────────┐  │
│  │              ThemeData                            │  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │  extensions: [DSThemeData(...)]             │  │  │
│  │  │  - 85+ tokens semánticos                    │  │  │
│  │  │  - Colores, tipografía, elevación           │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────┘  │
│                         │                               │
│                         ▼                               │
│  ┌───────────────────────────────────────────────────┐  │
│  │  context.tokens / FakeStoreTheme.of(context)      │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

---

# FakeStoreTheme

Clase de conveniencia para acceder al sistema de temas.

## API

| Método | Retorno | Descripción |
| --- | --- | --- |
| `FakeStoreTheme.light()` | `ThemeData` | Tema claro completo |
| `FakeStoreTheme.dark()` | `ThemeData` | Tema oscuro completo |
| `FakeStoreTheme.of(context)` | `DSThemeData` | Tokens desde contexto (lanza si no existe) |
| `FakeStoreTheme.maybeOf(context)` | `DSThemeData?` | Tokens desde contexto (null si no existe) |
| `FakeStoreTheme.lightData` | `DSThemeData` | Solo datos del tema claro |
| `FakeStoreTheme.darkData` | `DSThemeData` | Solo datos del tema oscuro |

## Configuración básica

```dart
void main() {
  runApp(
    MaterialApp(
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: ThemeMode.system, // Automático según OS
      home: MyApp(),
    ),
  );
}
```

## Acceso a tokens

```dart
@override
Widget build(BuildContext context) {
  // Opción 1: Extensión de contexto (recomendado)
  final tokens = context.tokens;

  // Opción 2: Método estático
  final tokens = FakeStoreTheme.of(context);

  return Container(
    color: tokens.colorSurfacePrimary,
    child: Text(
      'Hola',
      style: tokens.typographyBodyMedium,
    ),
  );
}
```

---

# DSThemeData

Clase que contiene todos los tokens semánticos del sistema de diseño.

## Categorías de tokens

### Surface Colors (5 tokens)

| Token | Descripción | Light | Dark |
| --- | --- | --- | --- |
| `colorSurfacePrimary` | Fondo principal | `neutral50` | `neutral1000` |
| `colorSurfaceSecondary` | Fondo secundario | `neutral100` | `neutral900` |
| `colorSurfaceTertiary` | Fondo elevado | `neutral200` | `neutral800` |
| `colorSurfaceInverse` | Superficie inversa | `neutral900` | `neutral50` |
| `colorSurfaceOverlay` | Overlay/scrim | `blackAlpha48` | `blackAlpha64` |

### Text Colors (6 tokens)

| Token | Descripción | Light | Dark |
| --- | --- | --- | --- |
| `colorTextPrimary` | Texto principal | `neutral900` | `neutral50` |
| `colorTextSecondary` | Texto secundario | `neutral700` | `neutral300` |
| `colorTextTertiary` | Texto terciario | `neutral500` | `neutral500` |
| `colorTextInverse` | Texto sobre oscuro | `white` | `neutral900` |
| `colorTextDisabled` | Texto deshabilitado | `neutral400` | `neutral600` |
| `colorTextLink` | Enlaces | `primary500` | `primary300` |

### Border Colors (4 tokens)

| Token | Descripción |
| --- | --- |
| `colorBorderPrimary` | Borde principal |
| `colorBorderSecondary` | Borde secundario |
| `colorBorderFocus` | Borde en focus |
| `colorBorderError` | Borde en error |

### Icon Colors (4 tokens)

| Token | Descripción |
| --- | --- |
| `colorIconPrimary` | Ícono principal |
| `colorIconSecondary` | Ícono secundario |
| `colorIconInverse` | Ícono inverso |
| `colorIconDisabled` | Ícono deshabilitado |

### Brand Colors (4 tokens)

| Token | Descripción |
| --- | --- |
| `colorBrandPrimary` | Color de marca principal |
| `colorBrandSecondary` | Color de marca secundario |
| `colorBrandPrimaryLight` | Marca primaria clara |
| `colorBrandPrimaryDark` | Marca primaria oscura |

### Feedback Colors (8 tokens)

| Token | Descripción |
| --- | --- |
| `colorFeedbackSuccess` | Éxito (texto/ícono) |
| `colorFeedbackSuccessLight` | Éxito (fondo) |
| `colorFeedbackError` | Error (texto/ícono) |
| `colorFeedbackErrorLight` | Error (fondo) |
| `colorFeedbackWarning` | Advertencia (texto/ícono) |
| `colorFeedbackWarningLight` | Advertencia (fondo) |
| `colorFeedbackInfo` | Información (texto/ícono) |
| `colorFeedbackInfoLight` | Información (fondo) |

### Button Tokens (24 tokens)

**Primary** (6 tokens):
- `buttonPrimaryBackground`, `buttonPrimaryBackgroundHover`
- `buttonPrimaryBackgroundPressed`, `buttonPrimaryBackgroundDisabled`
- `buttonPrimaryText`, `buttonPrimaryTextDisabled`

**Secondary** (6 tokens):
- `buttonSecondaryBackground`, `buttonSecondaryBackgroundHover`
- `buttonSecondaryBackgroundPressed`, `buttonSecondaryBorder`
- `buttonSecondaryText`, `buttonSecondaryTextDisabled`

**Ghost** (5 tokens):
- `buttonGhostBackground`, `buttonGhostBackgroundHover`
- `buttonGhostBackgroundPressed`
- `buttonGhostText`, `buttonGhostTextDisabled`

**Danger** (6 tokens):
- `buttonDangerBackground`, `buttonDangerBackgroundHover`
- `buttonDangerBackgroundPressed`, `buttonDangerBackgroundDisabled`
- `buttonDangerText`, `buttonDangerTextDisabled`

### Card Tokens (3 tokens)

| Token | Descripción |
| --- | --- |
| `cardBackground` | Fondo de card |
| `cardBackgroundHover` | Fondo en hover |
| `cardBorder` | Borde de card |

### Input Tokens (7 tokens)

| Token | Descripción |
| --- | --- |
| `inputBackground` | Fondo del input |
| `inputBackgroundFocused` | Fondo en focus |
| `inputBorder` | Borde normal |
| `inputBorderFocused` | Borde en focus |
| `inputBorderError` | Borde en error |
| `inputText` | Texto del input |
| `inputPlaceholder` | Placeholder |

### Chip Tokens (7 tokens)

| Token | Descripción |
| --- | --- |
| `chipBackground` | Fondo normal |
| `chipBackgroundHover` | Fondo en hover |
| `chipBackgroundPressed` | Fondo presionado |
| `chipBackgroundSelected` | Fondo seleccionado |
| `chipText` | Texto normal |
| `chipTextSelected` | Texto seleccionado |
| `chipBorder` | Borde |

### Badge Tokens (2 tokens)

| Token | Descripción |
| --- | --- |
| `badgeBackground` | Fondo neutral |
| `badgeText` | Texto neutral |

### Typography Tokens (18 estilos)

| Token | Uso |
| --- | --- |
| `typographyDisplayLarge` | Hero titles |
| `typographyDisplayMedium` | Main titles |
| `typographyDisplaySmall` | Section titles |
| `typographyHeadingLarge` | H1 |
| `typographyHeadingMedium` | H2 |
| `typographyHeadingSmall` | H3 |
| `typographyTitleLarge` | Page titles |
| `typographyTitleMedium` | Card titles |
| `typographyTitleSmall` | Subtitles |
| `typographyBodyLarge` | Main paragraphs |
| `typographyBodyMedium` | Standard text |
| `typographyBodySmall` | Secondary text |
| `typographyLabelLarge` | Large buttons |
| `typographyLabelMedium` | Buttons, chips |
| `typographyLabelSmall` | Small labels |
| `typographyCaption` | Captions, hints |
| `typographyOverline` | Categories |
| `typographyButton` | Button text |

### Elevation Tokens (5 niveles)

| Token | Uso |
| --- | --- |
| `elevationLevel1` | Cards en reposo |
| `elevationLevel2` | Cards hover |
| `elevationLevel3` | Dropdowns |
| `elevationLevel4` | Modales pequeños |
| `elevationLevel5` | Diálogos |

---

# Implementación de ThemeExtension

## copyWith

Permite crear variantes del tema modificando tokens específicos:

```dart
final customTheme = FakeStoreTheme.lightData.copyWith(
  colorBrandPrimary: Colors.blue,
  colorBrandSecondary: Colors.cyan,
);
```

## lerp

Permite interpolación suave entre temas (útil para animaciones):

```dart
// Flutter usa lerp internamente para AnimatedTheme
AnimatedTheme(
  data: isDarkMode
    ? FakeStoreTheme.dark()
    : FakeStoreTheme.light(),
  duration: Duration(milliseconds: 300),
  child: MyApp(),
)
```

---

# Context Extension

El archivo `context_extension.dart` proporciona acceso conveniente:

```dart
extension DSContextExtension on BuildContext {
  /// Acceso directo a tokens del tema
  DSThemeData get tokens => FakeStoreTheme.of(this);

  /// Verifica si está en modo oscuro
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Verifica si está en modo claro
  bool get isLightMode => !isDarkMode;

  /// Verifica si es dispositivo móvil
  bool get isMobile => MediaQuery.of(this).size.width < 600;

  /// Verifica si es tablet
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
}
```

## Uso en widgets

```dart
@override
Widget build(BuildContext context) {
  final tokens = context.tokens;

  return Container(
    color: tokens.colorSurfacePrimary,
    padding: EdgeInsets.all(DSSpacing.base),
    child: Column(
      children: [
        Text(
          'Título',
          style: tokens.typographyHeadingMedium.copyWith(
            color: tokens.colorTextPrimary,
          ),
        ),
        if (context.isDarkMode)
          Icon(Icons.dark_mode, color: tokens.colorIconPrimary),
        if (context.isMobile)
          Text('Vista móvil', style: tokens.typographyCaption),
      ],
    ),
  );
}
```

---

# Crear tema personalizado

## Opción 1: Modificar tema existente

```dart
final customLightTheme = FakeStoreTheme.light().copyWith(
  extensions: [
    FakeStoreTheme.lightData.copyWith(
      colorBrandPrimary: const Color(0xFF1976D2), // Azul
      colorBrandSecondary: const Color(0xFF03A9F4),
    ),
  ],
);

MaterialApp(
  theme: customLightTheme,
  // ...
)
```

## Opción 2: Crear DSThemeData completo

```dart
const myCustomTheme = DSThemeData(
  // Surface
  colorSurfacePrimary: Color(0xFFF5F5F5),
  colorSurfaceSecondary: Color(0xFFEEEEEE),
  // ... (85+ tokens requeridos)
);

final themeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  extensions: [myCustomTheme],
);
```

---

# Manejo de errores

Si intentas acceder a tokens sin configurar el tema:

```dart
// Esto lanza FlutterError con mensaje descriptivo
final tokens = FakeStoreTheme.of(context);

// Error:
// DSThemeData not found in context.
// No DSThemeData was found in the widget tree.
// This usually means FakeStoreTheme.light() or FakeStoreTheme.dark()
// is not set as the theme in MaterialApp.
//
// Ensure your MaterialApp is configured like this:
//   MaterialApp(
//     theme: FakeStoreTheme.light(),
//     darkTheme: FakeStoreTheme.dark(),
//   )
```

Para verificar sin lanzar error:

```dart
final tokens = FakeStoreTheme.maybeOf(context);
if (tokens != null) {
  // Usar tokens
} else {
  // Fallback
}
```

---

# Mejores prácticas

## DO

```dart
// Usar extensión de contexto
final tokens = context.tokens;

// Usar tokens semánticos
Container(color: tokens.colorSurfacePrimary)

// Combinar con copyWith para ajustes
Text('Hola', style: tokens.typographyBodyMedium.copyWith(
  fontWeight: FontWeight.bold,
))
```

## DON'T

```dart
// No usar colores primitivos directamente
Container(color: DSColors.primary500)

// No hardcodear colores
Container(color: Color(0xFF6200EE))

// No usar Theme.of directamente para tokens
final tokens = Theme.of(context).extension<DSThemeData>()!;
// Mejor usar: context.tokens
```

---

# Soporte de plataformas

El sistema de temas soporta:

| Plataforma | ThemeMode.system | Notas |
| --- | --- | --- |
| Android | Sigue configuración del sistema | |
| iOS | Sigue configuración del sistema | |
| Web | Detecta `prefers-color-scheme` | |
| macOS | Sigue configuración del sistema | |
| Windows | Sigue configuración del sistema | |
| Linux | Depende del DE | |

```dart
MaterialApp(
  themeMode: ThemeMode.system, // Respeta preferencia del usuario
  theme: FakeStoreTheme.light(),
  darkTheme: FakeStoreTheme.dark(),
)
```
