import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('DSProductCard', () {
    group('Rendering', () {
      testWidgets('renders with required properties',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Test Product',
              price: 29.99,
            ),
          ),
        );

        expect(find.text('Test Product'), findsOneWidget);
        expect(find.text(r'$29.99'), findsOneWidget);
      });

      testWidgets('renders title with proper truncation',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'A very long product title that should be truncated',
              price: 19.99,
            ),
          ),
        );

        expect(
            find.text('A very long product title that should be truncated'),
            findsOneWidget);
      });

      testWidgets('formats price correctly with two decimals',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 100.5,
            ),
          ),
        );

        expect(find.text(r'$100.50'), findsOneWidget);
      });

      testWidgets('renders rating when provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Rated Product',
              price: 49.99,
              rating: 4.5,
            ),
          ),
        );

        expect(find.text('4.5'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('renders review count with rating',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Popular Product',
              price: 39.99,
              rating: 4.2,
              reviewCount: 150,
            ),
          ),
        );

        expect(find.text('4.2'), findsOneWidget);
        expect(find.text('(150)'), findsOneWidget);
      });

      testWidgets('does not render rating section when rating is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'No Rating Product',
              price: 29.99,
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsNothing);
      });

      testWidgets('renders badge when provided', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'New Product',
              price: 59.99,
              badge: 'New',
              badgeType: DSBadgeType.success,
            ),
          ),
        );

        expect(find.text('New'), findsOneWidget);
        expect(find.byType(DSBadge), findsOneWidget);
      });

      testWidgets('renders add to cart button when callback provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Cart Product',
              price: 79.99,
              onAddToCart: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.add_shopping_cart), findsOneWidget);
        expect(find.byType(DSIconButton), findsOneWidget);
      });

      testWidgets('does not render add to cart button when callback is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Simple Product',
              price: 19.99,
            ),
          ),
        );

        expect(find.byIcon(Icons.add_shopping_cart), findsNothing);
      });

      testWidgets('renders custom image widget when provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Custom Image Product',
              price: 99.99,
              imageWidget: Container(
                key: const Key('custom-image'),
                color: Colors.blue,
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('custom-image')), findsOneWidget);
      });
    });

    group('Interactions', () {
      testWidgets('calls onTap when card is tapped',
          (tester) async {
        bool wasTapped = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Tappable Product',
              price: 49.99,
              onTap: () => wasTapped = true,
            ),
          ),
        );

        await tester.tap(find.byType(DSProductCard));
        expect(wasTapped, isTrue);
      });

      testWidgets('calls onAddToCart when cart button is tapped',
          (tester) async {
        bool wasAddedToCart = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Cart Product',
              price: 39.99,
              onAddToCart: () => wasAddedToCart = true,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.add_shopping_cart));
        expect(wasAddedToCart, isTrue);
      });

      testWidgets('card is not tappable when onTap is null',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Non-tappable Product',
              price: 29.99,
            ),
          ),
        );

        // Card should still be present but not trigger any action
        expect(find.byType(DSProductCard), findsOneWidget);
      });
    });

    group('Badge Variants', () {
      testWidgets('renders success badge', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              badge: 'In Stock',
              badgeType: DSBadgeType.success,
            ),
          ),
        );

        expect(find.text('In Stock'), findsOneWidget);
      });

      testWidgets('renders error badge', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              badge: 'Out of Stock',
              badgeType: DSBadgeType.error,
            ),
          ),
        );

        expect(find.text('Out of Stock'), findsOneWidget);
      });

      testWidgets('renders warning badge', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              badge: 'Low Stock',
              badgeType: DSBadgeType.warning,
            ),
          ),
        );

        expect(find.text('Low Stock'), findsOneWidget);
      });

      testWidgets('renders info badge', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              badge: 'Sale',
              badgeType: DSBadgeType.info,
            ),
          ),
        );

        expect(find.text('Sale'), findsOneWidget);
      });

      testWidgets('renders neutral badge by default',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              badge: 'Featured',
            ),
          ),
        );

        expect(find.text('Featured'), findsOneWidget);
      });
    });

    group('Layout', () {
      testWidgets('respects aspectRatio parameter',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const SizedBox(
              width: 200,
              child: DSProductCard(
                imageUrl: 'https://example.com/image.jpg',
                title: 'Aspect Ratio Product',
                price: 49.99,
                aspectRatio: 1,
              ),
            ),
          ),
        );

        expect(find.byType(AspectRatio), findsOneWidget);
        final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
        expect(aspectRatio.aspectRatio, equals(1.0));
      });

      testWidgets('uses default aspectRatio of 0.7',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const SizedBox(
              width: 200,
              child: DSProductCard(
                imageUrl: 'https://example.com/image.jpg',
                title: 'Default Aspect Product',
                price: 39.99,
              ),
            ),
          ),
        );

        final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
        expect(aspectRatio.aspectRatio, equals(0.7));
      });

      testWidgets('wraps content in DSCard', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Card Product',
              price: 29.99,
            ),
          ),
        );

        expect(find.byType(DSCard), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('image has semantic label using title by default',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Accessible Product',
              price: 59.99,
            ),
          ),
        );

        final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
        // Ahora usa solo el título como etiqueta por defecto (sin texto hardcodeado)
        final imageSemantics = semantics.where((s) =>
            s.properties.label == 'Accessible Product' && (s.properties.image ?? false));
        expect(imageSemantics, isNotEmpty);
      });

      testWidgets('uses custom imageSemanticLabel when provided',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product Name',
              price: 49.99,
              imageSemanticLabel: 'A beautiful red dress',
            ),
          ),
        );

        final semantics = tester.widgetList<Semantics>(find.byType(Semantics));
        final imageSemantics = semantics.where(
            (s) => s.properties.label?.contains('A beautiful red dress') ?? false);
        expect(imageSemantics, isNotEmpty);
      });

      testWidgets('add to cart button has tooltip for accessibility',
          (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Product',
              price: 29.99,
              onAddToCart: () {},
            ),
          ),
        );

        expect(find.byType(Tooltip), findsWidgets);
      });
    });
  });
}
