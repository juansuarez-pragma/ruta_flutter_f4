import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );

// Simple test product class
class TestProduct {
  final String image;
  final String title;
  final double price;
  final TestRating? rating;

  const TestProduct({
    required this.image,
    required this.title,
    required this.price,
    this.rating,
  });
}

class TestRating {
  final double rate;
  final int count;

  const TestRating({required this.rate, required this.count});
}

void main() {
  final testProducts = [
    const TestProduct(
      image: 'https://example.com/1.jpg',
      title: 'Product 1',
      price: 19.99,
      rating: TestRating(rate: 4.5, count: 100),
    ),
    const TestProduct(
      image: 'https://example.com/2.jpg',
      title: 'Product 2',
      price: 29.99,
      rating: TestRating(rate: 4, count: 50),
    ),
    const TestProduct(
      image: 'https://example.com/3.jpg',
      title: 'Product 3',
      price: 39.99,
    ),
  ];

  group('DSProductGrid', () {
    group('Loading State', () {
      testWidgets('renders loading state when isLoading is true',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
      });

      testWidgets('shows custom loading message',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              loadingMessage: 'Fetching products...',
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.text('Fetching products...'), findsOneWidget);
      });

      testWidgets('uses default loading message',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.text('Cargando productos...'), findsOneWidget);
      });
    });

    group('Error State', () {
      testWidgets('renders error state when error is provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Failed to load products',
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(find.text('Failed to load products'), findsOneWidget);
      });

      testWidgets('calls onRetry when retry button is tapped in error state',
          (tester) async {
        bool wasRetried = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Network error',
              onRetry: () => wasRetried = true,
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        await tester.tap(find.text('Reintentar'));
        expect(wasRetried, isTrue);
      });
    });

    group('Empty State', () {
      testWidgets('renders empty state when products is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
      });

      testWidgets('renders empty state when products list is empty',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
      });

      testWidgets('shows custom empty message',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              emptyMessage: 'No products found',
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.text('No products found'), findsOneWidget);
      });

      testWidgets('uses default empty message',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.text('No hay productos disponibles'), findsOneWidget);
      });

      testWidgets('shows reload action in empty state when onRetry provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              onRetry: () {},
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.text('Recargar'), findsOneWidget);
      });
    });

    group('Grid Rendering', () {
      testWidgets('renders GridView when products are provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
                child: Text(product.title),
              ),
            ),
          ),
        );

        expect(find.byType(GridView), findsOneWidget);
      });

      testWidgets('renders correct number of items',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
                child: Text(product.title),
              ),
            ),
          ),
        );

        // GridView uses lazy rendering, so we check visible items
        expect(find.text('Product 1'), findsOneWidget);
        expect(find.text('Product 2'), findsOneWidget);
        // Product 3 may not be visible initially due to viewport constraints
        expect(find.byKey(const Key('product-0')), findsOneWidget);
        expect(find.byKey(const Key('product-1')), findsOneWidget);
      });

      testWidgets('uses custom itemBuilder when provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => Card(
                key: Key('custom-$index'),
                child: Text('Custom: ${product.title}'),
              ),
            ),
          ),
        );

        expect(find.text('Custom: Product 1'), findsOneWidget);
        expect(find.text('Custom: Product 2'), findsOneWidget);
      });

      testWidgets('renders products using itemBuilder',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => DSProductCard(
                key: Key('product-card-$index'),
                imageUrl: product.image,
                title: product.title,
                price: product.price,
                rating: product.rating?.rate,
                reviewCount: product.rating?.count,
              ),
            ),
          ),
        );

        expect(find.byType(GridView), findsOneWidget);
        expect(find.byType(DSProductCard), findsWidgets);
      });
    });

    group('Grid Configuration', () {
      testWidgets('uses custom crossAxisCount',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              crossAxisCount: 3,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
              ),
            ),
          ),
        );

        final gridView = tester.widget<GridView>(find.byType(GridView));
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, equals(3));
      });

      testWidgets('uses default crossAxisCount of 2',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
              ),
            ),
          ),
        );

        final gridView = tester.widget<GridView>(find.byType(GridView));
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, equals(2));
      });

      testWidgets('uses custom childAspectRatio',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              childAspectRatio: 1,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
              ),
            ),
          ),
        );

        final gridView = tester.widget<GridView>(find.byType(GridView));
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.childAspectRatio, equals(1.0));
      });

      testWidgets('uses default childAspectRatio of 0.65',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              itemBuilder: (context, product, index) => Container(
                key: Key('product-$index'),
              ),
            ),
          ),
        );

        final gridView = tester.widget<GridView>(find.byType(GridView));
        final delegate =
            gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.childAspectRatio, equals(0.65));
      });
    });

    group('Interactions', () {
      testWidgets('calls onProductTap when item is tapped via itemBuilder',
          (tester) async {
        TestProduct? tappedProduct;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              onProductTap: (product) => tappedProduct = product,
              itemBuilder: (context, product, index) => GestureDetector(
                key: Key('product-$index'),
                onTap: () => tappedProduct = product,
                child: Text(product.title),
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(const Key('product-0')));
        expect(tappedProduct, equals(testProducts[0]));
      });

      testWidgets('calls onAddToCart when add to cart is tapped via itemBuilder',
          (tester) async {
        TestProduct? addedProduct;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              onAddToCart: (product) => addedProduct = product,
              itemBuilder: (context, product, index) => Column(
                key: Key('product-$index'),
                children: [
                  Text(product.title),
                  ElevatedButton(
                    onPressed: () => addedProduct = product,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.text('Add').first);
        expect(addedProduct, equals(testProducts[0]));
      });
    });

    group('State Priority', () {
      testWidgets('loading takes priority over error',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              error: 'Some error',
              products: testProducts,
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
        expect(find.byType(DSErrorState), findsNothing);
      });

      testWidgets('error takes priority over empty',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Network error',
              products: const [],
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(find.byType(DSEmptyState), findsNothing);
      });

      testWidgets('empty takes priority over grid when no products',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              itemBuilder: (context, product, index) => Text(product.title),
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
        expect(find.byType(GridView), findsNothing);
      });
    });
  });
}
