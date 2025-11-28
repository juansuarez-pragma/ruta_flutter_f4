import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

/// Título de sección para el showcase.
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: const EdgeInsets.only(
        top: DSSpacing.xl,
        bottom: DSSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tokens.typographyHeadingMedium.copyWith(
              color: tokens.colorTextPrimary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: DSSpacing.xs),
            Text(
              subtitle!,
              style: tokens.typographyBodyMedium.copyWith(
                color: tokens.colorTextSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
