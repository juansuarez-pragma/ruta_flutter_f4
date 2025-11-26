import 'package:flutter/material.dart';

import '../../tokens/tokens.dart';
import '../../utils/extensions/extensions.dart';

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

  const DSSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = DSBorderRadius.sm,
    this.isCircular = false,
  });

  /// Crea un skeleton circular.
  const DSSkeleton.circular({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = DSBorderRadius.full,
        isCircular = true;

  /// Crea un skeleton para texto.
  const DSSkeleton.text({
    super.key,
    this.width,
    double? height,
  })  : height = height ?? 16,
        borderRadius = DSBorderRadius.xs,
        isCircular = false;

  /// Crea un skeleton para un título.
  const DSSkeleton.title({
    super.key,
    this.width,
  })  : height = 24,
        borderRadius = DSBorderRadius.sm,
        isCircular = false;

  /// Crea un skeleton para una imagen.
  const DSSkeleton.image({
    super.key,
    this.width,
    this.height,
  })  : borderRadius = DSBorderRadius.md,
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
    _controller = AnimationController(
      duration: DSDuration.long,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: DSCurves.standard),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: tokens.colorBorderPrimary.withValues(alpha: _animation.value),
            borderRadius: widget.isCircular
                ? null
                : BorderRadius.circular(widget.borderRadius),
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
        );
      },
    );
  }
}
