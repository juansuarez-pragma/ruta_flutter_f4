# DSTextField

Campo de texto del sistema de diseño con soporte para validación, íconos y estados.

## Propósito
- Capturar entrada de usuario con estilo consistente y accesible.
- Cubrir casos comunes: texto corto, email, password, búsqueda, comentarios cortos.

## API
| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `label` | `String?` | `null` | Etiqueta superior del campo. |
| `hint` | `String?` | `null` | Texto de sugerencia dentro del campo. |
| `errorText` | `String?` | `null` | Mensaje de error; muestra estado de error si no es vacío. |
| `helperText` | `String?` | `null` | Texto de ayuda debajo del campo. |
| `controller` | `TextEditingController?` | `null` | Controlador del texto. |
| `onChanged` | `ValueChanged<String>?` | `null` | Callback al cambiar el texto. |
| `onSubmitted` | `ValueChanged<String>?` | `null` | Callback al enviar (tecla acción). |
| `obscureText` | `bool` | `false` | Oculta texto (password). |
| `keyboardType` | `TextInputType?` | `null` | Tipo de teclado. |
| `prefixIcon` | `IconData?` | `null` | Ícono al inicio. |
| `suffixIcon` | `IconData?` | `null` | Ícono al final. |
| `onSuffixIconTap` | `VoidCallback?` | `null` | Acción al tocar el ícono final. |
| `enabled` | `bool` | `true` | Habilita/deshabilita input. |
| `readOnly` | `bool` | `false` | Sólo lectura (mantiene estilo habilitado). |
| `maxLines` | `int?` | `1` | Líneas máximas. |
| `minLines` | `int?` | `null` | Líneas mínimas. |
| `maxLength` | `int?` | `null` | Longitud máxima. |
| `autofocus` | `bool` | `false` | Autoenfoque al renderizar. |
| `textInputAction` | `TextInputAction?` | `null` | Acción del teclado (next, done, search...). |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Formateadores de entrada. |
| `focusNode` | `FocusNode?` | `null` | Nodo de foco externo. |

## Tokens usados
- Tipografía: `typographyLabelMedium`, `typographyBodyMedium`, `typographyCaption`.
- Colores de texto y fondos: `inputText`, `inputPlaceholder`, `inputBackground`, `colorSurfaceSecondary`, `colorTextDisabled`.
- Borde y estados: `inputBorder`, `inputBorderFocused`, `inputBorderError`, `colorBorderSecondary`.
- Feedback: `colorFeedbackError`.
- Iconos: `colorIconSecondary`, `DSSizes.iconMd`.
- Espaciado y forma: `DSSpacing.base|md`, `DSBorderRadius.md`.

## Variantes y estados mínimos a documentar
- Estados: default, focus, error (`errorText`), disabled (`enabled: false`), read-only (`readOnly: true`), loading externo (si aplica a tu flujo), password (`obscureText: true`).
- Íconos: con `prefixIcon`, con `suffixIcon` y acción (`onSuffixIconTap`).
- Líneas: single-line (`maxLines: 1`), multi-line (`maxLines > 1` o `minLines`).

## Accesibilidad
- Etiquetas y ayudas: usa `label` + `hint` + `helperText` para contexto; `errorText` anuncia estado en lectores de pantalla.
- Foco y navegación: compatibilidad con teclado; usa `textInputAction` y `onSubmitted` para flujos de formularios.
- Contraste: verificar bordes y texto en light/dark; estado de error debe mantener contraste suficiente.
- Tocabilidad: padding vertical `DSSpacing.md` y alto visual adecuado; si agregas gestos a sufijo, mantén 48px mínimos alrededor.

## Cuándo usar
- Entradas de texto genéricas, email, búsqueda, password, comentarios cortos.
- Formularios simples donde se requiera feedback de error inline.

## Cuándo no usar
- Inputs con máscara compleja o picker (usa componentes dedicados).
- Captura de grandes bloques de texto enriquecido (usa un editor especializado).
- Acciones primarias de disparo (usa botones).

## Anti‑patrones
- Mostrar `errorText` vacío o nulo al mismo tiempo; deja `null` si no hay error.
- Sobrecargar sufijo con múltiples acciones; mantén un solo ícono o usa un menú.
- Usar `readOnly` como disabled visual; si no debe interactuar, usa `enabled: false`.

## Rendimiento y límites
- Usa controladores externos para preservar estado en listas; evita recrear `TextField` con nuevos controllers en cada build.
- `maxLines` con valores altos puede afectar layout en listas; considerar límites razonables.

## Snippets rápidos
### Básico
```dart
DSTextField(
  label: 'Email',
  hint: 'ejemplo@correo.com',
  keyboardType: TextInputType.emailAddress,
  onChanged: onEmailChanged,
);
```

### Con validación y helper
```dart
DSTextField(
  label: 'Contraseña',
  hint: 'Mínimo 8 caracteres',
  obscureText: true,
  errorText: passwordError,
  helperText: 'Incluye mayúscula y número',
  onChanged: onPasswordChanged,
);
```

### Con íconos
```dart
DSTextField(
  label: 'Buscar',
  hint: 'Productos, categorías...',
  prefixIcon: Icons.search,
  onChanged: onQueryChanged,
);

DSTextField(
  label: 'Contraseña',
  obscureText: isHidden,
  suffixIcon: isHidden ? Icons.visibility : Icons.visibility_off,
  onSuffixIconTap: toggleVisibility,
  onChanged: onPasswordChanged,
);
```

### Multilínea
```dart
DSTextField(
  label: 'Comentario',
  hint: 'Escribe tu feedback',
  minLines: 3,
  maxLines: 5,
  onChanged: onCommentChanged,
);
```

### Deshabilitado y solo lectura
```dart
const DSTextField(
  label: 'Estado',
  hint: 'Sin datos',
  enabled: false,
);

DSTextField(
  label: 'Token',
  controller: tokenController,
  readOnly: true,
);
```

## Tabla rápida de estados
| Estado | Estilo clave |
| --- | --- |
| Default | Borde `inputBorder`, fondo `inputBackground`, texto `inputText`. |
| Focus | Borde `inputBorderFocused` con grosor 2. |
| Error | Borde `inputBorderError`, label/íconos en `colorFeedbackError`, `errorText` visible. |
| Disabled | Fondo `colorSurfaceSecondary`, texto `colorTextDisabled`, borde `colorBorderSecondary`. |
