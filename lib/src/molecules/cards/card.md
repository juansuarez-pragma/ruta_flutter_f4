# DSCard

Card base del sistema de diseño para agrupar contenido con estilos consistentes.

## Propósito

- Contener y agrupar información relacionada visualmente.
- Proporcionar jerarquía visual mediante niveles de elevación.
- Servir como base para cards especializadas (DSProductCard).

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `child` | `Widget` | — | Contenido de la card (requerido). |
| `padding` | `EdgeInsetsGeometry?` | `DSSpacing.base` | Padding interno. |
| `onTap` | `VoidCallback?` | `null` | Callback al tocar; habilita estados hover/press. |
| `elevation` | `int` | `1` | Nivel de sombra (0-5). |
| `backgroundColor` | `Color?` | `cardBackground` | Color de fondo personalizado. |
| `borderRadius` | `double` | `DSBorderRadius.base` | Radio de las esquinas. |
| `showBorder` | `bool` | `true` | Si muestra borde visible. |
| `width` | `double?` | `null` | Ancho fijo opcional. |
| `height` | `double?` | `null` | Alto fijo opcional. |

## Tokens usados

- **Fondo**: `cardBackground`, `cardBackgroundHover` (estado hover).
- **Borde**: `cardBorder`, `DSSizes.borderThin`.
- **Espaciado**: `DSSpacing.base` (padding default).
- **Radio**: `DSBorderRadius.base`.
- **Elevación**: `elevationLevel1` a `elevationLevel5`, `DSElevation.none`.

## Variantes y estados

### Niveles de elevación

| Nivel | Token | Uso recomendado |
| --- | --- | --- |
| 0 | `DSElevation.none` | Cards planas, sin sombra. |
| 1 | `elevationLevel1` | Cards estándar (default). |
| 2 | `elevationLevel2` | Cards destacadas. |
| 3 | `elevationLevel3` | Modales ligeros. |
| 4 | `elevationLevel4` | Dropdowns, popovers. |
| 5 | `elevationLevel5` | Modales prominentes. |

### Estados interactivos

- **default**: Fondo `cardBackground`.
- **hover**: Fondo `cardBackgroundHover` con opacidad 0.5.
- **pressed**: Fondo `cardBackgroundHover`.
- **splash**: Efecto ripple con `cardBackgroundHover`.

## Accesibilidad

- **Semántica**: No incluye semántica por defecto; agregar `Semantics` si el contenido lo requiere.
- **Interacción**: Cuando tiene `onTap`, usa `InkWell` que provee feedback táctil y visual.
- **Focus**: Hereda comportamiento de focus de `InkWell` para navegación por teclado.

## Cuándo usar

- Agrupar contenido relacionado (perfil, producto, configuración).
- Crear listas de items con información compuesta.
- Contenedores para formularios o secciones.

## Cuándo NO usar

- Para botones de acción (usa DSButton).
- Contenido que no necesita agrupación visual (usa Container simple).
- Navegación principal (usa DSBottomNav o DSAppBar).

## Anti-patrones

- Anidar cards dentro de cards (rompe jerarquía visual).
- Usar elevación 5 para contenido regular (reservar para modales).
- Omitir `onTap` en cards que deberían ser clickeables.

## Rendimiento y límites

- Basado en `Container` + `InkWell`; ligero y apto para listas largas.
- La elevación usa `BoxShadow`; niveles altos pueden impactar performance en listas muy grandes.

## Snippets rápidos

### Card básica

```dart
DSCard(
  child: Column(
    children: [
      Text('Título'),
      Text('Descripción'),
    ],
  ),
)
```

### Card interactiva

```dart
DSCard(
  onTap: () => navigateToDetail(),
  child: ListTile(
    leading: Icon(Icons.person),
    title: Text('Usuario'),
    subtitle: Text('Ver perfil'),
  ),
)
```

### Card con elevación alta

```dart
DSCard(
  elevation: 3,
  child: Padding(
    padding: EdgeInsets.all(DSSpacing.lg),
    child: Text('Contenido destacado'),
  ),
)
```

### Card sin borde

```dart
DSCard(
  showBorder: false,
  elevation: 2,
  child: Text('Card limpia'),
)
```

### Card con dimensiones fijas

```dart
DSCard(
  width: 200,
  height: 150,
  child: Center(child: Text('Tamaño fijo')),
)
```

---

# DSProductCard

Card especializada para mostrar productos de e-commerce con imagen, información y acciones.

## Propósito

- Presentar productos de forma consistente en catálogos y grids.
- Mostrar información clave: imagen, título, precio, rating.
- Proporcionar acciones rápidas (ver detalle, agregar al carrito).

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `imageUrl` | `String` | — | URL de la imagen (requerido). |
| `title` | `String` | — | Título del producto (requerido). |
| `price` | `double` | — | Precio del producto (requerido). |
| `rating` | `double?` | `null` | Rating (0-5). |
| `reviewCount` | `int?` | `null` | Número de reviews. |
| `badge` | `String?` | `null` | Texto del badge ("Nuevo", "Oferta"). |
| `badgeType` | `DSBadgeType?` | `neutral` | Tipo semántico del badge. |
| `onTap` | `VoidCallback?` | `null` | Callback al tocar la card. |
| `onAddToCart` | `VoidCallback?` | `null` | Callback del botón de carrito. |
| `imageWidget` | `Widget?` | `null` | Widget personalizado para imagen. |
| `aspectRatio` | `double` | `0.7` | Proporción de la card. |
| `imageSemanticLabel` | `String?` | `null` | Label para screen readers. |

## Tokens usados

- **Contenedor**: Hereda de `DSCard` (elevation 1, padding 0).
- **Imagen**: `colorSurfaceSecondary` (placeholder), `colorIconDisabled` (error).
- **Título**: `typographyTitleSmall`.
- **Rating**: `colorFeedbackWarning` (estrella), `typographyLabelSmall`, `typographyCaption`.
- **Precio**: `typographyTitleMedium`, `colorBrandPrimary`, `DSFontWeight.bold`.
- **Badge**: Usa `DSBadge` con tamaño `small`.
- **Botón carrito**: Usa `DSIconButton` variante `primary`.
- **Espaciado**: `DSSpacing.sm`, `DSSpacing.xs`, `DSSpacing.xxs`, `DSSpacing.md`.
- **Radio imagen**: `DSBorderRadius.base`.

## Estructura visual

```
┌─────────────────────────┐
│  [Badge]                │ ← Posición top-left
│                         │
│      [Imagen]           │ ← flex: 3
│                         │
├─────────────────────────┤
│ Título del producto     │
│ ★ 4.5 (120)            │ ← Rating + reviews
│ $99.99        [🛒]     │ ← Precio + botón carrito
└─────────────────────────┘   ← flex: 2
```

## Accesibilidad

- **Imagen**: `Semantics(image: true, label: imageSemanticLabel ?? 'Product image: $title')`.
- **Botón carrito**: Tooltip "Agregar al carrito" para screen readers.
- **Rating**: Información visual; considerar agregar semántica si es crítica.

## Cuándo usar

- Catálogos y listados de productos.
- Grids de búsqueda y resultados.
- Secciones de productos destacados.

## Cuándo NO usar

- Detalles completos de producto (usa vista de detalle).
- Listas simples de texto (usa ListTile o DSCard).
- Productos sin imagen (considerar placeholder o card alternativa).

## Anti-patrones

- Títulos muy largos (máximo 2 líneas con ellipsis).
- Imágenes de baja resolución (afecta percepción de calidad).
- Omitir `imageSemanticLabel` en contextos de accesibilidad.

## Rendimiento y límites

- Usa `Image.network` con `loadingBuilder` y `errorBuilder` integrados.
- El spinner de carga usa `DSCircularLoader.small`.
- No incluye caché de imágenes; considerar `cached_network_image` en producción.

## Snippets rápidos

### Producto básico

```dart
DSProductCard(
  imageUrl: product.image,
  title: product.title,
  price: product.price,
  onTap: () => viewProduct(product),
)
```

### Producto completo

```dart
DSProductCard(
  imageUrl: product.image,
  title: product.title,
  price: product.price,
  rating: product.rating.rate,
  reviewCount: product.rating.count,
  badge: 'Nuevo',
  badgeType: DSBadgeType.success,
  onTap: () => viewProduct(product),
  onAddToCart: () => addToCart(product),
  imageSemanticLabel: 'Foto de ${product.title}',
)
```

### Producto con imagen personalizada

```dart
DSProductCard(
  imageUrl: '', // Se ignora si hay imageWidget
  imageWidget: CachedNetworkImage(
    imageUrl: product.image,
    fit: BoxFit.contain,
  ),
  title: product.title,
  price: product.price,
)
```

### Producto con badge de oferta

```dart
DSProductCard(
  imageUrl: product.image,
  title: product.title,
  price: product.salePrice,
  badge: '-20%',
  badgeType: DSBadgeType.error,
  onTap: () => viewProduct(product),
)
```

## Tabla de badges recomendados

| Contexto | Texto | Tipo |
| --- | --- | --- |
| Producto nuevo | "Nuevo" | `success` |
| Producto agotado | "Agotado" | `error` |
| Pocas unidades | "Últimas unidades" | `warning` |
| Promoción | "-20%", "Oferta" | `error` |
| Destacado | "Top ventas" | `info` |
| Default | Cualquier otro | `neutral` |
