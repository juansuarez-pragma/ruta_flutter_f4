import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget para mostrar código con botón de copiar.
class CodePreview extends StatefulWidget {
  final String code;
  final bool expanded;

  const CodePreview({
    super.key,
    required this.code,
    this.expanded = false,
  });

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  bool _isExpanded = false;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expanded;
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final isDark = context.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(DSBorderRadius.sm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.md,
              vertical: DSSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isDark ? DSColors.neutral800 : DSColors.neutral100,
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  size: DSSizes.iconSm,
                  color: tokens.colorTextSecondary,
                ),
                const SizedBox(width: DSSpacing.sm),
                Text(
                  'Ver código',
                  style: tokens.typographyLabelMedium.copyWith(
                    color: tokens.colorTextSecondary,
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: DSSizes.iconMd,
                  color: tokens.colorTextSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: DSSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DSSpacing.md),
            decoration: BoxDecoration(
              color: isDark ? DSColors.neutral900 : DSColors.neutral800,
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    widget.code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: DSFontSize.bodySmall,
                      color: DSColors.neutral100,
                      height: 1.5,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      _copied ? Icons.check : Icons.copy,
                      size: DSSizes.iconSm,
                      color: _copied
                          ? DSColors.success400
                          : DSColors.neutral400,
                    ),
                    tooltip: _copied ? 'Copiado' : 'Copiar código',
                    onPressed: _copyToClipboard,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
