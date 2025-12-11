import 'package:fake_store_design_system/src/atoms/atoms.dart';
import 'package:fake_store_design_system/src/molecules/cards/ds_card.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:fake_store_design_system/src/utils/enums/enums.dart';
import 'package:fake_store_design_system/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Card especializada para mostrar productos.
///
/// Incluye imagen, título, precio, rating y badge opcional.
///
/// ## Uso básico
///
/// ```dart
/// DSProductCard(
///   imageUrl: product.image,
///   title: product.title,
///   price: product.price,
///   onTap: () => viewProduct(product),
/// )
/// ```
///
/// ## Con rating y badge
///
/// ```dart
/// DSProductCard(
///   imageUrl: product.image,
///   title: product.title,
///   price: product.price,
///   rating: product.rating.rate,
///   reviewCount: product.rating.count,
///   badge: 'Nuevo',
///   badgeType: DSBadgeType.success,
///   onTap: () => viewProduct(product),
/// )
/// ```
class DSProductCard extends StatelessWidget {
  /// URL de la imagen del producto.
  final String imageUrl;

  /// Título del producto.
  final String title;

  /// Precio del producto.
  final double price;

  /// Rating del producto (0-5).
  final double? rating;

  /// Número de reviews.
  final int? reviewCount;

  /// Texto del badge (ej: "Nuevo", "Oferta").
  final String? badge;

  /// Tipo del badge.
  final DSBadgeType? badgeType;

  /// Callback cuando se toca la card.
  final VoidCallback? onTap;

  /// Callback para agregar al carrito.
  final VoidCallback? onAddToCart;

  /// Widget personalizado para la imagen.
  ///
  /// Si se proporciona, se ignora imageUrl.
  final Widget? imageWidget;

  /// Aspecto de la card.
  final double aspectRatio;

  /// Etiqueta semántica para la imagen del producto.
  ///
  /// Se recomienda proporcionar una etiqueta descriptiva para lectores de pantalla.
  /// Ejemplo: `'Foto del producto: Camiseta azul'`.
  /// Si no se proporciona, se usa el [title] del producto.
  final String? imageSemanticLabel;

  /// Crea una card de producto con imagen, título, precio y acciones.
  ///
  /// - [imageUrl]: URL de la imagen del producto.
  /// - [title]: título del producto.
  /// - [price]: precio del producto.
  /// - [rating]: calificación de 0 a 5 estrellas (opcional).
  /// - [reviewCount]: número de reseñas (opcional).
  /// - [badge]: texto del badge promocional (opcional).
  /// - [badgeType]: tipo semántico del badge (opcional).
  /// - [onTap]: callback al tocar la card (opcional).
  /// - [onAddToCart]: callback al agregar al carrito (opcional).
  /// - [imageWidget]: widget personalizado para la imagen (opcional).
  /// - [aspectRatio]: proporción de aspecto de la card, por defecto `0.7`.
  /// - [imageSemanticLabel]: etiqueta semántica para la imagen (opcional).
  const DSProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.rating,
    this.reviewCount,
    this.badge,
    this.badgeType,
    this.onTap,
    this.onAddToCart,
    this.imageWidget,
    this.aspectRatio = 0.7,
    this.imageSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DSCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(DSBorderRadius.base),
                    ),
                    child:
                        imageWidget ??
                        Semantics(
                          label: imageSemanticLabel ?? title,
                          image: true,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            semanticLabel: '', // Manejado por Semantics padre
                            errorBuilder: (_, __, ___) => ColoredBox(
                              color: tokens.colorSurfaceSecondary,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: DSSizes.iconXxl,
                                color: tokens.colorIconDisabled,
                              ),
                            ),
                            loadingBuilder: (_, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return ColoredBox(
                                color: tokens.colorSurfaceSecondary,
                                child: const Center(
                                  child: DSCircularLoader(
                                    size: DSLoaderSize.small,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  ),
                  // Badge
                  if (badge != null)
                    Positioned(
                      top: DSSpacing.sm,
                      left: DSSpacing.sm,
                      child: DSBadge(
                        text: badge!,
                        type: badgeType ?? DSBadgeType.neutral,
                        size: DSBadgeSize.small,
                      ),
                    ),
                ],
              ),
            ),
            // Información
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(DSSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Expanded(
                      child: Text(
                        title,
                        style: tokens.typographyTitleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: DSSpacing.xs),
                    // Rating
                    if (rating != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: DSSizes.iconSm,
                            color: tokens.colorFeedbackWarning,
                          ),
                          const SizedBox(width: DSSpacing.xxs),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: tokens.typographyLabelSmall,
                          ),
                          if (reviewCount != null) ...[
                            const SizedBox(width: DSSpacing.xs),
                            Text(
                              '($reviewCount)',
                              style: tokens.typographyCaption.copyWith(
                                color: tokens.colorTextTertiary,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: DSSpacing.xs),
                    ],
                    // Precio y botón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: tokens.typographyTitleMedium.copyWith(
                            color: tokens.colorBrandPrimary,
                            fontWeight: DSFontWeight.bold,
                          ),
                        ),
                        if (onAddToCart != null)
                          DSIconButton(
                            icon: Icons.add_shopping_cart,
                            size: DSButtonSize.small,
                            variant: DSButtonVariant.primary,
                            onPressed: onAddToCart,
                            tooltip: 'Agregar al carrito',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
