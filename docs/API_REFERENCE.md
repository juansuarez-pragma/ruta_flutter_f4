# API Reference

Documentación técnica completa de todos los tokens y componentes del Design System.

## Tabla de Contenidos

- [Tokens](#tokens)
  - [Colores](#colores)
  - [Espaciado](#espaciado)
  - [Tipografía](#tipografía)
  - [Border Radius](#border-radius)
  - [Elevación](#elevación)
  - [Tamaños](#tamaños)
- [Componentes](#componentes)
  - [Átomos](#átomos)
  - [Moléculas](#moléculas)
  - [Organismos](#organismos)
- [Utilidades](#utilidades)

---

## Tokens

### Colores

#### Primitivos (DSColors)

| Token | Valor | Descripción |
|-------|-------|-------------|
| `primary50` | `#EEF2FF` | Primary más claro |
| `primary100` | `#E0E7FF` | Primary claro |
| `primary200` | `#C7D2FE` | Primary suave |
| `primary300` | `#A5B4FC` | Primary medio-claro |
| `primary400` | `#818CF8` | Primary medio |
| `primary500` | `#6366F1` | **Primary base** |
| `primary600` | `#4F46E5` | Primary oscuro |
| `primary700` | `#4338CA` | Primary más oscuro |
| `primary800` | `#3730A3` | Primary profundo |
| `primary900` | `#312E81` | Primary máximo |

| Token | Valor | Descripción |
|-------|-------|-------------|
| `neutral50` | `#FAFAFA` | Blanco casi puro |
| `neutral100` | `#F5F5F5` | Gris muy claro |
| `neutral200` | `#E5E5E5` | Gris claro |
| `neutral300` | `#D4D4D4` | Gris suave |
| `neutral400` | `#A3A3A3` | Gris medio |
| `neutral500` | `#737373` | **Gris base** |
| `neutral600` | `#525252` | Gris oscuro |
| `neutral700` | `#404040` | Gris más oscuro |
| `neutral800` | `#262626` | Gris profundo |
| `neutral900` | `#171717` | Casi negro |

| Token | Valor | Uso |
|-------|-------|-----|
| `success500` | `#22C55E` | Feedback éxito |
| `error500` | `#EF4444` | Feedback error |
| `warning500` | `#F59E0B` | Feedback advertencia |
| `info500` | `#3B82F6` | Feedback información |

#### Semánticos (via context.tokens)

| Token | Tema Claro | Tema Oscuro | Uso |
|-------|------------|-------------|-----|
| `colorSurfacePrimary` | `neutral50` | `neutral900` | Fondo principal |
| `colorSurfaceSecondary` | `neutral100` | `neutral800` | Fondo secundario |
| `colorSurfaceTertiary` | `neutral200` | `neutral700` | Fondo terciario |
| `colorTextPrimary` | `neutral900` | `neutral50` | Texto principal |
| `colorTextSecondary` | `neutral600` | `neutral400` | Texto secundario |
| `colorTextTertiary` | `neutral400` | `neutral500` | Texto deshabilitado |
| `colorBrandPrimary` | `primary500` | `primary400` | Color de marca |
| `colorBorderPrimary` | `neutral300` | `neutral700` | Bordes |
| `colorFeedbackSuccess` | `success500` | `success400` | Éxito |
| `colorFeedbackError` | `error500` | `error400` | Error |

---

### Espaciado

Sistema basado en escala de 4px.

| Token | Valor | Uso común |
|-------|-------|-----------|
| `DSSpacing.xxs` | `2px` | Micro espaciado |
| `DSSpacing.xs` | `4px` | Espaciado mínimo |
| `DSSpacing.sm` | `8px` | Espaciado pequeño |
| `DSSpacing.md` | `12px` | Espaciado medio |
| `DSSpacing.base` | `16px` | **Espaciado base** |
| `DSSpacing.lg` | `20px` | Espaciado grande |
| `DSSpacing.xl` | `24px` | Espaciado extra grande |
| `DSSpacing.xxl` | `32px` | Espaciado máximo |

---

### Tipografía

#### Tamaños (DSFontSize)

| Token | Valor | Uso |
|-------|-------|-----|
| `displayLarge` | `48px` | Títulos hero |
| `displayMedium` | `40px` | Títulos grandes |
| `headingLarge` | `32px` | Encabezados H1 |
| `headingMedium` | `28px` | Encabezados H2 |
| `headingSmall` | `24px` | Encabezados H3 |
| `titleLarge` | `22px` | Títulos de sección |
| `titleMedium` | `18px` | Subtítulos |
| `bodyLarge` | `16px` | Texto principal |
| `bodyMedium` | `14px` | **Texto base** |
| `bodySmall` | `12px` | Texto pequeño |
| `labelMedium` | `14px` | Labels |
| `caption` | `12px` | Texto auxiliar |

#### Pesos (DSFontWeight)

| Token | Valor | Uso |
|-------|-------|-----|
| `regular` | `400` | Texto normal |
| `medium` | `500` | Énfasis leve |
| `semibold` | `600` | Énfasis medio |
| `bold` | `700` | Énfasis fuerte |

---

### Border Radius

| Token | Valor | Uso |
|-------|-------|-----|
| `DSBorderRadius.none` | `0px` | Sin redondeo |
| `DSBorderRadius.xs` | `2px` | Mínimo |
| `DSBorderRadius.sm` | `4px` | Pequeño |
| `DSBorderRadius.md` | `8px` | Medio |
| `DSBorderRadius.base` | `12px` | **Base** |
| `DSBorderRadius.lg` | `16px` | Grande |
| `DSBorderRadius.xl` | `24px` | Extra grande |
| `DSBorderRadius.full` | `9999px` | Pill/Circular |

---

### Elevación

| Token | Descripción | Uso |
|-------|-------------|-----|
| `tokens.elevationLevel0` | Sin sombra | Elementos planos |
| `tokens.elevationLevel1` | Sombra sutil | Cards, chips |
| `tokens.elevationLevel2` | Sombra media | Dropdowns, popovers |
| `tokens.elevationLevel3` | Sombra pronunciada | Modales |
| `tokens.elevationLevel4` | Sombra máxima | Diálogos |

---

### Tamaños (DSSizes)

#### Iconos

| Token | Valor |
|-------|-------|
| `iconXs` | `12px` |
| `iconSm` | `16px` |
| `iconMd` | `20px` |
| `iconBase` | `24px` |
| `iconLg` | `28px` |
| `iconXl` | `32px` |
| `iconXxl` | `40px` |
| `iconJumbo` | `48px` |
| `iconMega` | `64px` |

#### Botones (WCAG 2.1 compliant)

| Token | Valor | Nota |
|-------|-------|------|
| `buttonXs` | `36px` | Bajo mínimo WCAG |
| `buttonSm` | `44px` | Mínimo WCAG |
| `buttonMd` | `44px` | Mínimo WCAG |
| `buttonLg` | `48px` | Recomendado |
| `buttonXl` | `56px` | Extra grande |

---

## Componentes

### Átomos

#### DSButton

Botón con 4 variantes y 3 tamaños.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `text` | `String` | required | Texto del botón |
| `onPressed` | `VoidCallback?` | `null` | Callback (null = disabled) |
| `variant` | `DSButtonVariant` | `primary` | Estilo visual |
| `size` | `DSButtonSize` | `medium` | Tamaño |
| `isLoading` | `bool` | `false` | Muestra spinner |
| `icon` | `IconData?` | `null` | Ícono izquierdo |
| `isFullWidth` | `bool` | `false` | Ancho completo |

**Variantes:**

| Variante | Constructor | Uso |
|----------|-------------|-----|
| Primary | `DSButton.primary()` | Acciones principales |
| Secondary | `DSButton.secondary()` | Acciones secundarias |
| Ghost | `DSButton.ghost()` | Acciones terciarias |
| Danger | `DSButton.danger()` | Acciones destructivas |

**Ejemplo:**

```dart
DSButton.primary(
  text: 'Guardar cambios',
  icon: Icons.save,
  onPressed: () => saveData(),
  isLoading: isSaving,
)

DSButton.danger(
  text: 'Eliminar',
  icon: Icons.delete,
  onPressed: () => confirmDelete(),
)
```

---

#### DSIconButton

Botón circular solo con ícono.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `icon` | `IconData` | required | Ícono a mostrar |
| `onPressed` | `VoidCallback?` | `null` | Callback |
| `tooltip` | `String?` | `null` | Texto accesible |
| `variant` | `DSIconButtonVariant` | `primary` | Estilo |
| `size` | `DSIconButtonSize` | `medium` | Tamaño |
| `isLoading` | `bool` | `false` | Estado de carga |

**Ejemplo:**

```dart
DSIconButton(
  icon: Icons.favorite,
  tooltip: 'Agregar a favoritos',
  onPressed: () => toggleFavorite(),
)
```

---

#### DSBadge

Badge para estados y etiquetas.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `text` | `String` | required | Texto del badge |
| `type` | `DSBadgeType` | `neutral` | Tipo semántico |
| `size` | `DSBadgeSize` | `medium` | Tamaño |

**Tipos:**

| Tipo | Constructor | Color | Uso |
|------|-------------|-------|-----|
| Success | `DSBadge.success()` | Verde | Estados positivos |
| Error | `DSBadge.error()` | Rojo | Estados negativos |
| Warning | `DSBadge.warning()` | Amarillo | Advertencias |
| Info | `DSBadge.info()` | Azul | Información |
| Neutral | `DSBadge.neutral()` | Gris | Etiquetas neutras |

**Ejemplo:**

```dart
DSBadge.success(text: 'En stock')
DSBadge.error(text: 'Agotado')
DSBadge.warning(text: 'Últimas unidades', size: DSBadgeSize.small)
```

---

#### DSText

Componente de texto con variantes tipográficas.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `text` | `String` | required | Texto a mostrar |
| `variant` | `DSTextVariant` | `bodyMedium` | Estilo tipográfico |
| `color` | `Color?` | `null` | Color personalizado |
| `textAlign` | `TextAlign?` | `null` | Alineación |
| `maxLines` | `int?` | `null` | Líneas máximas |
| `overflow` | `TextOverflow?` | `null` | Comportamiento overflow |

**Variantes (12):**

```dart
DSText.displayLarge('Hero')
DSText.displayMedium('Display')
DSText.headingLarge('H1')
DSText.headingMedium('H2')
DSText.headingSmall('H3')
DSText.titleLarge('Title')
DSText.titleMedium('Subtitle')
DSText.bodyLarge('Body Large')
DSText.bodyMedium('Body')        // Default
DSText.bodySmall('Small')
DSText.labelMedium('Label')
DSText.caption('Caption')
```

---

#### DSTextField

Campo de texto con validación visual.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `label` | `String?` | `null` | Etiqueta superior |
| `hintText` | `String?` | `null` | Placeholder |
| `errorText` | `String?` | `null` | Mensaje de error |
| `helperText` | `String?` | `null` | Texto de ayuda |
| `prefixIcon` | `IconData?` | `null` | Ícono izquierdo |
| `suffixIcon` | `IconData?` | `null` | Ícono derecho |
| `obscureText` | `bool` | `false` | Ocultar texto (password) |
| `enabled` | `bool` | `true` | Habilitado |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback cambio |
| `controller` | `TextEditingController?` | `null` | Controller |
| `semanticLabel` | `String?` | `null` | Label accesible |

**Ejemplo:**

```dart
DSTextField(
  label: 'Correo electrónico',
  hintText: 'ejemplo@correo.com',
  prefixIcon: Icons.email,
  errorText: isValid ? null : 'Correo inválido',
  onChanged: (value) => validateEmail(value),
)
```

---

#### DSCircularLoader

Indicador de carga circular.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `size` | `DSLoaderSize` | `medium` | Tamaño |
| `message` | `String?` | `null` | Texto bajo loader |
| `color` | `Color?` | `null` | Color personalizado |

**Tamaños:**

| Tamaño | Valor |
|--------|-------|
| `small` | `16px` |
| `medium` | `24px` |
| `large` | `36px` |
| `xlarge` | `48px` |

---

#### DSSkeleton

Placeholder animado para estados de carga.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `width` | `double` | required | Ancho |
| `height` | `double` | required | Alto |
| `borderRadius` | `double` | `DSBorderRadius.sm` | Radio de borde |

**Ejemplo:**

```dart
DSSkeleton(width: double.infinity, height: 200)  // Imagen
DSSkeleton(width: 150, height: 16)               // Línea de texto
```

---

### Moléculas

#### DSCard

Card contenedora con elevación.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `child` | `Widget` | required | Contenido |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `padding` | `EdgeInsets?` | `null` | Padding interno |
| `elevation` | `DSElevationLevel` | `level1` | Nivel sombra |
| `borderRadius` | `double` | `DSBorderRadius.base` | Radio borde |

---

#### DSProductCard

Card especializada para productos e-commerce.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `imageUrl` | `String` | required | URL de imagen |
| `title` | `String` | required | Nombre producto |
| `price` | `double` | required | Precio |
| `rating` | `double?` | `null` | Rating (0-5) |
| `reviewCount` | `int?` | `null` | Cantidad reviews |
| `badge` | `String?` | `null` | Badge opcional |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `onAddToCart` | `VoidCallback?` | `null` | Callback carrito |
| `isLoading` | `bool` | `false` | Estado carga |
| `imageSemanticLabel` | `String?` | `null` | Label accesible |

**Ejemplo:**

```dart
DSProductCard(
  imageUrl: product.image,
  title: product.title,
  price: product.price,
  rating: product.rating.rate,
  reviewCount: product.rating.count,
  badge: product.isNew ? 'Nuevo' : null,
  onTap: () => navigateToDetail(product),
  onAddToCart: () => addToCart(product),
)
```

---

#### DSFilterChip

Chip seleccionable para filtros.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `label` | `String` | required | Texto del chip |
| `isSelected` | `bool` | `false` | Estado selección |
| `onTap` | `VoidCallback?` | `null` | Callback tap |
| `icon` | `IconData?` | `null` | Ícono opcional |

---

#### DSEmptyState

Vista para estados vacíos.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `icon` | `IconData` | required | Ícono ilustrativo |
| `title` | `String` | required | Título |
| `description` | `String?` | `null` | Descripción |
| `actionText` | `String?` | `null` | Texto botón |
| `onAction` | `VoidCallback?` | `null` | Callback acción |

---

#### DSErrorState

Vista para estados de error.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `message` | `String` | required | Mensaje error |
| `details` | `String?` | `null` | Detalles |
| `onRetry` | `VoidCallback?` | `null` | Callback reintentar |
| `retryText` | `String` | `'Reintentar'` | Texto botón |

---

#### DSLoadingState

Vista para estados de carga.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `message` | `String?` | `null` | Mensaje |
| `size` | `DSLoaderSize` | `large` | Tamaño loader |

---

### Organismos

#### DSAppBar

AppBar personalizado del Design System.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `title` | `String` | required | Título |
| `actions` | `List<Widget>?` | `null` | Acciones derecha |
| `leading` | `Widget?` | `null` | Widget izquierdo |
| `centerTitle` | `bool` | `true` | Centrar título |

---

#### DSProductGrid

Grid de productos con manejo automático de estados.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `products` | `List<T>?` | `null` | Lista productos |
| `itemBuilder` | `Widget Function(BuildContext, T, int)` | required | Builder item |
| `isLoading` | `bool` | `false` | Estado carga |
| `error` | `String?` | `null` | Mensaje error |
| `onRetry` | `VoidCallback?` | `null` | Callback retry |
| `crossAxisCount` | `int` | `2` | Columnas |
| `childAspectRatio` | `double` | `0.65` | Ratio items |
| `emptyMessage` | `String` | `'Sin productos'` | Mensaje vacío |
| `loadingMessage` | `String` | `'Cargando...'` | Mensaje carga |

**Ejemplo:**

```dart
DSProductGrid<Product>(
  products: products,
  isLoading: isLoading,
  error: errorMessage,
  onRetry: () => loadProducts(),
  itemBuilder: (context, product, index) => DSProductCard(
    imageUrl: product.image,
    title: product.title,
    price: product.price,
    onTap: () => viewProduct(product),
  ),
)
```

---

#### DSBottomNav

Navegación inferior con soporte de badges.

**Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `currentIndex` | `int` | required | Índice activo |
| `onTap` | `ValueChanged<int>` | required | Callback cambio |
| `items` | `List<DSBottomNavItem>` | required | Items navegación |

**DSBottomNavItem Props:**

| Prop | Tipo | Default | Descripción |
|------|------|---------|-------------|
| `icon` | `IconData` | required | Ícono inactivo |
| `selectedIcon` | `IconData?` | `null` | Ícono activo |
| `label` | `String` | required | Etiqueta |
| `badgeCount` | `int?` | `null` | Contador badge |

**Ejemplo:**

```dart
DSBottomNav(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    DSBottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Inicio',
    ),
    DSBottomNavItem(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      label: 'Carrito',
      badgeCount: cartItemCount,
    ),
  ],
)
```

---

## Utilidades

### Context Extensions

```dart
// Acceso a tokens
final tokens = context.tokens;

// Verificar tema
if (context.isDarkMode) { /* ... */ }
if (context.isLightMode) { /* ... */ }

// Verificar breakpoints
if (context.isMobile) { /* < 600px */ }
if (context.isTablet) { /* >= 600px */ }
```

### Enums

```dart
// Variantes de botón
enum DSButtonVariant { primary, secondary, ghost, danger }

// Tamaños de botón
enum DSButtonSize { small, medium, large }

// Tipos de badge
enum DSBadgeType { success, error, warning, info, neutral }

// Tamaños de loader
enum DSLoaderSize { small, medium, large, xlarge }

// Variantes de texto
enum DSTextVariant {
  displayLarge, displayMedium,
  headingLarge, headingMedium, headingSmall,
  titleLarge, titleMedium,
  bodyLarge, bodyMedium, bodySmall,
  labelMedium, caption,
}
```
