import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Indicador de carga circular del sistema de diseño.
///
/// ## Uso básico
///
/// ```dart
/// DSCircularLoader()
/// ```
///
/// ## Con mensaje
///
/// ```dart
/// DSCircularLoader(
///   size: DSLoaderSize.large,
///   message: 'Cargando productos...',
/// )
/// ```
class DSCircularLoader extends StatelessWidget {
  /// Tamaño del loader.
  final DSLoaderSize size;

  /// Mensaje opcional debajo del loader.
  final String? message;

  /// Color del loader.
  ///
  /// Si no se especifica, usa el color de la marca primaria.
  final Color? color;

  /// Etiqueta semántica para accesibilidad.
  ///
  /// Se recomienda proporcionar una etiqueta descriptiva para lectores de pantalla.
  /// Si no se proporciona, se usa el [message] si está disponible.
  final String? semanticLabel;

  /// Crea un loader circular con el tamaño y mensaje especificados.
  const DSCircularLoader({
    super.key,
    this.size = DSLoaderSize.medium,
    this.message,
    this.color,
    this.semanticLabel,
  });

  double get _size {
    switch (size) {
      case DSLoaderSize.small:
        return DSSizes.loaderSm;
      case DSLoaderSize.medium:
        return DSSizes.loaderMd;
      case DSLoaderSize.large:
        return DSSizes.loaderLg;
      case DSLoaderSize.extraLarge:
        return DSSizes.loaderXl;
    }
  }

  double get _strokeWidth {
    switch (size) {
      case DSLoaderSize.small:
        return 2;
      case DSLoaderSize.medium:
        return 3;
      case DSLoaderSize.large:
        return 3;
      case DSLoaderSize.extraLarge:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final loaderColor = color ?? tokens.colorBrandPrimary;

    // Usar etiqueta semántica proporcionada o el mensaje
    final effectiveLabel = semanticLabel ?? message;

    return Semantics(
      label: effectiveLabel,
      liveRegion: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _size,
            height: _size,
            child: ExcludeSemantics(
              child: CircularProgressIndicator(
                strokeWidth: _strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: DSSpacing.md),
            ExcludeSemantics(
              child: Text(
                message!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: tokens.typographyBodySmall.copyWith(
                  color: tokens.colorTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
