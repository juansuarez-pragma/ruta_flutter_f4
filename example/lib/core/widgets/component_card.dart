import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/code_preview.dart';

/// Card wrapper para mostrar un componente con su código.
class ComponentCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;
  final String code;
  final bool codeExpanded;

  const ComponentCard({
    super.key,
    required this.title,
    this.description,
    required this.child,
    required this.code,
    this.codeExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      margin: const EdgeInsets.only(bottom: DSSpacing.lg),
      padding: const EdgeInsets.all(DSSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.colorSurfacePrimary,
        borderRadius: BorderRadius.circular(DSBorderRadius.base),
        border: Border.all(
          color: tokens.colorBorderSecondary,
          width: DSSizes.borderThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tokens.typographyTitleMedium.copyWith(
              color: tokens.colorTextPrimary,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: DSSpacing.xs),
            Text(
              description!,
              style: tokens.typographyBodySmall.copyWith(
                color: tokens.colorTextSecondary,
              ),
            ),
          ],
          const SizedBox(height: DSSpacing.lg),
          child,
          const SizedBox(height: DSSpacing.lg),
          CodePreview(code: code, expanded: codeExpanded),
        ],
      ),
    );
  }
}
