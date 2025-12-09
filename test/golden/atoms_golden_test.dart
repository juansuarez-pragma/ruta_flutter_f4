import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'golden_test_helper.dart';

void main() {
  group('Atoms Golden Tests', () {
    group('DSButton', () {
      testWidgets('variants match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DSButton.primary(text: 'Primary', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.secondary(text: 'Secondary', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.ghost(text: 'Ghost', onPressed: () {}),
                const SizedBox(height: 8),
                DSButton.danger(text: 'Danger', onPressed: () {}),
              ],
            ),
            size: const Size(300, 250),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_button_variants.png'),
        );
      });

      testWidgets('sizes match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DSButton(
                  text: 'Small',
                  size: DSButtonSize.small,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                DSButton(
                  text: 'Medium',
                  size: DSButtonSize.medium,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                DSButton(
                  text: 'Large',
                  size: DSButtonSize.large,
                  onPressed: () {},
                ),
              ],
            ),
            size: const Size(300, 200),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_button_sizes.png'),
        );
      });

      testWidgets('disabled states match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const DSButton.primary(text: 'Primary Disabled'),
                const SizedBox(height: 8),
                const DSButton.secondary(text: 'Secondary Disabled'),
                const SizedBox(height: 8),
                const DSButton.danger(text: 'Danger Disabled'),
              ],
            ),
            size: const Size(300, 200),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_button_disabled.png'),
        );
      });
    });

    group('DSIconButton', () {
      testWidgets('variants match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DSIconButton(
                  icon: Icons.favorite,
                  variant: DSButtonVariant.primary,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                DSIconButton(
                  icon: Icons.favorite,
                  variant: DSButtonVariant.secondary,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                DSIconButton(
                  icon: Icons.favorite,
                  variant: DSButtonVariant.ghost,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                DSIconButton(
                  icon: Icons.favorite,
                  variant: DSButtonVariant.danger,
                  onPressed: () {},
                ),
              ],
            ),
            size: const Size(300, 100),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_icon_button_variants.png'),
        );
      });
    });

    group('DSBadge', () {
      testWidgets('types match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                DSBadge.success(text: 'Success'),
                DSBadge.error(text: 'Error'),
                DSBadge.warning(text: 'Warning'),
                DSBadge.info(text: 'Info'),
                DSBadge.neutral(text: 'Neutral'),
              ],
            ),
            size: const Size(350, 100),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_badge_types.png'),
        );
      });

      testWidgets('sizes match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DSBadge(text: 'Small', size: DSBadgeSize.small),
                SizedBox(height: 8),
                DSBadge(text: 'Medium', size: DSBadgeSize.medium),
                SizedBox(height: 8),
                DSBadge(text: 'Large', size: DSBadgeSize.large),
              ],
            ),
            size: const Size(200, 150),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_badge_sizes.png'),
        );
      });
    });

    group('DSText', () {
      testWidgets('variants match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                DSText.headingMedium('Heading Medium'),
                SizedBox(height: 4),
                DSText.bodyMedium('Body Medium'),
                SizedBox(height: 4),
                DSText.caption('Caption text'),
              ],
            ),
            size: const Size(300, 150),
          ),
        );

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_text_variants.png'),
        );
      });
    });

    group('DSCircularLoader', () {
      testWidgets('sizes match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DSCircularLoader(size: DSLoaderSize.small),
                SizedBox(width: 16),
                DSCircularLoader(size: DSLoaderSize.medium),
                SizedBox(width: 16),
                DSCircularLoader(size: DSLoaderSize.large),
              ],
            ),
            size: const Size(250, 100),
          ),
        );

        // Need to pump to show animation frame
        await tester.pump();

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_circular_loader_sizes.png'),
        );
      });
    });

    group('DSSkeleton', () {
      testWidgets('shapes match golden', (tester) async {
        await tester.pumpWidget(
          buildGoldenTestWidget(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DSSkeleton(width: 200, height: 20),
                const SizedBox(height: 8),
                const DSSkeleton.circular(size: 50),
                const SizedBox(height: 8),
                const DSSkeleton.text(width: 200),
                const SizedBox(height: 8),
                const DSSkeleton.title(width: 200),
              ],
            ),
            size: const Size(300, 200),
          ),
        );

        // Need to pump to show animation frame
        await tester.pump();

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/ds_skeleton_shapes.png'),
        );
      });
    });
  });
}
