# DSButton

Botón principal del sistema de diseño con variantes, tamaños, estados e íconos.

## Propósito
- Disparar acciones primarias/secundarias en pantallas y flujos.
- Alinear affordance con severidad (danger) y prioridad visual (primary, secondary, ghost).

## API
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `text` | `String` | — | Texto del botón (requerido). |
| `onPressed` | `VoidCallback?` | `null` | Acción al presionar; `null` lo deshabilita. |
| `icon` | `IconData?` | `null` | Ícono opcional. |
| `iconPosition` | `DSButtonIconPosition` | `start` | Posición del ícono (inicio/fin). |
| `variant` | `DSButtonVariant` | `primary` | Variante visual: primary, secondary, ghost, danger. |
| `size` | `DSButtonSize` | `medium` | Tamaño (alto, padding, tipografía, ícono). |
| `isLoading` | `bool` | `false` | Muestra spinner y deshabilita interacción. |
| `isFullWidth` | `bool` | `false` | Ocupa todo el ancho disponible. |

Constructores de conveniencia: `DSButton.primary`, `.secondary`, `.ghost`, `.danger` fijan `variant`.

## Tokens usados
- Alturas y espaciados: `DSSizes.buttonSm|Md|Lg`, `DSSpacing.xs|sm|base|md|xl`.
- Tipografía: `DSFontSize.labelSmall|Medium|Large`, `DSFontWeight.medium`.
- Íconos: `DSSizes.iconSm|iconMd|iconBase`.
- Bordes: `DSBorderRadius.md`, `DSSizes.borderThin`.
- Colores primario: `buttonPrimaryBackground( /Hover/Pressed/Disabled)`, `buttonPrimaryText( /Disabled)`.
- Colores secundario: `buttonSecondaryBackground( /Hover/Pressed)`, `buttonSecondaryText( /Disabled)`, `buttonSecondaryBorder`.
- Colores ghost: `buttonGhostBackground( /Hover/Pressed)`, `buttonGhostText( /Disabled)`.
- Colores danger: `buttonDangerBackground( /Hover/Pressed)`, `buttonDangerText`.

## Variantes y estados mínimos a documentar
- Variantes: `primary`, `secondary`, `ghost`, `danger`.
- Tamaños: `small`, `medium`, `large`.
- Iconos: con/sin ícono; `iconPosition` inicio/fin.
- Estados: default, hover, pressed, disabled (`onPressed == null` o `isLoading`), loading (muestra spinner), full width.

## Accesibilidad
- Semántica: hereda de `ElevatedButton/OutlinedButton/TextButton`; incluye rol de botón y label de `text`. Añade `Semantics` si el texto no es suficiente.
- Tamaño táctil: alturas por defecto cumplen ~32/40/48 px; garantizar ancho mínimo 48px si usas `isFullWidth: false`.
- Focus/hover: estados cubiertos por tokens; mantener contraste en light/dark.
- Loading: `isLoading` bloquea el tap; evita dejar `onPressed` activo mientras carga para no duplicar acciones.

## Cuándo usar
- Acciones principales (primary) y secundarias (secondary) en pantallas.
- Acciones de bajo énfasis o inline (ghost).
- Acciones destructivas (danger) como eliminar o descartar irreversible.

## Cuándo no usar
- Navegación persistente (usa barras o ítems de navegación).
- Acciones que requieren confirmación visual compleja (usa diálogos).
- Mostrar estados de progreso largos (usa loaders separados).

## Anti‑patrones
- Texto demasiado largo (>2 líneas); el botón está pensado para una línea.
- Mezclar iconografía arbitraria con danger/secondary que cambie su significado.
- Usar ghost como CTA principal cuando hay poca jerarquía visual.

## Rendimiento y límites
- Basado en botones nativos de Flutter; ligero y apto para listas.
- `isLoading` reemplaza contenido por spinner de ancho fijo; evita layout shifts.

## Snippets rápidos
### Básico (primary)
```dart
DSButton.primary(
  text: 'Continuar',
  onPressed: onContinue,
);
```

### Secundario y ghost
```dart
DSButton.secondary(text: 'Omitir', onPressed: onSkip);
DSButton.ghost(text: 'Saber más', onPressed: onLearnMore);
```

### Danger
```dart
DSButton.danger(
  text: 'Eliminar',
  onPressed: onDelete,
);
```

### Con ícono e ícono al final
```dart
DSButton.primary(
  text: 'Agregar',
  icon: Icons.add,
  onPressed: onAdd,
);

DSButton.secondary(
  text: 'Siguiente',
  icon: Icons.arrow_forward,
  iconPosition: DSButtonIconPosition.end,
  onPressed: onNext,
);
```

### Loading y full width
```dart
DSButton.primary(
  text: 'Guardando...',
  isLoading: true,
);

DSButton.primary(
  text: 'Comprar',
  isFullWidth: true,
  onPressed: onBuy,
);
```

### Por tamaño
```dart
DSButton.primary(text: 'Small', size: DSButtonSize.small, onPressed: onTap);
DSButton.primary(text: 'Medium', size: DSButtonSize.medium, onPressed: onTap);
DSButton.primary(text: 'Large', size: DSButtonSize.large, onPressed: onTap);
```

## Tabla rápida de variantes
| Variante | Fondo | Texto | Borde |
| --- | --- | --- | --- |
| `primary` | `buttonPrimaryBackground` (hover/pressed/disabled) | `buttonPrimaryText` (disabled) | — |
| `secondary` | `buttonSecondaryBackground` (hover/pressed) | `buttonSecondaryText` (disabled) | `buttonSecondaryBorder` (`borderThin`) |
| `ghost` | `buttonGhostBackground` (hover/pressed) | `buttonGhostText` (disabled) | — |
| `danger` | `buttonDangerBackground` (hover/pressed) | `buttonDangerText` | — |

## Tabla rápida de tamaños
| Tamaño | Altura | Padding | Tipografía | Ícono |
| --- | --- | --- | --- | --- |
| `small` | `DSSizes.buttonSm` | H `DSSpacing.md`, V `DSSpacing.xs` | `DSFontSize.labelSmall` | `DSSizes.iconSm` |
| `medium` | `DSSizes.buttonMd` | H `DSSpacing.base`, V `DSSpacing.sm` | `DSFontSize.labelMedium` | `DSSizes.iconMd` |
| `large` | `DSSizes.buttonLg` | H `DSSpacing.xl`, V `DSSpacing.md` | `DSFontSize.labelLarge` | `DSSizes.iconBase` |

---

# DSIconButton

Botón circular de ícono alineado con las variantes de botón.

## API
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `IconData` | — | Ícono a mostrar (requerido). |
| `onPressed` | `VoidCallback?` | `null` | Acción al presionar; `null` lo deshabilita. |
| `variant` | `DSButtonVariant` | `ghost` | primary, secondary, ghost, danger. |
| `size` | `DSButtonSize` | `medium` | Controla diámetro y tamaño de ícono. |
| `tooltip` | `String?` | `null` | Texto de ayuda (wrap con `Tooltip`). |
| `isLoading` | `bool` | `false` | Muestra spinner y deshabilita interacción. |

## Tokens usados
- Dimensiones: `DSSizes.buttonSm|Md|Lg`, `DSSizes.iconSm|iconMd|iconBase`.
- Forma: `CircleBorder()`.
- Colores: reutiliza tokens de button para fondo/texto/hover/pressed por variante; disabled usa los mismos de botón primario/secondary/ghost.

## Variantes y estados mínimos a documentar
- Variantes: `primary`, `secondary`, `ghost` (default), `danger`.
- Tamaños: `small`, `medium`, `large`.
- Estados: default, hover, pressed, disabled (`onPressed == null` o `isLoading`), loading (spinner centrado).
- Accesorio: `tooltip` para accesibilidad/ayuda.

## Snippets rápidos
```dart
// Ghost (default)
const DSIconButton(icon: Icons.more_vert, onPressed: onMenu);

// Primary
const DSIconButton(
  icon: Icons.add,
  variant: DSButtonVariant.primary,
  onPressed: onAdd,
);

// Danger con tooltip
const DSIconButton(
  icon: Icons.delete,
  variant: DSButtonVariant.danger,
  tooltip: 'Eliminar',
  onPressed: onDelete,
);

// Loading + size
const DSIconButton(
  icon: Icons.sync,
  size: DSButtonSize.small,
  isLoading: true,
);
```
