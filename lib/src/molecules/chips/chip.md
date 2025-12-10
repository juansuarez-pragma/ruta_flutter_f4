# DSFilterChip

Chip de filtro del sistema de diseño para selección de categorías y opciones de filtrado.

## Propósito

- Permitir selección de filtros en listas y catálogos.
- Mostrar categorías seleccionables con feedback visual claro.
- Proporcionar una alternativa compacta a radio buttons y checkboxes.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `label` | `String` | — | Texto del chip (requerido). |
| `isSelected` | `bool` | `false` | Si el chip está seleccionado. |
| `onTap` | `VoidCallback?` | `null` | Callback al tocar; `null` lo deshabilita. |
| `icon` | `IconData?` | `null` | Ícono opcional al inicio. |
| `showCheckmark` | `bool` | `true` | Si muestra checkmark al seleccionar. |

## Tokens usados

- **Fondo no seleccionado**: `chipBackground`.
- **Fondo seleccionado**: `chipBackgroundSelected`.
- **Fondo hover**: `chipBackgroundHover`.
- **Fondo pressed**: `chipBackgroundPressed`.
- **Texto no seleccionado**: `chipText`.
- **Texto seleccionado**: `chipTextSelected`.
- **Borde no seleccionado**: `chipBorder`.
- **Borde seleccionado**: `colorBrandPrimary`.
- **Checkmark**: `colorBrandPrimary`.
- **Tipografía**: `typographyLabelMedium`.
- **Ícono**: `DSSizes.iconSm`.
- **Espaciado**: `DSSpacing.md` (horizontal), `DSSpacing.sm` (vertical).
- **Forma**: `DSBorderRadius.full` (pill shape).
- **Borde**: `DSSizes.borderThin`.

## Variantes y estados

### Estados visuales

| Estado | Fondo | Borde | Texto |
| --- | --- | --- | --- |
| default | `chipBackground` | `chipBorder` | `chipText` |
| hover | `chipBackgroundHover` | `chipBorder` | `chipText` |
| pressed | `chipBackgroundPressed` | `chipBorder` | `chipText` |
| selected | `chipBackgroundSelected` | `colorBrandPrimary` | `chipTextSelected` |
| selected + hover | `chipBackgroundHover` | `colorBrandPrimary` | `chipTextSelected` |
| selected + pressed | `chipBackgroundPressed` | `colorBrandPrimary` | `chipTextSelected` |

### Comportamiento del ícono

- **No seleccionado con ícono**: Muestra el ícono proporcionado.
- **Seleccionado con `showCheckmark: true`**: Reemplaza ícono por checkmark.
- **Seleccionado con `showCheckmark: false`**: Oculta el ícono.

## Accesibilidad

- **Semántica**: Basado en `FilterChip` de Flutter; hereda rol de chip seleccionable.
- **Estados**: El estado `selected` se comunica automáticamente a screen readers.
- **Contraste**: Los tokens garantizan contraste adecuado en ambos temas.
- **Focus**: Soporte nativo de navegación por teclado.

## Cuándo usar

- Filtros de categoría en listados de productos.
- Selección múltiple de opciones (tags, etiquetas).
- Filtros rápidos en barras de búsqueda.
- Toggle de opciones compactas.

## Cuándo NO usar

- Selección única exclusiva (usa Radio o SegmentedButton).
- Acciones que no son filtros (usa DSButton).
- Navegación entre secciones (usa Tabs o DSBottomNav).
- Mostrar información estática (usa DSBadge).

## Anti-patrones

- Texto demasiado largo (máximo 2-3 palabras).
- Demasiados chips en una fila sin `Wrap`.
- Usar sin indicador visual de selección.
- Mezclar chips seleccionables con no seleccionables.

## Rendimiento y límites

- Basado en `FilterChip` nativo; optimizado para listas.
- Usa `WidgetStateProperty.resolveWith` para estados reactivos.
- Apto para uso en `Wrap` con múltiples chips.

## Snippets rápidos

### Chip básico

```dart
DSFilterChip(
  label: 'Electronics',
  isSelected: selectedCategory == 'electronics',
  onTap: () => selectCategory('electronics'),
)
```

### Chip con ícono

```dart
DSFilterChip(
  label: 'Favoritos',
  icon: Icons.favorite,
  isSelected: showFavorites,
  onTap: () => toggleFavorites(),
)
```

### Chip sin checkmark

```dart
DSFilterChip(
  label: 'Ordenar',
  icon: Icons.sort,
  isSelected: isSorted,
  showCheckmark: false,
  onTap: () => toggleSort(),
)
```

### Lista de categorías

```dart
Wrap(
  spacing: DSSpacing.sm,
  runSpacing: DSSpacing.sm,
  children: categories.map((category) {
    return DSFilterChip(
      label: category.name,
      isSelected: selectedCategories.contains(category.id),
      onTap: () => toggleCategory(category.id),
    );
  }).toList(),
)
```

### Filtros con íconos

```dart
Row(
  children: [
    DSFilterChip(
      label: 'Precio',
      icon: Icons.attach_money,
      isSelected: filters.contains('price'),
      onTap: () => toggleFilter('price'),
    ),
    SizedBox(width: DSSpacing.sm),
    DSFilterChip(
      label: 'Rating',
      icon: Icons.star,
      isSelected: filters.contains('rating'),
      onTap: () => toggleFilter('rating'),
    ),
  ],
)
```

### Chip deshabilitado

```dart
DSFilterChip(
  label: 'No disponible',
  isSelected: false,
  onTap: null, // Deshabilitado
)
```

## Integración con DSProductGrid

```dart
Column(
  children: [
    // Filtros
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: DSSpacing.base),
      child: Row(
        children: categories.map((cat) {
          return Padding(
            padding: EdgeInsets.only(right: DSSpacing.sm),
            child: DSFilterChip(
              label: cat.name,
              isSelected: selectedCategory == cat.id,
              onTap: () => filterByCategory(cat.id),
            ),
          );
        }).toList(),
      ),
    ),
    // Grid de productos filtrados
    Expanded(
      child: DSProductGrid(
        products: filteredProducts,
        onProductTap: viewProduct,
      ),
    ),
  ],
)
```

## Tabla de casos de uso

| Contexto | Con ícono | Checkmark | Ejemplo |
| --- | --- | --- | --- |
| Categorías | No | Sí | "Electronics", "Clothing" |
| Favoritos | Sí (heart) | No | "Mis favoritos" |
| Ordenamiento | Sí (sort) | No | "Precio", "Nombre" |
| Tags | No | Sí | "Nuevo", "Oferta" |
| Filtros rápidos | Sí | Sí | "En stock", "Envío gratis" |
