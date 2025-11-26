/// Variantes de botón disponibles en el sistema de diseño.
enum DSButtonVariant {
  /// Botón primario con fondo sólido
  primary,

  /// Botón secundario con borde
  secondary,

  /// Botón fantasma/transparente
  ghost,

  /// Botón de peligro/destructivo
  danger,
}

/// Tamaños de botón disponibles.
enum DSButtonSize {
  /// Pequeño - 32px de altura
  small,

  /// Mediano - 40px de altura
  medium,

  /// Grande - 48px de altura
  large,
}

/// Posición del ícono en el botón.
enum DSButtonIconPosition {
  /// Ícono a la izquierda del texto
  start,

  /// Ícono a la derecha del texto
  end,
}
