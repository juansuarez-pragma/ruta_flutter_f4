import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Skeleton para estados de carga del sistema de diseño.
///
/// Proporciona un placeholder animado para indicar contenido que se está cargando.
///
/// ## Uso básico
///
/// ```dart
/// DSSkeleton(
///   width: 200,
///   height: 20,
/// )
/// ```
///
/// ## Skeleton circular (para avatares)
///
/// ```dart
/// DSSkeleton.circular(size: 48)
/// ```
class DSSkeleton extends StatefulWidget {
  /// Ancho del skeleton.
  final double? width;

  /// Alto del skeleton.
  final double? height;

  /// Radio del borde.
  final double borderRadius;

  /// Si el skeleton es circular.
  final bool isCircular;

  /// Etiqueta semántica personalizada para accesibilidad.
  ///
  /// Si no se proporciona, se usa 'Loading content'.
  final String? semanticLabel;

  /// Crea un skeleton rectangular con las dimensiones especificadas.
  const DSSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = DSBorderRadius.sm,
    this.isCircular = false,
    this.semanticLabel,
  });

  /// Crea un skeleton circular.
  const DSSkeleton.circular({super.key, required double size, this.semanticLabel})
    : width = size,
      height = size,
      borderRadius = DSBorderRadius.full,
      isCircular = true;

  /// Crea un skeleton para texto.
  const DSSkeleton.text({super.key, this.width, double? height, this.semanticLabel})
    : height = height ?? 16,
      borderRadius = DSBorderRadius.xs,
      isCircular = false;

  /// Crea un skeleton para un título.
  const DSSkeleton.title({super.key, this.width, this.semanticLabel})
    : height = 24,
      borderRadius = DSBorderRadius.sm,
      isCircular = false;

  /// Crea un skeleton para una imagen.
  const DSSkeleton.image({super.key, this.width, this.height, this.semanticLabel})
    : borderRadius = DSBorderRadius.md,
      isCircular = false;

  @override
  State<DSSkeleton> createState() => _DSSkeletonState();
}

class _DSSkeletonState extends State<DSSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: DSDuration.long, vsync: this)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.3,
      end: 0.6,
    ).animate(CurvedAnimation(parent: _controller, curve: DSCurves.standard));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    // Build semantic label
    final effectiveLabel = widget.semanticLabel ?? 'Loading content';

    return Semantics(
      label: effectiveLabel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: tokens.colorBorderPrimary.withValues(
                alpha: _animation.value,
              ),
              borderRadius: widget.isCircular
                  ? null
                  : BorderRadius.circular(widget.borderRadius),
              shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
            ),
          ),
      ),
    );
  }
}
