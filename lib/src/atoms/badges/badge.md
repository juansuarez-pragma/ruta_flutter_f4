# DSBadge

Badge del sistema de diseño para resaltar estados, etiquetas o contadores pequeños.

## Propósito
- Mostrar estados breves o metadatos cercanos al contenido (p. ej., “Nuevo”, “Agotado”, “Beta”).
- No sustituye a mensajes de error/éxito largos ni a banners; úsalo como acento visual.

## API
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `text` | `String` | — | Texto visible del badge (requerido). |
| `type` | `DSBadgeType` | `DSBadgeType.neutral` | Controla la paleta semántica (success, error, warning, info, neutral). |
| `size` | `DSBadgeSize` | `DSBadgeSize.medium` | Tamaño del badge (padding, tipografía e ícono). |
| `icon` | `IconData?` | `null` | Ícono opcional al inicio. |

Constructores de conveniencia: `DSBadge.success`, `.error`, `.warning`, `.info`, `.neutral` asignan el `type` correspondiente.

## Tokens usados
- Colores: `colorFeedbackSuccess( /Light)`, `colorFeedbackError( /Light)`, `colorFeedbackWarning( /Light)`, `colorFeedbackInfo( /Light)`, `badgeBackground`, `badgeText`.
- Tipografía: `DSFontSize.labelSmall|Medium|Large`, `DSFontWeight.medium`.
- Espaciado: `DSSpacing.xxs|xs|sm|md|base`.
- Iconos: `DSSizes.iconXs|iconSm|iconMd`.
- Forma: `DSBorderRadius.full`.

## Variantes y estados mínimos a documentar
- Tipos: `success`, `error`, `warning`, `info`, `neutral`.
- Tamaños: `small`, `medium`, `large`.
- Con/sin ícono (ícono alineado al inicio, spacing `DSSpacing.xs`).

## Accesibilidad
- Semántica: si se usa en contextos interactivos, envolver con un widget que provea `Semantics(label: ...)`; el badge por sí mismo es decorativo/no interactivo.
- Contraste: cada `type` usa pares semánticos (texto sobre fondo claro). Verificar contraste en light/dark antes de lanzamiento.
- Tamaño táctil: no está pensado como control táctil; si se vuelve interactivo, envuélvelo en un botón con mínimo 48x48 px.
- Focus: no gestiona focus; dejarlo decorativo o colocar el focus en el contenedor/píldora interactiva.

## Cuándo usar
- Etiquetar estado de un item (stock, publicación, rol).
- Mostrar contadores pequeños o “chips” de información densa.
- Destacar nuevas características en listas o tarjetas.

## Cuándo no usar
- Mensajes largos, errores de formulario o notificaciones (usa banners/snackbars).
- Como CTA primario; no ofrece affordance de clic.
- Para texto multirenglón; el badge es de una sola línea.

## Anti‑patrones
- Sobrecargar con texto extenso (>2–3 palabras).
- Usar colores fuera de los tipos semánticos definidos.
- Anidar múltiples badges consecutivos sin espacio (usa `Wrap` con `spacing`).

## Rendimiento y límites
- Componente liviano (solo `Container` + `Row`); apto para listas grandes.
- Texto sin wrap y `height: 1`; evita valores de texto dinámicos muy largos que rompan el layout.

## Snippets rápidos
### Básico (neutral)
```dart
const DSBadge(text: 'Borrador');
```

### Por tipo
```dart
const DSBadge.success(text: 'Activo');
const DSBadge.error(text: 'Agotado');
const DSBadge.warning(text: 'Atención');
const DSBadge.info(text: 'Nuevo');
```

### Por tamaño
```dart
const DSBadge.success(text: 'S', size: DSBadgeSize.small);
const DSBadge.success(text: 'M', size: DSBadgeSize.medium);
const DSBadge.success(text: 'L', size: DSBadgeSize.large);
```

### Con ícono
```dart
const DSBadge.success(
  text: 'Verificado',
  icon: Icons.check_circle,
);
```

## Tabla rápida de tipos/tamaños
| Tipo | Fondo | Texto |
| --- | --- | --- |
| `success` | `colorFeedbackSuccessLight` | `colorFeedbackSuccess` |
| `error` | `colorFeedbackErrorLight` | `colorFeedbackError` |
| `warning` | `colorFeedbackWarningLight` | `colorFeedbackWarning` |
| `info` | `colorFeedbackInfoLight` | `colorFeedbackInfo` |
| `neutral` | `badgeBackground` | `badgeText` |

| Tamaño | Padding | Tipografía | Ícono |
| --- | --- | --- | --- |
| `small` | H `DSSpacing.sm`, V `DSSpacing.xxs` | `DSFontSize.labelSmall` | `DSSizes.iconXs` |
| `medium` | H `DSSpacing.md`, V `DSSpacing.xs` | `DSFontSize.labelMedium` | `DSSizes.iconSm` |
| `large` | H `DSSpacing.base`, V `DSSpacing.sm` | `DSFontSize.labelLarge` | `DSSizes.iconMd` |
