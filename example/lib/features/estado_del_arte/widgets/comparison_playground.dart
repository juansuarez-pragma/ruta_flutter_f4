import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget interactivo que muestra Flutter nativo vs DS lado a lado.
///
/// Permite cambiar variantes, tamaños y estados para comparar comportamientos.
class ComparisonPlayground extends StatefulWidget {
  /// Título de la comparación (ej: "Botones").
  final String title;

  /// Subtítulo descriptivo (ej: "ElevatedButton vs DSButton").
  final String subtitle;

  /// Builder para el widget Flutter nativo.
  final Widget Function(PlaygroundState state) flutterBuilder;

  /// Builder para el código Flutter nativo.
  final String Function(PlaygroundState state) flutterCodeBuilder;

  /// Builder para el widget del Design System.
  final Widget Function(PlaygroundState state) dsBuilder;

  /// Builder para el código del Design System.
  final String Function(PlaygroundState state) dsCodeBuilder;

  /// Lista de variantes disponibles.
  final List<String>? variants;

  /// Lista de tamaños disponibles.
  final List<String>? sizes;

  /// Si muestra toggle de loading.
  final bool hasLoadingToggle;

  /// Si muestra toggle de disabled.
  final bool hasDisabledToggle;

  /// Lista de ventajas del componente DS.
  final List<String> advantages;

  /// Lista de limitaciones del componente DS.
  final List<String> limitations;

  /// Mensaje cuando Flutter no tiene equivalente.
  final String? noFlutterEquivalent;

  const ComparisonPlayground({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flutterBuilder,
    required this.flutterCodeBuilder,
    required this.dsBuilder,
    required this.dsCodeBuilder,
    this.variants,
    this.sizes,
    this.hasLoadingToggle = false,
    this.hasDisabledToggle = true,
    this.advantages = const [],
    this.limitations = const [],
    this.noFlutterEquivalent,
  });

  @override
  State<ComparisonPlayground> createState() => _ComparisonPlaygroundState();
}

class _ComparisonPlaygroundState extends State<ComparisonPlayground> {
  late String _selectedVariant;
  late String _selectedSize;
  bool _isLoading = false;
  bool _isDisabled = false;
  bool _showFlutterCode = false;
  bool _showDsCode = false;

  @override
  void initState() {
    super.initState();
    _selectedVariant = widget.variants?.first ?? 'default';
    _selectedSize = widget.sizes?.first ?? 'medium';
  }

  PlaygroundState get _currentState => PlaygroundState(
        variant: _selectedVariant,
        size: _selectedSize,
        isLoading: _isLoading,
        isDisabled: _isDisabled,
      );

  @override
  Widget build(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: DSSpacing.xl),
      decoration: BoxDecoration(
        color: tokens.colorSurfacePrimary,
        borderRadius: BorderRadius.circular(DSBorderRadius.lg),
        border: Border.all(
          color: tokens.colorBorderPrimary,
          width: DSSizes.borderThin,
        ),
        boxShadow: tokens.elevationLevel1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(tokens),
          if (_hasControls) _buildControls(tokens),
          _buildComparison(tokens),
          if (widget.advantages.isNotEmpty || widget.limitations.isNotEmpty)
            _buildInfoSection(tokens),
        ],
      ),
    );
  }

  bool get _hasControls =>
      widget.variants != null ||
      widget.sizes != null ||
      widget.hasLoadingToggle ||
      widget.hasDisabledToggle;

  Widget _buildHeader(DSThemeData tokens) {
    return Container(
      padding: const EdgeInsets.all(DSSpacing.md),
      decoration: BoxDecoration(
        color: tokens.colorSurfaceSecondary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DSBorderRadius.lg),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.compare_arrows,
            color: tokens.colorBrandPrimary,
            size: DSSizes.iconMd,
          ),
          const SizedBox(width: DSSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: tokens.typographyTitleMedium.copyWith(
                    color: tokens.colorTextPrimary,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: tokens.typographyBodySmall.copyWith(
                    color: tokens.colorTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(DSThemeData tokens) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.md,
        vertical: DSSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: tokens.colorBorderSecondary,
            width: DSSizes.borderThin,
          ),
        ),
      ),
      child: Wrap(
        spacing: DSSpacing.md,
        runSpacing: DSSpacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (widget.variants != null && widget.variants!.length > 1)
            _buildDropdown(
              tokens: tokens,
              label: 'Variante',
              value: _selectedVariant,
              items: widget.variants!,
              onChanged: (value) => setState(() => _selectedVariant = value!),
            ),
          if (widget.sizes != null && widget.sizes!.length > 1)
            _buildDropdown(
              tokens: tokens,
              label: 'Tamaño',
              value: _selectedSize,
              items: widget.sizes!,
              onChanged: (value) => setState(() => _selectedSize = value!),
            ),
          if (widget.hasLoadingToggle)
            _buildToggle(
              tokens: tokens,
              label: 'Loading',
              value: _isLoading,
              onChanged: (value) => setState(() => _isLoading = value),
            ),
          if (widget.hasDisabledToggle)
            _buildToggle(
              tokens: tokens,
              label: 'Disabled',
              value: _isDisabled,
              onChanged: (value) => setState(() => _isDisabled = value),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required DSThemeData tokens,
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label:',
          style: tokens.typographyLabelSmall.copyWith(
            color: tokens.colorTextSecondary,
          ),
        ),
        const SizedBox(width: DSSpacing.xs),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.sm),
          decoration: BoxDecoration(
            color: tokens.colorSurfaceSecondary,
            borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            border: Border.all(
              color: tokens.colorBorderSecondary,
              width: DSSizes.borderThin,
            ),
          ),
          child: DropdownButton<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: tokens.typographyLabelMedium,
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            underline: const SizedBox(),
            isDense: true,
            dropdownColor: tokens.colorSurfacePrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildToggle({
    required DSThemeData tokens,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: tokens.colorBrandPrimary,
            side: BorderSide(color: tokens.colorBorderPrimary),
          ),
        ),
        const SizedBox(width: DSSpacing.xxs),
        Text(
          label,
          style: tokens.typographyLabelSmall.copyWith(
            color: tokens.colorTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildComparison(DSThemeData tokens) {
    return Padding(
      padding: const EdgeInsets.all(DSSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flutter Native Column
          Expanded(
            child: _buildColumn(
              tokens: tokens,
              label: 'FLUTTER NATIVO',
              labelColor: Colors.blue,
              child: widget.noFlutterEquivalent != null
                  ? _buildNoEquivalent(tokens)
                  : widget.flutterBuilder(_currentState),
              code: widget.flutterCodeBuilder(_currentState),
              showCode: _showFlutterCode,
              onToggleCode: () =>
                  setState(() => _showFlutterCode = !_showFlutterCode),
            ),
          ),
          const SizedBox(width: DSSpacing.md),
          // Design System Column
          Expanded(
            child: _buildColumn(
              tokens: tokens,
              label: 'DESIGN SYSTEM',
              labelColor: tokens.colorBrandPrimary,
              child: widget.dsBuilder(_currentState),
              code: widget.dsCodeBuilder(_currentState),
              showCode: _showDsCode,
              onToggleCode: () => setState(() => _showDsCode = !_showDsCode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoEquivalent(DSThemeData tokens) {
    return Container(
      padding: const EdgeInsets.all(DSSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.colorSurfaceSecondary,
        borderRadius: BorderRadius.circular(DSBorderRadius.md),
        border: Border.all(
          color: tokens.colorBorderSecondary,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.not_interested,
            size: DSSizes.iconXl,
            color: tokens.colorTextTertiary,
          ),
          const SizedBox(height: DSSpacing.sm),
          Text(
            'No existe equivalente',
            style: tokens.typographyLabelMedium.copyWith(
              color: tokens.colorTextTertiary,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.noFlutterEquivalent != null) ...[
            const SizedBox(height: DSSpacing.xs),
            Text(
              widget.noFlutterEquivalent!,
              style: tokens.typographyCaption.copyWith(
                color: tokens.colorTextTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildColumn({
    required DSThemeData tokens,
    required String label,
    required Color labelColor,
    required Widget child,
    required String code,
    required bool showCode,
    required VoidCallback onToggleCode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Label
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DSSpacing.sm,
            vertical: DSSpacing.xxs,
          ),
          decoration: BoxDecoration(
            color: labelColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DSBorderRadius.xs),
          ),
          child: Text(
            label,
            style: tokens.typographyLabelSmall.copyWith(
              color: labelColor,
              fontWeight: DSFontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: DSSpacing.md),
        // Widget Preview
        Container(
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(DSSpacing.md),
          decoration: BoxDecoration(
            color: tokens.colorSurfaceSecondary,
            borderRadius: BorderRadius.circular(DSBorderRadius.md),
          ),
          child: Center(child: child),
        ),
        const SizedBox(height: DSSpacing.sm),
        // Code Toggle
        _buildCodeSection(
          tokens: tokens,
          code: code,
          showCode: showCode,
          onToggle: onToggleCode,
        ),
      ],
    );
  }

  Widget _buildCodeSection({
    required DSThemeData tokens,
    required String code,
    required bool showCode,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(DSBorderRadius.sm),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.sm,
              vertical: DSSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: tokens.colorSurfaceTertiary,
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  showCode ? Icons.code_off : Icons.code,
                  size: DSSizes.iconSm,
                  color: tokens.colorTextSecondary,
                ),
                const SizedBox(width: DSSpacing.xs),
                Text(
                  showCode ? 'Ocultar código' : 'Ver código',
                  style: tokens.typographyLabelSmall.copyWith(
                    color: tokens.colorTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showCode) ...[
          const SizedBox(height: DSSpacing.sm),
          Container(
            padding: const EdgeInsets.all(DSSpacing.sm),
            decoration: BoxDecoration(
              color: tokens.colorSurfaceTertiary,
              borderRadius: BorderRadius.circular(DSBorderRadius.sm),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    code,
                    style: tokens.typographyCaption.copyWith(
                      fontFamily: 'monospace',
                      color: tokens.colorTextPrimary,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.copy,
                      size: DSSizes.iconSm,
                      color: tokens.colorIconSecondary,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Código copiado'),
                          duration: const Duration(seconds: 1),
                          backgroundColor: tokens.colorFeedbackSuccess,
                        ),
                      );
                    },
                    tooltip: 'Copiar código',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoSection(DSThemeData tokens) {
    return Container(
      padding: const EdgeInsets.all(DSSpacing.md),
      decoration: BoxDecoration(
        color: tokens.colorSurfaceSecondary,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(DSBorderRadius.lg),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.advantages.isNotEmpty) ...[
            _buildInfoRow(
              tokens: tokens,
              icon: Icons.check_circle,
              iconColor: tokens.colorFeedbackSuccess,
              label: 'Ventajas DS',
              items: widget.advantages,
            ),
          ],
          if (widget.advantages.isNotEmpty && widget.limitations.isNotEmpty)
            const SizedBox(height: DSSpacing.sm),
          if (widget.limitations.isNotEmpty) ...[
            _buildInfoRow(
              tokens: tokens,
              icon: Icons.warning_amber,
              iconColor: tokens.colorFeedbackWarning,
              label: 'Limitaciones',
              items: widget.limitations,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required DSThemeData tokens,
    required IconData icon,
    required Color iconColor,
    required String label,
    required List<String> items,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: DSSizes.iconSm, color: iconColor),
        const SizedBox(width: DSSpacing.xs),
        Expanded(
          child: Wrap(
            spacing: DSSpacing.xs,
            runSpacing: DSSpacing.xxs,
            children: items
                .map((item) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DSSpacing.sm,
                        vertical: DSSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(DSBorderRadius.full),
                      ),
                      child: Text(
                        item,
                        style: tokens.typographyCaption.copyWith(
                          color: iconColor,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

/// Estado actual del playground.
class PlaygroundState {
  final String variant;
  final String size;
  final bool isLoading;
  final bool isDisabled;

  const PlaygroundState({
    required this.variant,
    required this.size,
    required this.isLoading,
    required this.isDisabled,
  });
}
