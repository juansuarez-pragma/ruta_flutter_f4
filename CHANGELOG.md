# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [1.1.0] - 2024-12-09

### Agregado

#### Tokens de Accesibilidad
- `buttonDangerBackgroundDisabled`: Color de fondo para botón danger deshabilitado
- `buttonDangerTextDisabled`: Color de texto para botón danger deshabilitado

#### Propiedades de Accesibilidad en Componentes
- `DSTextField.semanticLabel`: Etiqueta semántica personalizable para screen readers
- `DSProductCard.imageSemanticLabel`: Etiqueta semántica para imágenes de productos
- `DSIconButton`: Widget Semantics con soporte para tooltip, loading y disabled states
- `DSBottomNav`: Semantics con posición de tab, badge count y estado seleccionado

#### Tests
- Suite completa de tests de accesibilidad (21 tests)
- Tests de componentes Atoms (53 tests)
- Tests de componentes Molecules (~25 tests)
- Tests de componentes Organisms (~25 tests)
- Tests de context extensions (~10 tests)
- **Total: 133 tests**

### Cambiado

#### WCAG 2.1 Compliance
- `DSSizes.buttonSm`: 32px → 44px (mínimo WCAG touch target)
- `DSSizes.buttonMd`: 40px → 44px (mínimo WCAG touch target)

#### Mejoras de Error Handling
- `FakeStoreTheme.of()`: assert → FlutterError con mensaje descriptivo

### Corregido
- `DSButton` variante danger: Ahora usa tokens correctos para estado disabled
  - Antes: `buttonPrimaryBackgroundDisabled` / `buttonPrimaryTextDisabled`
  - Ahora: `buttonDangerBackgroundDisabled` / `buttonDangerTextDisabled`

---

## [1.0.0] - 2024-01-XX

### Agregado

#### Design Tokens
- `DSColors`: Paleta completa de colores (primarios, neutros, semánticos, alpha)
- `DSSpacing`: Sistema de espaciado basado en escala de 4px
- `DSTypography`: Familias, pesos, tamaños y alturas de línea
- `DSBorderRadius`: Escala de radios de borde
- `DSElevation`: Niveles de sombra para modo claro y oscuro
- `DSDuration`: Duraciones de animación estándar
- `DSSizes`: Tamaños para íconos, botones, inputs, avatares, loaders

#### Foundations
- `DSThemeData`: ThemeExtension con 80+ tokens semánticos
- `DSThemeLight`: Tema claro completo
- `DSThemeDark`: Tema oscuro completo
- `FakeStoreTheme`: Clase de conveniencia para acceder a temas
- Context extensions: `context.tokens`, `context.isDarkMode`, `context.isTablet`

#### Átomos
- `DSButton`: Botón con variantes (primary, secondary, ghost, danger)
- `DSIconButton`: Botón de ícono circular
- `DSBadge`: Badge con tipos (success, error, warning, info, neutral)
- `DSText`: Componente de texto con variantes tipográficas
- `DSTextField`: Campo de texto con validación y estados
- `DSCircularLoader`: Indicador de carga circular
- `DSSkeleton`: Placeholder animado para loading states

#### Moléculas
- `DSCard`: Card base con elevación y padding
- `DSProductCard`: Card especializada para productos
- `DSFilterChip`: Chip seleccionable para filtros
- `DSEmptyState`: Vista de estado vacío
- `DSErrorState`: Vista de estado de error con retry
- `DSLoadingState`: Vista de estado de carga

#### Organismos
- `DSAppBar`: AppBar personalizado del sistema de diseño
- `DSProductGrid`: Grid de productos con manejo de estados
- `DSBottomNav`: Navegación inferior con soporte para badges

### Integración
- Integración completa con la aplicación de ejemplo Fake Store
- Soporte para modo claro y oscuro automático
- Documentación inline con dartdoc
- Tests unitarios para tokens y temas
