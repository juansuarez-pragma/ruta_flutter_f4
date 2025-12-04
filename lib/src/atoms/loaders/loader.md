# Loaders (DSCircularLoader & DSSkeleton)

Indicadores de carga del sistema: spinner circular y skeleton animado.

## Propósito
- Comunicar estado de carga y evitar saltos visuales al renderizar contenido.
- Spinner para acciones breves indeterminadas; skeleton para placeholders de estructura.

## API: DSCircularLoader
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `size` | `DSLoaderSize` | `DSLoaderSize.medium` | Tamaño del spinner (sm/md/lg/xl). |
| `message` | `String?` | `null` | Texto opcional debajo. |
| `color` | `Color?` | `null` | Color del spinner; por defecto usa `colorBrandPrimary`. |

## API: DSSkeleton
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `width` | `double?` | `null` | Ancho del placeholder. |
| `height` | `double?` | `null` | Alto del placeholder. |
| `borderRadius` | `double` | `DSBorderRadius.sm` | Radio de borde. |
| `isCircular` | `bool` | `false` | Define forma circular. |

Constructores de conveniencia:
- `DSSkeleton.circular(size)` fija `width/height = size`, `borderRadius = full`, `isCircular = true`.
- `DSSkeleton.text({width, height})` default `height = 16`, `borderRadius = xs`.
- `DSSkeleton.title({width})` height `24`, `borderRadius = sm`.
- `DSSkeleton.image({width, height})` borderRadius `md`.

## Tokens usados
- Spinner: `DSSizes.loaderSm|Md|Lg|Xl`, stroke widths 2/3/3/4; color `colorBrandPrimary` (override con `color`).
- Mensaje: `typographyBodySmall`, `colorTextSecondary`, spacing `DSSpacing.md`.
- Skeleton: `DSDuration.long`, `DSCurves.standard`, color `colorBorderPrimary` con alfa animado, radios `DSBorderRadius.xs|sm|md|full`.

## Variantes y estados mínimos a documentar
- Spinner: tamaños `small`, `medium`, `large`, `extraLarge`; con/sin `message`; color personalizado.
- Skeleton: rectangular con distintos tamaños; circular (avatar); texto/título; imagen. Mostrar animación pulsante.

## Accesibilidad
- Spinner: usa `Semantics(label: 'Cargando…')` si no hay contexto; el widget actual es decorativo, así que envuélvelo en `Semantics` cuando sea necesario.
- Skeleton: decorativo; no debe anunciarse como contenido real. Evita poner textos reales dentro del placeholder.
- Contraste: asegurar que spinner y mensaje sean visibles en light/dark; skeleton debe tener contraste suficiente para ser perceptible pero sin competir con contenido.

## Cuándo usar
- Spinner: acciones cortas e indeterminadas (peticiones rápidas, envíos).
- Skeleton: listas, tarjetas o detalles donde la estructura del layout sea conocida y quieras evitar saltos.

## Cuándo no usar
- Cargas prolongadas sin feedback adicional (combínalo con texto o estado incremental).
- Skeleton para datos impredecibles que cambian mucho de longitud.
- Spinner como indicador de progreso conocido (usa barra/progreso determinado).

## Anti‑patrones
- Dejar spinner indefinido sin timeout o fallback.
- Mezclar skeleton y contenido real sin separación (añade padding/márgenes).
- Skeleton con textos demasiado largos que sugieran contenido real o clickable.

## Rendimiento y límites
- Spinner es ligero. Skeleton usa animación continua; evita un número excesivo simultáneo en pantallas con listas muy largas.
- Recicla widgets en listas para no recrear muchos controllers; en casos masivos, considera desactivar animación.

## Snippets rápidos
### Spinner básico
```dart
const DSCircularLoader();
```

### Spinner con mensaje y tamaño
```dart
const DSCircularLoader(
  size: DSLoaderSize.large,
  message: 'Cargando productos...',
);
```

### Spinner con color personalizado
```dart
DSCircularLoader(
  size: DSLoaderSize.small,
  color: Colors.white,
);
```

### Skeleton básicos
```dart
const DSSkeleton(width: 120, height: 16);
const DSSkeleton.circular(size: 48); // avatar
const DSSkeleton.text(width: 160);   // línea de texto
const DSSkeleton.title(width: 200);  // título
const DSSkeleton.image(width: double.infinity, height: 180);
```

## Tabla rápida de tamaños (spinner)
| Tamaño | Dimensión | Stroke |
| --- | --- | --- |
| `small` | `DSSizes.loaderSm` | 2 |
| `medium` | `DSSizes.loaderMd` | 3 |
| `large` | `DSSizes.loaderLg` | 3 |
| `extraLarge` | `DSSizes.loaderXl` | 4 |
