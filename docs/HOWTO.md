# How-To Guides

Guías paso a paso para resolver tareas específicas con el Design System.

## Tabla de Contenidos

- [Agregar el DS a un proyecto existente](#agregar-el-ds-a-un-proyecto-existente)
- [Personalizar colores del tema](#personalizar-colores-del-tema)
- [Crear un componente nuevo](#crear-un-componente-nuevo)
- [Agregar un nuevo token](#agregar-un-nuevo-token)
- [Migrar desde widgets nativos de Flutter](#migrar-desde-widgets-nativos-de-flutter)
- [Implementar modo oscuro](#implementar-modo-oscuro)
- [Usar estados de carga/error/vacío](#usar-estados-de-cargaerrorvacío)

---

## Agregar el DS a un proyecto existente

### Prerequisitos
- Flutter 3.0+
- Proyecto Flutter existente

### Pasos

**1. Agregar dependencia**

Edita `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fake_store_design_system:
    path: ../fake_store_design_system  # Ajusta la ruta relativa
```

**2. Instalar dependencias**

```bash
flutter pub get
```

**3. Configurar tema en main.dart**

```dart
import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      // Configurar temas del Design System
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: ThemeMode.system,  // Automático según sistema
      home: const HomePage(),
    );
  }
}
```

**4. Verificar instalación**

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Si esto funciona, el DS está correctamente instalado
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.colorSurfacePrimary,
      body: Center(
        child: DSButton.primary(
          text: 'DS Funcionando!',
          onPressed: () {},
        ),
      ),
    );
  }
}
```

---

## Personalizar colores del tema

### Opción 1: Override de ThemeData (recomendado)

```dart
MaterialApp(
  theme: FakeStoreTheme.light().copyWith(
    // Override colores específicos de Material
    colorScheme: FakeStoreTheme.light().colorScheme.copyWith(
      primary: Colors.teal,
    ),
  ),
)
```

### Opción 2: Crear tema personalizado

Crea un archivo `my_theme.dart`:

```dart
import 'package:fake_store_design_system/fake_store_design_system.dart';

class MyTheme {
  static ThemeData light() {
    final baseTheme = FakeStoreTheme.light();

    return baseTheme.copyWith(
      // Personalizar colores
      primaryColor: Colors.teal,

      // Personalizar ThemeExtension
      extensions: [
        DSThemeData(
          // Copiar valores base y modificar los necesarios
          colorSurfacePrimary: Colors.white,
          colorBrandPrimary: Colors.teal,
          // ... otros tokens
        ),
      ],
    );
  }
}
```

---

## Crear un componente nuevo

### Paso 1: Determinar nivel Atomic Design

| Si el componente... | Nivel | Carpeta |
|---------------------|-------|---------|
| Es un elemento básico (botón, input, texto) | Átomo | `atoms/` |
| Combina 2+ átomos con propósito específico | Molécula | `molecules/` |
| Es una sección completa de UI | Organismo | `organisms/` |

### Paso 2: Crear archivo

```
lib/src/atoms/mi_categoria/ds_mi_componente.dart
```

### Paso 3: Implementar estructura estándar

```dart
import 'package:flutter/material.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';

/// Descripción del componente.
///
/// ## Uso básico
///
/// ```dart
/// DSMiComponente(
///   propiedad: valor,
/// )
/// ```
class DSMiComponente extends StatelessWidget {
  /// Descripción de la propiedad requerida.
  final String propiedad;

  /// Descripción de la propiedad opcional.
  final bool opcional;

  const DSMiComponente({
    super.key,
    required this.propiedad,
    this.opcional = false,
  });

  @override
  Widget build(BuildContext context) {
    // SIEMPRE usar tokens del tema
    final tokens = context.tokens;

    return Container(
      padding: const EdgeInsets.all(DSSpacing.base),
      decoration: BoxDecoration(
        color: tokens.colorSurfacePrimary,
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
      ),
      child: Text(
        propiedad,
        style: tokens.typographyBodyMedium.copyWith(
          color: tokens.colorTextPrimary,
        ),
      ),
    );
  }

  /// Constructor nombrado para variante común.
  const DSMiComponente.variante({
    super.key,
    required this.propiedad,
  }) : opcional = true;
}
```

### Paso 4: Exportar en barrel file

Edita el barrel file correspondiente:

```dart
// lib/src/atoms/mi_categoria/mi_categoria.dart
export 'ds_mi_componente.dart';
```

### Paso 5: Agregar tests

```dart
// test/atoms/mi_categoria/ds_mi_componente_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

void main() {
  testWidgets('DSMiComponente renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: FakeStoreTheme.light(),
        home: Scaffold(
          body: DSMiComponente(propiedad: 'Test'),
        ),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });
}
```

---

## Agregar un nuevo token

### Paso 1: Agregar valor primitivo

Edita el archivo de tokens correspondiente:

```dart
// lib/src/tokens/ds_colors.dart
abstract final class DSColors {
  // ... tokens existentes

  /// Mi nuevo color - #FF5722
  static const Color miNuevoColor = Color(0xFFFF5722);
}
```

### Paso 2: Agregar token semántico (si aplica)

Edita `DSThemeData`:

```dart
// lib/src/foundations/theme/ds_theme_data.dart
class DSThemeData extends ThemeExtension<DSThemeData> {
  // ... propiedades existentes

  /// Mi nuevo token semántico.
  final Color colorMiNuevoToken;

  const DSThemeData({
    // ... parámetros existentes
    required this.colorMiNuevoToken,
  });

  @override
  DSThemeData copyWith({
    // ... otros
    Color? colorMiNuevoToken,
  }) {
    return DSThemeData(
      // ... otros
      colorMiNuevoToken: colorMiNuevoToken ?? this.colorMiNuevoToken,
    );
  }

  @override
  DSThemeData lerp(DSThemeData? other, double t) {
    if (other == null) return this;
    return DSThemeData(
      // ... otros
      colorMiNuevoToken: Color.lerp(colorMiNuevoToken, other.colorMiNuevoToken, t)!,
    );
  }
}
```

### Paso 3: Definir valores por tema

```dart
// lib/src/foundations/theme/ds_theme_light.dart
static DSThemeData get data => DSThemeData(
  // ... otros
  colorMiNuevoToken: DSColors.miNuevoColor,
);

// lib/src/foundations/theme/ds_theme_dark.dart
static DSThemeData get data => DSThemeData(
  // ... otros
  colorMiNuevoToken: DSColors.miNuevoColor.withOpacity(0.8),  // Ajuste para dark
);
```

---

## Migrar desde widgets nativos de Flutter

### Tabla de migración rápida

| Widget Flutter | Componente DS | Cambios |
|----------------|---------------|---------|
| `ElevatedButton` | `DSButton.primary()` | `child` → `text` |
| `OutlinedButton` | `DSButton.secondary()` | `child` → `text` |
| `TextButton` | `DSButton.ghost()` | `child` → `text` |
| `IconButton` | `DSIconButton()` | Agregar `tooltip` |
| `Text` | `DSText()` | Agregar `variant` |
| `TextField` | `DSTextField()` | Props similares |
| `Card` | `DSCard()` | `elevation` → `DSElevationLevel` |
| `Chip` | `DSFilterChip()` | API simplificada |
| `CircularProgressIndicator` | `DSCircularLoader()` | Agregar `size` |
| `AppBar` | `DSAppBar()` | `title` es String |
| `NavigationBar` | `DSBottomNav()` | Usar `DSBottomNavItem` |

### Ejemplo: Migrar botones

```dart
// ANTES (Flutter nativo)
ElevatedButton(
  onPressed: () => doSomething(),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.save),
      SizedBox(width: 8),
      Text('Guardar'),
    ],
  ),
)

// DESPUÉS (Design System)
DSButton.primary(
  text: 'Guardar',
  icon: Icons.save,
  onPressed: () => doSomething(),
)
```

### Ejemplo: Migrar TextField

```dart
// ANTES
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'correo@ejemplo.com',
    prefixIcon: Icon(Icons.email),
    errorText: hasError ? 'Email inválido' : null,
  ),
  onChanged: (value) => validateEmail(value),
)

// DESPUÉS
DSTextField(
  label: 'Email',
  hintText: 'correo@ejemplo.com',
  prefixIcon: Icons.email,
  errorText: hasError ? 'Email inválido' : null,
  onChanged: (value) => validateEmail(value),
)
```

---

## Implementar modo oscuro

### Configuración básica

```dart
MaterialApp(
  theme: FakeStoreTheme.light(),
  darkTheme: FakeStoreTheme.dark(),
  themeMode: ThemeMode.system,  // Sigue preferencias del sistema
)
```

### Control manual del tema

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: _themeMode,
      home: HomePage(onToggleTheme: toggleTheme),
    );
  }
}
```

### Detectar tema actual

```dart
Widget build(BuildContext context) {
  if (context.isDarkMode) {
    // Ajustes específicos para modo oscuro
  }

  // O usar tokens que cambian automáticamente
  final tokens = context.tokens;
  return Container(
    color: tokens.colorSurfacePrimary,  // Blanco en light, negro en dark
  );
}
```

---

## Usar estados de carga/error/vacío

### Patrón recomendado con DSProductGrid

```dart
class ProductListPage extends StatefulWidget {
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product>? _products;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final products = await api.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSAppBar(title: 'Productos'),
      body: DSProductGrid<Product>(
        products: _products,
        isLoading: _isLoading,
        error: _error,
        onRetry: _loadProducts,
        emptyMessage: 'No hay productos disponibles',
        loadingMessage: 'Cargando productos...',
        itemBuilder: (context, product, index) => DSProductCard(
          imageUrl: product.image,
          title: product.title,
          price: product.price,
          onTap: () => _viewProduct(product),
        ),
      ),
    );
  }
}
```

### Uso individual de estados

```dart
// Estado de carga
if (isLoading) {
  return DSLoadingState(message: 'Cargando...');
}

// Estado de error
if (error != null) {
  return DSErrorState(
    message: 'Error al cargar datos',
    details: error,
    onRetry: () => loadData(),
  );
}

// Estado vacío
if (items.isEmpty) {
  return DSEmptyState(
    icon: Icons.inbox_outlined,
    title: 'Sin resultados',
    description: 'No encontramos lo que buscas',
    actionText: 'Limpiar filtros',
    onAction: () => clearFilters(),
  );
}

// Contenido normal
return ListView.builder(...);
```
