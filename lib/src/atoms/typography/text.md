# DSText

Componente tipográfico del sistema para aplicar variantes predefinidas con API simple.

## Propósito
- Garantizar consistencia tipográfica usando variantes del DS sin repetir estilos manuales.
- Facilitar opciones comunes: color, alineación, recorte y texto seleccionable.

## API
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `text` | `String` | — | Contenido a mostrar. |
| `variant` | `DSTextVariant` | `bodyMedium` | Variante tipográfica (display, heading, title, body, label, caption, overline). |
| `color` | `Color?` | `null` | Color opcional; si es `null`, usa el color del token. |
| `textAlign` | `TextAlign?` | `null` | Alineación del texto. |
| `maxLines` | `int?` | `null` | Máx. líneas; `null` permite todas. |
| `overflow` | `TextOverflow?` | `null` | Comportamiento al exceder maxLines. |
| `selectable` | `bool` | `false` | Si `true`, usa `SelectableText`. |

Constructores de conveniencia: `.displayLarge`, `.headingLarge/Medium/Small`, `.titleLarge/Medium`, `.bodyLarge/Medium/Small`, `.label`, `.caption`. (Variantes restantes accesibles via `variant`).

## Variantes (resumen)
- Display: `displayLarge/Medium/Small`
- Heading: `headingLarge/Medium/Small`
- Title: `titleLarge/Medium/Small`
- Body: `bodyLarge/Medium/Small` (bodyMedium es base)
- Label: `labelLarge/Medium/Small`
- Otros: `caption`, `overline`

## Tokens usados
- Tipografía: `typographyDisplay*`, `typographyHeading*`, `typographyTitle*`, `typographyBody*`, `typographyLabel*`, `typographyCaption`, `typographyOverline`.
- Color: por defecto el definido en cada token; puede sobrescribirse con `color`.

## Variantes y estados mínimos a documentar
- Textos de encabezado/título/cuerpo/label mostrando jerarquía visual.
- Uso de `selectable: true` para contenido copiable.
- Manejo de overflow: con `maxLines` + `overflow: TextOverflow.ellipsis`.
- Cambios de color para estados (p. ej., éxito/error) mediante `color`.

## Accesibilidad
- Texto debe ser real y no contener información crítica en imágenes.
- Mantener jerarquía semántica combinando con widgets de estructura (ej. `Semantics`, o usar `Text` dentro de `AppBar` etc.).
- Respetar escalado de fuente; variantes están basadas en `TextTheme` y responden a textScaleFactor.
- Evitar truncar información esencial con `maxLines`; si se usa `ellipsis`, proveer tooltip o acceso completo.

## Cuándo usar
- Cualquier texto que deba alinearse a la tipografía del design system sin repetir estilos manuales.
- Jerarquías claras de títulos y subtítulos en pantallas y cards.

## Cuándo no usar
- Texto altamente personalizado que requiera estilos fuera del DS (usa estilos locales puntuales).
- Etiquetas de estado pequeñas que ya tienen componentes específicos (p. ej., `DSBadge`).

## Anti‑patrones
- Mezclar variantes sin jerarquía (ej. usar `display` en tarjetas pequeñas).
- Usar `label` para párrafos largos.
- Sobrescribir demasiados atributos del `TextStyle`; si necesitas cambios amplios, define una variante nueva en tokens.

## Rendimiento y límites
- Ligero; evita crear muchos `SelectableText` en listas muy grandes si no es necesario.
- `SelectableText` no soporta `overflow`; úsalo solo cuando el contenido pueda ocupar espacio suficiente.

## Snippets rápidos
### Jerarquía básica
```dart
const DSText.headingLarge('Título principal');
const DSText.titleMedium('Subtítulo');
const DSText.bodyMedium('Contenido del párrafo base.');
```

### Con color y alineación
```dart
DSText(
  'Precio',
  variant: DSTextVariant.titleSmall,
  color: context.tokens.colorBrandPrimary,
  textAlign: TextAlign.right,
);
```

### Texto seleccionable
```dart
const DSText.bodySmall(
  'ID: 1234-5678',
  selectable: true,
);
```

### Texto truncado
```dart
DSText(
  productDescription,
  variant: DSTextVariant.bodySmall,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
);
```
