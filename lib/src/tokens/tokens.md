# Design Tokens

Guía completa de Design Tokens del sistema de diseño Fake Store.

## Arquitectura de Tokens

El sistema implementa una jerarquía de tokens siguiendo el estándar W3C DTCG:

```
┌─────────────────────────────────────────────────────────┐
│                    NIVEL 3                              │
│               Tokens de Componente                      │
│  (buttonPrimaryBackground, cardBorder, chipText)        │
├─────────────────────────────────────────────────────────┤
│                    NIVEL 2                              │
│               Tokens Semánticos                         │
│  (colorBrandPrimary, colorTextPrimary, colorFeedback*)  │
├─────────────────────────────────────────────────────────┤
│                    NIVEL 1                              │
│               Tokens Primitivos                         │
│  (DSColors.primary500, DSSpacing.md, DSFontSize.*)      │
└─────────────────────────────────────────────────────────┘
```

### Principio de uso

```dart
// ❌ INCORRECTO - No usar tokens primitivos directamente
Container(color: DSColors.primary500)

// ✅ CORRECTO - Usar tokens semánticos vía context
Container(color: context.tokens.colorBrandPrimary)
```

---

# DSColors

Paleta de colores primitivos del sistema de diseño.

## Propósito

- Definir la paleta completa de colores disponibles.
- Servir como base para tokens semánticos.
- Proporcionar variantes de opacidad para overlays.

## Paletas disponibles

### Primary (Purple)

| Token | Hex | Uso |
| --- | --- | --- |
| `primary50` | `#F3E5F5` | Fondos muy claros |
| `primary100` | `#E1BEE7` | Fondos claros |
| `primary200` | `#CE93D8` | Acentos suaves |
| `primary300` | `#BA68C8` | Estados hover |
| `primary400` | `#9C27B0` | Estados activos |
| `primary500` | `#6200EE` | **Color base de marca** |
| `primary600` | `#5600D9` | Estados pressed |
| `primary700` | `#4A00C4` | Textos sobre claro |
| `primary800` | `#3E00AF` | Acentos oscuros |
| `primary900` | `#32009A` | Fondos oscuros |

### Secondary (Teal)

| Token | Hex | Uso |
| --- | --- | --- |
| `secondary50` - `secondary900` | Escala teal | Acentos secundarios |
| `secondary500` | `#03DAC6` | **Color secundario base** |

### Neutral (Gray)

| Token | Hex | Uso |
| --- | --- | --- |
| `neutral50` | `#FAFAFA` | Fondo principal light |
| `neutral100` | `#F5F5F5` | Fondo secundario light |
| `neutral200` - `neutral400` | Escala | Bordes, divisores |
| `neutral500` - `neutral700` | Escala | Texto secundario |
| `neutral800` - `neutral900` | Escala | Texto principal light |
| `neutral1000` | `#121212` | Fondo principal dark |

### Feedback

| Paleta | Base | Uso |
| --- | --- | --- |
| Success | `success500` (#4CAF50) | Estados de éxito |
| Error | `error500` (#B00020) | Estados de error |
| Warning | `warning500` (#FFC107) | Advertencias |
| Info | `info500` (#2196F3) | Información |

### Special

| Token | Valor | Uso |
| --- | --- | --- |
| `white` | `#FFFFFF` | Fondo puro |
| `black` | `#000000` | Texto puro |
| `transparent` | `#00000000` | Overlays base |

### Alpha Variants

| Token | Opacidad | Uso |
| --- | --- | --- |
| `blackAlpha4` - `blackAlpha64` | 4% - 64% | Sombras, overlays light |
| `whiteAlpha8` - `whiteAlpha80` | 8% - 80% | Overlays dark mode |

---

# DSSpacing

Sistema de espaciado basado en escala de 4px.

## Escala completa

| Token | Valor | Uso recomendado |
| --- | --- | --- |
| `none` | 0px | Sin espacio |
| `xxs` | 2px | Micro ajustes |
| `xs` | 4px | Espaciado mínimo, gaps pequeños |
| `sm` | 8px | Espaciado interno pequeño |
| `md` | 12px | Espaciado interno medio |
| `base` | 16px | **Espaciado estándar** |
| `lg` | 20px | Espaciado entre secciones pequeñas |
| `xl` | 24px | Espaciado entre secciones |
| `xxl` | 32px | Espaciado grande entre secciones |
| `xxxl` | 40px | Separación de áreas |
| `jumbo` | 48px | Márgenes grandes |
| `jumboLg` | 56px | Márgenes extra |
| `mega` | 64px | Separación de vistas |
| `giga` | 80px | Espaciado hero |
| `tera` | 96px | Espaciado máximo |
| `ultra` | 120px | Casos especiales |

## Snippets

```dart
// Padding estándar
Padding(
  padding: EdgeInsets.all(DSSpacing.base),
  child: content,
)

// Gap entre elementos
Column(
  children: [
    widget1,
    SizedBox(height: DSSpacing.md),
    widget2,
  ],
)

// Padding asimétrico
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: DSSpacing.base,
    vertical: DSSpacing.sm,
  ),
  child: content,
)
```

---

# DSTypography

Sistema tipográfico basado en Material Design 3.

## DSFontFamily

| Token | Fuente | Uso |
| --- | --- | --- |
| `display` | Roboto | Headlines, títulos grandes |
| `body` | Roboto | Cuerpo de texto |
| `mono` | RobotoMono | Código, datos técnicos |

## DSFontWeight

| Token | Peso | Uso |
| --- | --- | --- |
| `light` | 300 | Texto decorativo |
| `regular` | 400 | Cuerpo de texto |
| `medium` | 500 | Labels, botones |
| `semiBold` | 600 | Subtítulos |
| `bold` | 700 | Títulos, énfasis |
| `extraBold` | 800 | Headlines |

## DSFontSize

### Display (Títulos Hero)

| Token | Tamaño | Uso |
| --- | --- | --- |
| `displayLarge` | 57px | Hero sections |
| `displayMedium` | 45px | Títulos principales |
| `displaySmall` | 36px | Subtítulos hero |

### Heading (Encabezados)

| Token | Tamaño | Uso |
| --- | --- | --- |
| `headingLarge` | 32px | H1 |
| `headingMedium` | 28px | H2 |
| `headingSmall` | 24px | H3 |

### Title (Títulos de sección)

| Token | Tamaño | Uso |
| --- | --- | --- |
| `titleLarge` | 22px | Títulos de página |
| `titleMedium` | 16px | Títulos de card |
| `titleSmall` | 14px | Subtítulos |

### Body (Cuerpo)

| Token | Tamaño | Uso |
| --- | --- | --- |
| `bodyLarge` | 16px | Párrafos principales |
| `bodyMedium` | 14px | Texto estándar |
| `bodySmall` | 12px | Texto secundario |

### Label (Etiquetas)

| Token | Tamaño | Uso |
| --- | --- | --- |
| `labelLarge` | 14px | Botones grandes |
| `labelMedium` | 12px | Botones, chips |
| `labelSmall` | 11px | Badges, captions |

### Utility

| Token | Tamaño | Uso |
| --- | --- | --- |
| `caption` | 12px | Pies de imagen, notas |
| `overline` | 10px | Categorías, labels pequeños |

## DSLineHeight

| Token | Valor | Uso |
| --- | --- | --- |
| `tight` | 1.0 | Headlines single-line |
| `snug` | 1.2 | Títulos compactos |
| `normal` | 1.5 | **Cuerpo estándar** |
| `relaxed` | 1.625 | Párrafos largos |
| `loose` | 1.75 | Texto espaciado |
| `extraLoose` | 2.0 | Listas, bullets |

## DSLetterSpacing

| Token | Valor | Uso |
| --- | --- | --- |
| `tighter` | -0.8px | Display text |
| `tight` | -0.4px | Headlines |
| `normal` | 0px | **Cuerpo estándar** |
| `wide` | 0.4px | Labels |
| `wider` | 0.8px | Overlines |
| `widest` | 1.6px | All caps |

---

# DSBorderRadius

Sistema de radios de borde para consistencia visual.

| Token | Valor | Uso |
| --- | --- | --- |
| `none` | 0px | Elementos cuadrados |
| `xs` | 2px | Bordes sutiles |
| `sm` | 4px | Inputs, pequeños |
| `md` | 8px | Buttons, chips |
| `base` | 12px | **Cards estándar** |
| `lg` | 16px | Modales |
| `xl` | 20px | Contenedores grandes |
| `xxl` | 24px | Hero cards |
| `xxxl` | 28px | Elementos destacados |
| `full` | 9999px | **Circular/Pill** |

## Snippets

```dart
// Card estándar
BorderRadius.circular(DSBorderRadius.base)

// Botón pill
BorderRadius.circular(DSBorderRadius.full)

// Solo esquinas superiores
BorderRadius.vertical(
  top: Radius.circular(DSBorderRadius.base),
)
```

---

# DSElevation

Sistema de sombras para profundidad y jerarquía visual.

## Niveles Light Mode

| Nivel | Uso | Componentes |
| --- | --- | --- |
| `none` | Sin sombra | Elementos planos |
| `level1` | Sutil | Cards en reposo |
| `level2` | Media-baja | Cards hover, chips |
| `level3` | Media | Dropdowns, tooltips |
| `level4` | Media-alta | Modales pequeños |
| `level5` | Alta | Diálogos, drawers |

## Niveles Dark Mode

| Nivel | Uso |
| --- | --- |
| `level1Dark` | Cards dark mode |
| `level2Dark` | Elevación media dark |
| `level3Dark` | Dropdowns dark |
| `level4Dark` | Modales dark |
| `level5Dark` | Diálogos dark |

## Snippets

```dart
Container(
  decoration: BoxDecoration(
    boxShadow: DSElevation.level2,
    borderRadius: BorderRadius.circular(DSBorderRadius.base),
  ),
)

// Usando tokens del tema (recomendado)
Container(
  decoration: BoxDecoration(
    boxShadow: context.tokens.elevationLevel2,
  ),
)
```

---

# DSSizes

Tamaños estándar para componentes.

## Icon Sizes

| Token | Valor | Uso |
| --- | --- | --- |
| `iconXs` | 12px | Íconos inline |
| `iconSm` | 16px | Badges, chips |
| `iconMd` | 20px | Botones pequeños |
| `iconBase` | 24px | **Íconos estándar** |
| `iconLg` | 28px | Íconos destacados |
| `iconXl` | 32px | Íconos grandes |
| `iconXxl` | 40px | Ilustraciones pequeñas |
| `iconJumbo` | 48px | Empty states |
| `iconMega` | 64px | **Ilustraciones states** |

## Button Heights (WCAG Compliant)

| Token | Valor | Nota |
| --- | --- | --- |
| `buttonXs` | 36px | Bajo mínimo WCAG |
| `buttonSm` | 44px | **Mínimo WCAG** |
| `buttonMd` | 44px | **Mínimo WCAG** |
| `buttonLg` | 48px | Recomendado |
| `buttonXl` | 56px | CTAs prominentes |

## Loader Sizes

| Token | Valor | Uso |
| --- | --- | --- |
| `loaderSm` | 16px | Botones |
| `loaderMd` | 24px | Inline |
| `loaderLg` | 36px | Secciones |
| `loaderXl` | 48px | Full screen |

## Border Widths

| Token | Valor | Uso |
| --- | --- | --- |
| `borderHairline` | 0.5px | Divisores sutiles |
| `borderThin` | 1px | **Bordes estándar** |
| `borderMedium` | 2px | Bordes destacados |
| `borderThick` | 3px | Focus rings |
| `borderHeavy` | 4px | Acentos |

---

# DSDuration & DSCurves

Sistema de animaciones.

## DSDuration

| Token | Valor | Uso |
| --- | --- | --- |
| `none` | 0ms | Sin animación |
| `instant` | 50ms | Feedback inmediato |
| `ultraFast` | 100ms | Hovers, pequeños cambios |
| `fast` | 150ms | Transiciones rápidas |
| `normal` | 200ms | **Transiciones estándar** |
| `mediumFast` | 250ms | Modales pequeños |
| `medium` | 300ms | Expansiones |
| `slow` | 400ms | Transiciones complejas |
| `slower` | 500ms | Animaciones de entrada |
| `extraSlow` | 600ms | Hero animations |
| `long` | 1000ms | Animaciones largas |

## DSCurves

| Token | Curve | Uso |
| --- | --- | --- |
| `standard` | easeInOut | **Mayoría de animaciones** |
| `standardAccelerate` | easeIn | Elementos que salen |
| `standardDecelerate` | easeOut | Elementos que entran |
| `enter` | easeOut | Entrada en pantalla |
| `exit` | easeIn | Salida de pantalla |
| `emphasized` | easeInOutCubic | Animaciones importantes |
| `emphasizedAccelerate` | easeInCubic | Salidas enfatizadas |
| `emphasizedDecelerate` | easeOutCubic | Entradas enfatizadas |
| `linear` | linear | Progreso, timers |
| `elastic` | elasticOut | Efectos bouncy |
| `bounce` | bounceOut | Efectos de rebote |

## Snippets

```dart
AnimatedContainer(
  duration: DSDuration.normal,
  curve: DSCurves.standard,
  color: isActive ? activeColor : inactiveColor,
)

// Animación de entrada
AnimatedOpacity(
  duration: DSDuration.fast,
  curve: DSCurves.enter,
  opacity: isVisible ? 1.0 : 0.0,
)
```

---

# Guía de migración

## Desde valores hardcoded

```dart
// Antes
Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Color(0xFF6200EE),
    borderRadius: BorderRadius.circular(12),
  ),
)

// Después
Container(
  padding: EdgeInsets.all(DSSpacing.base),
  margin: EdgeInsets.symmetric(vertical: DSSpacing.sm),
  decoration: BoxDecoration(
    color: context.tokens.colorBrandPrimary,
    borderRadius: BorderRadius.circular(DSBorderRadius.base),
  ),
)
```

## Desde Theme.of(context)

```dart
// Antes
final primary = Theme.of(context).primaryColor;

// Después
final primary = context.tokens.colorBrandPrimary;
```
