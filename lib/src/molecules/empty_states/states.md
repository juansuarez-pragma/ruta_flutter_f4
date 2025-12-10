# Estados del Sistema de Diseño

Componentes para manejar estados de interfaz: vacío, error y carga.

---

# DSEmptyState

Vista para estados vacíos cuando no hay contenido para mostrar.

## Propósito

- Comunicar al usuario que no hay datos disponibles.
- Proporcionar contexto sobre por qué está vacío.
- Ofrecer acción para resolver el estado (cuando aplica).

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `icon` | `IconData` | — | Ícono ilustrativo (requerido). |
| `title` | `String` | — | Título descriptivo (requerido). |
| `description` | `String?` | `null` | Descripción adicional. |
| `actionText` | `String?` | `null` | Texto del botón de acción. |
| `onAction` | `VoidCallback?` | `null` | Callback del botón de acción. |
| `iconSize` | `double` | `DSSizes.iconMega` | Tamaño del ícono. |

## Tokens usados

- **Ícono**: `colorIconDisabled`, `DSSizes.iconMega`.
- **Título**: `DSText.headingSmall`, `colorTextSecondary`.
- **Descripción**: `DSText.bodyMedium`, `colorTextTertiary`.
- **Botón**: `DSButton.primary`.
- **Espaciado**: `DSSpacing.xxl` (padding), `DSSpacing.lg`, `DSSpacing.sm`, `DSSpacing.xl`.

## Estructura visual

```
┌─────────────────────────────────┐
│                                 │
│           [Ícono]               │ ← DSSizes.iconMega
│                                 │
│     Título del estado           │ ← headingSmall
│                                 │
│   Descripción opcional del      │ ← bodyMedium
│   estado vacío                  │
│                                 │
│      [Botón de acción]          │ ← DSButton.primary
│                                 │
└─────────────────────────────────┘
```

## Cuándo usar

- Carrito de compras vacío.
- Resultados de búsqueda sin coincidencias.
- Listas de favoritos vacías.
- Historial sin registros.

## Cuándo NO usar

- Errores de sistema (usa DSErrorState).
- Estados de carga (usa DSLoadingState).
- Confirmaciones o éxitos (usa snackbars o diálogos).

## Anti-patrones

- Mensajes genéricos sin contexto ("No hay datos").
- Omitir acción cuando el usuario puede resolver el estado.
- Íconos que no representan el contexto.

## Snippets rápidos

### Estado vacío básico

```dart
DSEmptyState(
  icon: Icons.shopping_cart_outlined,
  title: 'Carrito vacío',
  description: 'Agrega productos para continuar',
)
```

### Con acción

```dart
DSEmptyState(
  icon: Icons.search_off,
  title: 'Sin resultados',
  description: 'No encontramos productos con ese criterio',
  actionText: 'Limpiar filtros',
  onAction: () => clearFilters(),
)
```

### Favoritos vacíos

```dart
DSEmptyState(
  icon: Icons.favorite_border,
  title: 'Sin favoritos',
  description: 'Marca productos como favoritos para verlos aquí',
  actionText: 'Explorar productos',
  onAction: () => navigateToProducts(),
)
```

---

# DSErrorState

Vista para estados de error que impiden mostrar contenido.

## Propósito

- Comunicar que ocurrió un error de forma clara.
- Proporcionar detalles técnicos cuando sea útil.
- Ofrecer opción de reintento.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `message` | `String` | — | Mensaje principal de error (requerido). |
| `details` | `String?` | `null` | Detalles adicionales del error. |
| `onRetry` | `VoidCallback?` | `null` | Callback para reintentar. |
| `retryText` | `String` | `'Reintentar'` | Texto del botón de retry. |
| `icon` | `IconData` | `Icons.error_outline` | Ícono de error. |

## Tokens usados

- **Ícono**: `colorFeedbackError`, `DSSizes.iconMega`.
- **Mensaje**: `DSText.headingSmall`, `colorTextPrimary`.
- **Detalles**: `DSText.bodyMedium`, `colorTextSecondary`.
- **Botón**: `DSButton.secondary` con ícono `Icons.refresh`.
- **Espaciado**: `DSSpacing.xxl` (padding), `DSSpacing.lg`, `DSSpacing.sm`, `DSSpacing.xl`.

## Estructura visual

```
┌─────────────────────────────────┐
│                                 │
│           [Ícono]               │ ← colorFeedbackError
│                                 │
│   Mensaje de error principal    │ ← headingSmall
│                                 │
│   Detalles técnicos opcionales  │ ← bodyMedium
│                                 │
│       [🔄 Reintentar]           │ ← DSButton.secondary
│                                 │
└─────────────────────────────────┘
```

## Cuándo usar

- Fallo de conexión a internet.
- Error al cargar datos del servidor.
- Timeout de operaciones.
- Errores de API.

## Cuándo NO usar

- Errores de validación de formulario (usa inline errors).
- Estados vacíos normales (usa DSEmptyState).
- Advertencias no bloqueantes (usa snackbars).

## Anti-patrones

- Mostrar stack traces o errores técnicos crudos.
- Omitir botón de retry cuando la acción es recuperable.
- Mensajes culpando al usuario ("Hiciste algo mal").

## Snippets rápidos

### Error básico

```dart
DSErrorState(
  message: 'Error al cargar productos',
  onRetry: () => loadProducts(),
)
```

### Con detalles

```dart
DSErrorState(
  message: 'No se pudo conectar al servidor',
  details: 'Verifica tu conexión a internet',
  onRetry: () => retry(),
)
```

### Error con ícono personalizado

```dart
DSErrorState(
  icon: Icons.wifi_off,
  message: 'Sin conexión',
  details: 'Conéctate a internet para continuar',
  onRetry: () => checkConnection(),
)
```

### Error sin retry

```dart
DSErrorState(
  message: 'Producto no disponible',
  details: 'Este producto ya no está en catálogo',
  // Sin onRetry = sin botón
)
```

---

# DSLoadingState

Vista para estados de carga mientras se obtiene contenido.

## Propósito

- Indicar al usuario que se está procesando una operación.
- Proporcionar feedback visual durante la espera.
- Opcionalmente comunicar qué se está cargando.

## API

| Propiedad | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `message` | `String?` | `null` | Mensaje opcional de carga. |
| `size` | `DSLoaderSize` | `large` | Tamaño del loader. |

## Tokens usados

- **Loader**: `DSCircularLoader` (usa `colorBrandPrimary`).
- **Espaciado**: `DSSpacing.xxl` (padding).

## Estructura visual

```
┌─────────────────────────────────┐
│                                 │
│                                 │
│          [Spinner]              │ ← DSCircularLoader
│                                 │
│    Mensaje opcional...          │ ← Solo si message != null
│                                 │
│                                 │
└─────────────────────────────────┘
```

## Tamaños disponibles

| Tamaño | Uso recomendado |
| --- | --- |
| `small` | Inline, dentro de otros componentes. |
| `medium` | Secciones pequeñas. |
| `large` | Pantallas completas (default). |
| `xlarge` | Operaciones importantes. |

## Cuándo usar

- Carga inicial de datos.
- Refresh de contenido.
- Operaciones que toman tiempo.

## Cuándo NO usar

- Botones en estado de carga (usa `isLoading` en DSButton).
- Imágenes cargando (usa placeholder o skeleton).
- Operaciones instantáneas.

## Anti-patrones

- Mostrar loader sin timeout (usuarios abandonan).
- Loaders muy pequeños en pantallas completas.
- Omitir mensaje cuando la espera es larga.

## Snippets rápidos

### Loading básico

```dart
DSLoadingState()
```

### Con mensaje

```dart
DSLoadingState(
  message: 'Cargando productos...',
)
```

### Tamaño pequeño

```dart
DSLoadingState(
  size: DSLoaderSize.medium,
  message: 'Actualizando...',
)
```

---

# Patrones de uso con DSProductGrid

El componente `DSProductGrid` integra automáticamente estos tres estados:

```dart
DSProductGrid<Product>(
  products: products,          // null = loading, [] = empty
  isLoading: isLoading,        // true = DSLoadingState
  error: errorMessage,         // != null = DSErrorState
  onRetry: () => loadProducts(),
  onProductTap: (p) => viewProduct(p),
  emptyMessage: 'No hay productos',
  loadingMessage: 'Cargando catálogo...',
)
```

### Flujo de estados

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  isLoading  │───▶│   error     │───▶│  products   │
│    true     │    │   != null   │    │   empty     │
└─────────────┘    └─────────────┘    └─────────────┘
       │                  │                  │
       ▼                  ▼                  ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│DSLoadingState│    │DSErrorState │    │DSEmptyState │
└─────────────┘    └─────────────┘    └─────────────┘
                          │
                          ▼
                   ┌─────────────┐
                   │  products   │
                   │   filled    │
                   └─────────────┘
                          │
                          ▼
                   ┌─────────────┐
                   │ GridView de │
                   │ ProductCards│
                   └─────────────┘
```

## Tabla de íconos recomendados

| Contexto | Ícono | Componente |
| --- | --- | --- |
| Carrito vacío | `shopping_cart_outlined` | DSEmptyState |
| Sin resultados | `search_off` | DSEmptyState |
| Sin favoritos | `favorite_border` | DSEmptyState |
| Sin historial | `history` | DSEmptyState |
| Sin productos | `inventory_2_outlined` | DSEmptyState |
| Error de red | `wifi_off` | DSErrorState |
| Error de servidor | `cloud_off` | DSErrorState |
| Error genérico | `error_outline` | DSErrorState |
| No encontrado | `find_in_page` | DSErrorState |
