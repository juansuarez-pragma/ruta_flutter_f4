import 'package:fake_store_design_system/src/molecules/molecules.dart';
import 'package:fake_store_design_system/src/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// Grid de productos del sistema de diseño.
///
/// Muestra una cuadrícula de productos con manejo integrado de estados
/// de carga, error y vacío. Requiere un [itemBuilder] para construir
/// cada elemento del grid, lo que garantiza type safety completo.
///
/// ## Uso básico
///
/// ```dart
/// DSProductGrid<Product>(
///   products: products,
///   itemBuilder: (context, product, index) => DSProductCard(
///     imageUrl: product.image,
///     title: product.title,
///     price: product.price,
///     onTap: () => viewProduct(product),
///   ),
/// )
/// ```
///
/// ## Con estados de carga y error
///
/// ```dart
/// DSProductGrid<Product>(
///   products: products,
///   isLoading: isLoading,
///   error: errorMessage,
///   itemBuilder: (context, product, index) => DSProductCard(
///     imageUrl: product.image,
///     title: product.title,
///     price: product.price,
///     rating: product.rating?.rate,
///     reviewCount: product.rating?.count,
///     onTap: () => viewProduct(product),
///     onAddToCart: () => addToCart(product),
///   ),
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

  /// Builder requerido para construir cada producto.
  ///
  /// Este builder recibe el contexto, el producto y su índice,
  /// y debe retornar el widget que representa cada item del grid.
  ///
  /// Ejemplo:
  /// ```dart
  /// itemBuilder: (context, product, index) => DSProductCard(
  ///   imageUrl: product.image,
  ///   title: product.title,
  ///   price: product.price,
  /// ),
  /// ```
  final Widget Function(BuildContext context, T product, int index) itemBuilder;

  /// Mensaje cuando no hay productos.
  final String emptyMessage;

  /// Mensaje mientras carga.
  final String loadingMessage;

  /// Crea un grid de productos con manejo de estados integrado.
  ///
  /// El [itemBuilder] es requerido para garantizar type safety.
  ///
  /// - [products]: lista de productos a mostrar (opcional).
  /// - [isLoading]: indica estado de carga, por defecto `false`.
  /// - [error]: mensaje de error (opcional).
  /// - [onProductTap]: callback al tocar un producto (opcional).
  /// - [onAddToCart]: callback al agregar al carrito (opcional).
  /// - [onRetry]: callback para reintentar (opcional).
  /// - [crossAxisCount]: número de columnas, por defecto `2`.
  /// - [childAspectRatio]: proporción de cada item, por defecto `0.65`.
  /// - [crossAxisSpacing]: espacio horizontal, por defecto `DSSpacing.md`.
  /// - [mainAxisSpacing]: espacio vertical, por defecto `DSSpacing.md`.
  /// - [padding]: padding del grid, por defecto `DSSpacing.md`.
  /// - [itemBuilder]: builder requerido para construir cada producto.
  /// - [emptyMessage]: mensaje cuando no hay productos.
  /// - [loadingMessage]: mensaje mientras carga.
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
    required this.itemBuilder,
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
      return DSErrorState(message: error!, onRetry: onRetry);
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
        return itemBuilder(context, product, index);
      },
    );
  }
}
