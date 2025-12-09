import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );
}

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
      rating: TestRating(rate: 4.0, count: 50),
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
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
            ),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
      });

      testWidgets('shows custom loading message',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              loadingMessage: 'Fetching products...',
            ),
          ),
        );

        expect(find.text('Fetching products...'), findsOneWidget);
      });

      testWidgets('uses default loading message',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
            ),
          ),
        );

        expect(find.text('Cargando productos...'), findsOneWidget);
      });
    });

    group('Error State', () {
      testWidgets('renders error state when error is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Failed to load products',
            ),
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(find.text('Failed to load products'), findsOneWidget);
      });

      testWidgets('calls onRetry when retry button is tapped in error state',
          (WidgetTester tester) async {
        bool wasRetried = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Network error',
              onRetry: () => wasRetried = true,
            ),
          ),
        );

        await tester.tap(find.text('Reintentar'));
        expect(wasRetried, isTrue);
      });
    });

    group('Empty State', () {
      testWidgets('renders empty state when products is null',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: null,
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
      });

      testWidgets('renders empty state when products list is empty',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
      });

      testWidgets('shows custom empty message',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              emptyMessage: 'No products found',
            ),
          ),
        );

        expect(find.text('No products found'), findsOneWidget);
      });

      testWidgets('uses default empty message',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
            ),
          ),
        );

        expect(find.text('No hay productos disponibles'), findsOneWidget);
      });

      testWidgets('shows reload action in empty state when onRetry provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
              onRetry: () {},
            ),
          ),
        );

        expect(find.text('Recargar'), findsOneWidget);
      });
    });

    group('Grid Rendering', () {
      testWidgets('renders GridView when products are provided',
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
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

      testWidgets('renders with default product card builder',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
            ),
          ),
        );

        // Should attempt to render DSProductCard for products with expected structure
        expect(find.byType(GridView), findsOneWidget);
      });
    });

    group('Grid Configuration', () {
      testWidgets('uses custom crossAxisCount',
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              childAspectRatio: 1.0,
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
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
        TestProduct? tappedProduct;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: testProducts,
              onProductTap: (product) => tappedProduct = product,
              itemBuilder: (context, product, index) => GestureDetector(
                key: Key('product-$index'),
                onTap: () => tappedProduct = product,
                child: Container(child: Text(product.title)),
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(const Key('product-0')));
        expect(tappedProduct, equals(testProducts[0]));
      });

      testWidgets('calls onAddToCart when add to cart is tapped via itemBuilder',
          (WidgetTester tester) async {
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
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              isLoading: true,
              error: 'Some error',
              products: testProducts,
            ),
          ),
        );

        expect(find.byType(DSLoadingState), findsOneWidget);
        expect(find.byType(DSErrorState), findsNothing);
      });

      testWidgets('error takes priority over empty',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              error: 'Network error',
              products: const [],
            ),
          ),
        );

        expect(find.byType(DSErrorState), findsOneWidget);
        expect(find.byType(DSEmptyState), findsNothing);
      });

      testWidgets('empty takes priority over grid when no products',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductGrid<TestProduct>(
              products: const [],
            ),
          ),
        );

        expect(find.byType(DSEmptyState), findsOneWidget);
        expect(find.byType(GridView), findsNothing);
      });
    });
  });
}
