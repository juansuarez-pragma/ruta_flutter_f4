import 'package:flutter/material.dart';

import 'package:fake_store_design_system/src/molecules/molecules.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';

/// Grid de productos del sistema de diseño.
///
/// Muestra una cuadrícula de productos con manejo integrado de estados
/// de carga, error y vacío.
///
/// ## Uso básico
///
/// ```dart
/// DSProductGrid(
///   products: products,
///   onProductTap: (product) => viewProduct(product),
/// )
/// ```
///
/// ## Con estados
///
/// ```dart
/// DSProductGrid(
///   products: products,
///   isLoading: isLoading,
///   error: errorMessage,
///   onProductTap: (product) => viewProduct(product),
///   onRetry: () => loadProducts(),
/// )
/// ```
class DSProductGrid<T> extends StatelessWidget {
  /// Lista de productos a mostrar.
  final List<T>? products;

  /// Si está en estado de carga.
  final bool isLoading;

  /// Mensaje de error.
  final String? error;

  /// Callback cuando se toca un producto.
  final void Function(T product)? onProductTap;

  /// Callback cuando se toca agregar al carrito.
  final void Function(T product)? onAddToCart;

  /// Callback para reintentar.
  final VoidCallback? onRetry;

  /// Número de columnas en el grid.
  final int crossAxisCount;

  /// Aspecto de cada item.
  final double childAspectRatio;

  /// Espacio horizontal entre items.
  final double crossAxisSpacing;

  /// Espacio vertical entre items.
  final double mainAxisSpacing;

  /// Padding del grid.
  final EdgeInsetsGeometry padding;

  /// Builder para construir cada producto.
  ///
  /// Si no se proporciona, se espera que T tenga propiedades:
  /// - image (String)
  /// - title (String)
  /// - price (double)
  /// - rating.rate (double?)
  /// - rating.count (int?)
  final Widget Function(BuildContext context, T product, int index)? itemBuilder;

  /// Mensaje cuando no hay productos.
  final String emptyMessage;

  /// Mensaje mientras carga.
  final String loadingMessage;

  const DSProductGrid({
    super.key,
    this.products,
    this.isLoading = false,
    this.error,
    this.onProductTap,
    this.onAddToCart,
    this.onRetry,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
    this.crossAxisSpacing = DSSpacing.md,
    this.mainAxisSpacing = DSSpacing.md,
    this.padding = const EdgeInsets.all(DSSpacing.base),
    this.itemBuilder,
    this.emptyMessage = 'No hay productos disponibles',
    this.loadingMessage = 'Cargando productos...',
  });

  @override
  Widget build(BuildContext context) {
    // Estado de carga
    if (isLoading) {
      return DSLoadingState(message: loadingMessage);
    }

    // Estado de error
    if (error != null) {
      return DSErrorState(
        message: error!,
        onRetry: onRetry,
      );
    }

    // Estado vacío
    if (products == null || products!.isEmpty) {
      return DSEmptyState(
        icon: Icons.inventory_2_outlined,
        title: emptyMessage,
        actionText: onRetry != null ? 'Recargar' : null,
        onAction: onRetry,
      );
    }

    // Grid de productos
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: products!.length,
      itemBuilder: (context, index) {
        final product = products![index];

        if (itemBuilder != null) {
          return itemBuilder!(context, product, index);
        }

        // Builder por defecto usando reflexión dinámica
        return _buildDefaultProductCard(context, product, index);
      },
    );
  }

  Widget _buildDefaultProductCard(BuildContext context, T product, int index) {
    // Intentar acceder a las propiedades usando dynamic
    final dynamic p = product;

    try {
      return DSProductCard(
        imageUrl: p.image as String,
        title: p.title as String,
        price: (p.price as num).toDouble(),
        rating: p.rating?.rate as double?,
        reviewCount: p.rating?.count as int?,
        onTap: onProductTap != null ? () => onProductTap!(product) : null,
        onAddToCart: onAddToCart != null ? () => onAddToCart!(product) : null,
      );
    } catch (_) {
      // Si no tiene las propiedades esperadas, mostrar placeholder
      return DSCard(
        child: Center(
          child: Text('Item $index'),
        ),
      );
    }
  }
}
