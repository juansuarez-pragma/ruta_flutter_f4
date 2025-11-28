import 'package:flutter/material.dart';

import 'package:fake_store_design_system/src/atoms/atoms.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';

/// Vista para estados de carga del sistema de diseño.
///
/// Se usa mientras se está cargando contenido.
///
/// ## Uso básico
///
/// ```dart
/// DSLoadingState()
/// ```
///
/// ## Con mensaje
///
/// ```dart
/// DSLoadingState(
///   message: 'Cargando productos...',
/// )
/// ```
class DSLoadingState extends StatelessWidget {
  /// Mensaje opcional de carga.
  final String? message;

  /// Tamaño del loader.
  final DSLoaderSize size;

  const DSLoadingState({
    super.key,
    this.message,
    this.size = DSLoaderSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DSSpacing.xxl),
        child: DSCircularLoader(
          size: size,
          message: message,
        ),
      ),
    );
  }
}
