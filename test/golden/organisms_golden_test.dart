import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'golden_test_helper.dart';

void main() {
  group('Organisms Golden Tests', () {
    group('DSAppBar', () {
      testWidgets('with actions match golden', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: DSAppBar(
                title: 'App Title',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ],
              ),
              body: const SizedBox.shrink(),
            ),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_app_bar.png'),
        );
      });

      testWidgets('with back button match golden', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: DSAppBar(
                title: 'Details',
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ),
              body: const SizedBox.shrink(),
            ),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_app_bar_back.png'),
        );
      });
    });

    group('DSBottomNav', () {
      testWidgets('with badges match golden', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: FakeStoreTheme.light(),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: DSBottomNav(
                currentIndex: 0,
                items: const [
                  DSBottomNavItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Home',
                  ),
                  DSBottomNavItem(
                    icon: Icons.category_outlined,
                    selectedIcon: Icons.category,
                    label: 'Categories',
                  ),
                  DSBottomNavItem(
                    icon: Icons.shopping_cart_outlined,
                    selectedIcon: Icons.shopping_cart,
                    label: 'Cart',
                    badgeCount: 3,
                  ),
                  DSBottomNavItem(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    label: 'Profile',
                  ),
                ],
                onTap: (_) {},
              ),
              body: const SizedBox.shrink(),
            ),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_bottom_nav.png'),
        );
      });
    });

    group('DSProductGrid', () {
      testWidgets('grid layout match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            DSProductGrid<Map<String, dynamic>>(
              products: const [
                {'title': 'Product 1', 'price': 19.99},
                {'title': 'Product 2', 'price': 29.99},
                {'title': 'Product 3', 'price': 39.99},
                {'title': 'Product 4', 'price': 49.99},
              ],
              crossAxisCount: 2,
              itemBuilder: (context, product, index) => DSCard(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${product['price']}'),
                    ],
                  ),
                ),
              ),
            ),
            size: const Size(400, 400),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_product_grid.png'),
        );
      });

      testWidgets('loading state match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            const DSProductGrid<Map<String, dynamic>>(
              isLoading: true,
            ),
            size: const Size(350, 300),
          ),
        );

        // Pump for animation frame
        await tester.pump();

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_product_grid_loading.png'),
        );
      });

      testWidgets('error state match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            DSProductGrid<Map<String, dynamic>>(
              error: 'Failed to load products',
              onRetry: () {},
            ),
            size: const Size(400, 350),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_product_grid_error.png'),
        );
      });
    });
  });
}
