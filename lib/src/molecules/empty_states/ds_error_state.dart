import 'package:fake_store_design_system/src/atoms/atoms.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Vista para estados de error del sistema de diseño.
///
/// Se usa cuando ocurre un error que impide mostrar contenido.
///
/// ## Uso básico
///
/// ```dart
/// DSErrorState(
///   message: 'Error al cargar productos',
///   onRetry: () => loadProducts(),
/// )
/// ```
///
/// ## Con detalles
///
/// ```dart
/// DSErrorState(
///   message: 'No se pudo conectar al servidor',
///   details: 'Verifica tu conexión a internet',
///   onRetry: () => retry(),
/// )
/// ```
class DSErrorState extends StatelessWidget {
  /// Mensaje principal de error.
  final String message;

  /// Detalles adicionales del error.
  final String? details;

  /// Callback para reintentar.
  final VoidCallback? onRetry;

  /// Texto del botón de reintentar.
  final String retryText;

  /// Ícono a mostrar.
  final IconData icon;

  /// Crea una vista de estado de error con mensaje y opción de reintentar.
  ///
  /// - [message]: mensaje principal de error.
  /// - [details]: detalles adicionales del error (opcional).
  /// - [onRetry]: callback para reintentar (opcional).
  /// - [retryText]: texto del botón de reintentar, por defecto `'Reintentar'`.
  /// - [icon]: ícono a mostrar, por defecto `Icons.error_outline`.
  const DSErrorState({
    super.key,
    required this.message,
    this.details,
    this.onRetry,
    this.retryText = 'Reintentar',
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DSSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: DSSizes.iconMega,
                color: tokens.colorFeedbackError,
              ),
              const SizedBox(height: DSSpacing.lg),
              DSText.headingSmall(
                message,
                textAlign: TextAlign.center,
                color: tokens.colorTextPrimary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (details != null) ...[
                const SizedBox(height: DSSpacing.sm),
                DSText.bodyMedium(
                  details!,
                  textAlign: TextAlign.center,
                  color: tokens.colorTextSecondary,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: DSSpacing.xl),
                DSButton.secondary(
                  text: retryText,
                  icon: Icons.refresh,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
