/// Sistema de diseño Flutter para la aplicación Fake Store.
///
/// Proporciona tokens de diseño, componentes UI reutilizables y soporte
/// para temas claro/oscuro siguiendo la metodología Atomic Design.
///
/// ## Uso básico
///
/// ```dart
/// import 'package:fake_store_design_system/fake_store_design_system.dart';
///
/// void main() {
///   runApp(MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       theme: FakeStoreTheme.light(),
///       darkTheme: FakeStoreTheme.dark(),
///       themeMode: ThemeMode.system,
///       home: HomePage(),
///     );
///   }
/// }
/// ```
///
/// ## Acceso a tokens
///
/// ```dart
/// Widget build(BuildContext context) {
///   // Acceso via extensión de contexto
///   final tokens = context.tokens;
///
///   return Container(
///     color: tokens.colorSurfacePrimary,
///     padding: EdgeInsets.all(DSSpacing.base),
///     child: DSText(
///       'Hello World',
///       variant: DSTextVariant.headingLarge,
///     ),
///   );
/// }
/// ```
library;

// ============================================
// ATOMS
// ============================================
export 'src/atoms/atoms.dart';
// ============================================
// FOUNDATIONS
// ============================================
export 'src/foundations/foundations.dart';
// ============================================
// MOLECULES
// ============================================
export 'src/molecules/molecules.dart';
// ============================================
// ORGANISMS
// ============================================
export 'src/organisms/organisms.dart';
// ============================================
// TOKENS
// ============================================
export 'src/tokens/tokens.dart';
// ============================================
// UTILS
// ============================================
export 'src/utils/utils.dart';
