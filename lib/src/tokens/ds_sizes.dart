/// Tokens de tamaños para componentes del sistema de diseño.
///
/// Define tamaños estándar para iconos, botones y otros componentes.
abstract final class DSSizes {
  // ============================================
  // ICON SIZES
  // ============================================

  /// Ícono extra pequeño - 12px
  static const double iconXs = 12;

  /// Ícono pequeño - 16px
  static const double iconSm = 16;

  /// Ícono medio - 20px
  static const double iconMd = 20;

  /// Ícono base - 24px
  static const double iconBase = 24;

  /// Ícono grande - 28px
  static const double iconLg = 28;

  /// Ícono extra grande - 32px
  static const double iconXl = 32;

  /// Ícono extra extra grande - 40px
  static const double iconXxl = 40;

  /// Ícono jumbo - 48px
  static const double iconJumbo = 48;

  /// Ícono mega - 64px
  static const double iconMega = 64;

  // ============================================
  // BUTTON HEIGHTS
  // WCAG 2.1 requires minimum touch target of 44px
  // ============================================

  /// Altura de botón extra pequeño - 36px
  static const double buttonXs = 36;

  /// Altura de botón pequeño - 44px (WCAG minimum touch target)
  static const double buttonSm = 44;

  /// Altura de botón medio - 44px (WCAG minimum touch target)
  static const double buttonMd = 44;

  /// Altura de botón grande - 48px
  static const double buttonLg = 48;

  /// Altura de botón extra grande - 56px
  static const double buttonXl = 56;

  // ============================================
  // LOADER SIZES
  // ============================================

  /// Loader pequeño - 16px
  static const double loaderSm = 16;

  /// Loader medio - 24px
  static const double loaderMd = 24;

  /// Loader grande - 36px
  static const double loaderLg = 36;

  /// Loader extra grande - 48px
  static const double loaderXl = 48;

  // ============================================
  // BORDER WIDTHS
  // ============================================

  /// Borde hairline - 0.5px
  static const double borderHairline = 0.5;

  /// Borde thin - 1px
  static const double borderThin = 1;

  /// Borde medium - 2px
  static const double borderMedium = 2;

  /// Borde thick - 3px
  static const double borderThick = 3;

  /// Borde heavy - 4px
  static const double borderHeavy = 4;

  // ============================================
  // SKELETON HEIGHTS
  // ============================================

  /// Altura de skeleton para texto - 16px (basado en bodyMedium)
  static const double skeletonText = 16;

  /// Altura de skeleton para título - 24px (basado en headingSmall)
  static const double skeletonTitle = 24;

  // ============================================
  // NAVIGATION SIZES
  // ============================================

  /// Altura de barra de navegación inferior - 64px
  static const double bottomNavHeight = 64;

  /// Tamaño mínimo de badge - 16px
  static const double badgeMinSize = 16;

  /// Offset horizontal del badge (posición) - -8px
  static const double badgeOffsetX = -8;

  /// Offset vertical del badge (posición) - -4px
  static const double badgeOffsetY = -4;
}
