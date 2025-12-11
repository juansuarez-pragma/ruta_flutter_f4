# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Documentación completa con estructura Diátaxis
  - `docs/API_REFERENCE.md` - Referencia técnica completa
  - `docs/HOWTO.md` - Guías paso a paso
  - `docs/CHANGELOG.md` - Este archivo

### Changed
- README.md restructurado con Quick Start y TOC
- Reducción de 364 a ~180 líneas en README

---

## [1.0.0] - 2024-XX-XX

### Added

#### Tokens de Diseño
- Sistema completo de colores (96+ colores en paleta)
- Espaciado basado en escala de 4px (8 niveles)
- Tipografía con 12 variantes predefinidas
- Border radius (8 niveles de none a full)
- Elevación (5 niveles de sombra)
- Duraciones de animación
- Tamaños estándar para iconos y botones

#### Componentes Atómicos (7)
- `DSButton` - Botón con 4 variantes y 3 tamaños
- `DSIconButton` - Botón circular con ícono
- `DSBadge` - Badge con 5 tipos semánticos
- `DSText` - Texto con 12 variantes tipográficas
- `DSTextField` - Campo de texto con validación visual
- `DSCircularLoader` - Loader circular con 4 tamaños
- `DSSkeleton` - Placeholder animado para loading

#### Componentes Moleculares (6)
- `DSCard` - Card contenedora con elevación
- `DSProductCard` - Card especializada para productos
- `DSFilterChip` - Chip seleccionable para filtros
- `DSEmptyState` - Vista de estado vacío
- `DSErrorState` - Vista de estado de error con retry
- `DSLoadingState` - Vista de estado de carga

#### Componentes de Organismo (3)
- `DSAppBar` - AppBar personalizado
- `DSProductGrid` - Grid de productos con manejo de estados
- `DSBottomNav` - Navegación inferior con badges

#### Sistema de Temas
- `FakeStoreTheme` - Clase de conveniencia para temas
- `DSThemeData` - ThemeExtension con 85+ tokens semánticos
- Tema claro completo
- Tema oscuro completo
- Soporte para transiciones suaves entre temas

#### Utilidades
- `context.tokens` - Acceso fácil a tokens via extensión
- `context.isDarkMode` / `context.isLightMode` - Verificación de tema
- `context.isMobile` / `context.isTablet` - Verificación de breakpoints

#### Accesibilidad
- Touch targets WCAG 2.1 (mínimo 44px)
- Semantics para screen readers en componentes interactivos
- Labels accesibles en botones, inputs y navegación

#### Testing
- 400+ tests unitarios
- Cobertura de todos los componentes
- Tests de accesibilidad (touch targets, semantics)
- Tests responsivos (breakpoints, orientación)

#### Documentación
- README con ejemplos de uso
- CLAUDE.md para asistentes de IA
- Documentación dartdoc en todos los componentes
- App de showcase interactiva

### Fixed
- Overflow en `DSErrorState` cuando hay poco espacio vertical
- Overflow en `DSEmptyState` cuando hay poco espacio vertical
- FittedBox con constraints infinitos en ComparisonPlayground

---

## Guía de Versionado

### Versión Major (X.0.0)
- Cambios breaking en API pública
- Renombrado de componentes o tokens
- Eliminación de funcionalidades

### Versión Minor (0.X.0)
- Nuevos componentes
- Nuevas funcionalidades en componentes existentes
- Nuevos tokens

### Versión Patch (0.0.X)
- Corrección de bugs
- Mejoras de rendimiento
- Actualizaciones de documentación

---

## Links

- [Repositorio](https://github.com/tu-org/fake_store_design_system)
- [Reportar Bug](https://github.com/tu-org/fake_store_design_system/issues)
- [Solicitar Feature](https://github.com/tu-org/fake_store_design_system/issues)
