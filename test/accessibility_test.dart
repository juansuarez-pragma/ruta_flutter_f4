import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper widget to wrap components with the design system theme.
Widget buildTestableWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );

void main() {
  group('Accessibility - Touch Targets (WCAG 2.1)', () {
    testWidgets('DSButton small meets minimum touch target of 44px',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSButton(
            text: 'Test',
            size: DSButtonSize.small,
            onPressed: () {},
          ),
        ),
      );

      final buttonFinder = find.byType(DSButton);
      expect(buttonFinder, findsOneWidget);

      final buttonSize = tester.getSize(buttonFinder);
      expect(
        buttonSize.height,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
    });

    testWidgets('DSButton medium meets minimum touch target of 44px',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSButton(
            text: 'Test',
            onPressed: () {},
          ),
        ),
      );

      final buttonFinder = find.byType(DSButton);
      final buttonSize = tester.getSize(buttonFinder);
      expect(
        buttonSize.height,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
    });

    testWidgets('DSIconButton small meets minimum touch target of 44px',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSIconButton(
            icon: Icons.favorite,
            size: DSButtonSize.small,
            onPressed: () {},
          ),
        ),
      );

      final buttonFinder = find.byType(DSIconButton);
      final buttonSize = tester.getSize(buttonFinder);
      expect(
        buttonSize.height,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
      expect(
        buttonSize.width,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
    });

    test('DSSizes.buttonSm is at least 44px', () {
      expect(
        DSSizes.buttonSm,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
    });

    test('DSSizes.buttonMd is at least 44px', () {
      expect(
        DSSizes.buttonMd,
        greaterThanOrEqualTo(44.0),
        reason: 'WCAG 2.1 requires minimum touch target of 44px',
      );
    });
  });

  group('Accessibility - DSIconButton Semantics', () {
    testWidgets('DSIconButton has Semantics widget with button property',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSIconButton(
            icon: Icons.favorite,
            onPressed: () {},
          ),
        ),
      );

      // Verify Semantics widget exists
      final semanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && (widget.properties.button ?? false),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSIconButton with tooltip has semantic label',
        (tester) async {
      const tooltipText = 'Add to favorites';
      await tester.pumpWidget(
        buildTestableWidget(
          DSIconButton(
            icon: Icons.favorite,
            tooltip: tooltipText,
            onPressed: () {},
          ),
        ),
      );

      // Verify semantic label contains tooltip
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.contains(tooltipText),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSIconButton loading state includes loading in label',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSIconButton(
            icon: Icons.favorite,
            isLoading: true,
            onPressed: () {},
          ),
        ),
      );

      // Verify loading is in semantic label
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.contains('loading'),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSIconButton disabled has enabled=false in semantics',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const DSIconButton(
            icon: Icons.favorite,
          ),
        ),
      );

      // Verify enabled is false in semantics
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.button ?? false) &&
            widget.properties.enabled == false,
      );
      expect(semanticsFinder, findsOneWidget);
    });
  });

  group('Accessibility - DSTextField Semantics', () {
    testWidgets('DSTextField has Semantics widget with textField property',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: 'Email',
            hint: 'Enter your email',
          ),
        ),
      );

      // Verify Semantics widget with textField property exists
      final semanticsFinder = find.byWidgetPredicate(
        (widget) => widget is Semantics && (widget.properties.textField ?? false),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSTextField uses label as semantic label',
        (tester) async {
      const labelText = 'Email Address';
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: labelText,
          ),
        ),
      );

      // Verify semantic label contains the field label
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.textField ?? false) &&
            widget.properties.label != null &&
            widget.properties.label!.contains(labelText),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSTextField uses custom semanticLabel when provided',
        (tester) async {
      const customLabel = 'Custom accessible label';
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: 'Email',
            semanticLabel: customLabel,
          ),
        ),
      );

      // Verify custom semantic label is used
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.contains(customLabel),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSTextField with error has error in semantic hint',
        (tester) async {
      const errorText = 'Invalid email format';
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: 'Email',
            errorText: errorText,
          ),
        ),
      );

      // Verify error is in semantic hint
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.hint != null &&
            widget.properties.hint!.contains('Error') &&
            widget.properties.hint!.contains(errorText),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSTextField password has Password field in semantic hint',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: 'Password',
            obscureText: true,
          ),
        ),
      );

      // Verify password field hint
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.hint != null &&
            widget.properties.hint!.contains('Password field'),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSTextField disabled has enabled=false in semantics',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const DSTextField(
            label: 'Email',
            enabled: false,
          ),
        ),
      );

      // Verify enabled is false
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.textField ?? false) &&
            widget.properties.enabled == false,
      );
      expect(semanticsFinder, findsOneWidget);
    });
  });

  group('Accessibility - DSBottomNav Semantics', () {
    testWidgets('DSBottomNav items have Semantics with button property',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSBottomNav(
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              DSBottomNavItem(icon: Icons.home, label: 'Home'),
              DSBottomNavItem(icon: Icons.search, label: 'Search'),
            ],
          ),
        ),
      );

      // Verify each nav item has Semantics with button property
      // Ahora usa solo el label del item (sin strings hardcodeados)
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.button ?? false) &&
            widget.properties.label != null,
      );
      expect(semanticsFinder, findsNWidgets(2));
    });

    testWidgets('DSBottomNav selected item has selected=true in semantics',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSBottomNav(
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              DSBottomNavItem(icon: Icons.home, label: 'Home'),
              DSBottomNavItem(icon: Icons.search, label: 'Search'),
            ],
          ),
        ),
      );

      // Verify selected item has selected=true (estado comunicado via propiedad)
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.selected ?? false) &&
            widget.properties.label == 'Home',
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSBottomNav badge count is in semantic label',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSBottomNav(
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              DSBottomNavItem(icon: Icons.home, label: 'Home'),
              DSBottomNavItem(
                icon: Icons.shopping_cart,
                label: 'Cart',
                badgeCount: 5,
              ),
            ],
          ),
        ),
      );

      // Verify badge count is in semantic label (formato: 'Label (count)')
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'Cart (5)',
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSBottomNav items use their label as semantic label',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          DSBottomNav(
            currentIndex: 0,
            onTap: (_) {},
            items: const [
              DSBottomNavItem(icon: Icons.home, label: 'Home'),
              DSBottomNavItem(icon: Icons.search, label: 'Search'),
              DSBottomNavItem(icon: Icons.person, label: 'Profile'),
            ],
          ),
        ),
      );

      // Verify each tab uses its label (sin strings hardcodeados de posición)
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'Home',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'Search',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'Profile',
        ),
        findsOneWidget,
      );
    });
  });

  group('Accessibility - DSProductCard Semantics', () {
    testWidgets('DSProductCard image has Semantics with image property',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 200,
            height: 300,
            child: DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Test Product',
              price: 29.99,
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify image Semantics exists with product title
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.image ?? false) &&
            widget.properties.label != null &&
            widget.properties.label!.contains('Test Product'),
      );
      expect(semanticsFinder, findsOneWidget);
    });

    testWidgets('DSProductCard uses custom imageSemanticLabel when provided',
        (tester) async {
      const customLabel = 'Beautiful red sneakers';
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 200,
            height: 300,
            child: DSProductCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Test Product',
              price: 29.99,
              imageSemanticLabel: customLabel,
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify custom semantic label is used
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            (widget.properties.image ?? false) &&
            widget.properties.label == customLabel,
      );
      expect(semanticsFinder, findsOneWidget);
    });
  });
}
