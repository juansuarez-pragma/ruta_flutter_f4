import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

/// Modelo para las capacidades de un componente.
class ComponentCapability {
  final String name;
  final String category;
  final String flutterBase;
  final bool hasInteractiveStates;
  final bool hasAccessibility;
  final bool hasThemeSupport;
  final bool hasLoading;
  final int sizeVariants;
  final int customVariants;

  const ComponentCapability({
    required this.name,
    required this.category,
    required this.flutterBase,
    this.hasInteractiveStates = false,
    this.hasAccessibility = false,
    this.hasThemeSupport = true,
    this.hasLoading = false,
    this.sizeVariants = 0,
    this.customVariants = 0,
  });
}

/// Tabla de capacidades de todos los componentes del DS.
class CapabilityTable extends StatelessWidget {
  /// Lista de componentes con sus capacidades.
  final List<ComponentCapability> components;

  const CapabilityTable({
    super.key,
    required this.components,
  });

  /// Datos predefinidos de todos los componentes del DS.
  static const List<ComponentCapability> allComponents = [
    // Átomos
    ComponentCapability(
      name: 'DSButton',
      category: 'Átomo',
      flutterBase: 'ElevatedButton / OutlinedButton / TextButton',
      hasInteractiveStates: true,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: true,
      sizeVariants: 3,
      customVariants: 4,
    ),
    ComponentCapability(
      name: 'DSIconButton',
      category: 'Átomo',
      flutterBase: 'IconButton',
      hasInteractiveStates: true,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: true,
      sizeVariants: 3,
      customVariants: 4,
    ),
    ComponentCapability(
      name: 'DSBadge',
      category: 'Átomo',
      flutterBase: 'Badge (M3)',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 3,
      customVariants: 5,
    ),
    ComponentCapability(
      name: 'DSTextField',
      category: 'Átomo',
      flutterBase: 'TextField',
      hasInteractiveStates: true,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSCircularLoader',
      category: 'Átomo',
      flutterBase: 'CircularProgressIndicator',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 4,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSSkeleton',
      category: 'Átomo',
      flutterBase: 'No existe',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 4,
    ),
    ComponentCapability(
      name: 'DSText',
      category: 'Átomo',
      flutterBase: 'Text',
      hasInteractiveStates: false,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 17,
      customVariants: 0,
    ),
    // Moléculas
    ComponentCapability(
      name: 'DSCard',
      category: 'Molécula',
      flutterBase: 'Card',
      hasInteractiveStates: true,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 5,
    ),
    ComponentCapability(
      name: 'DSProductCard',
      category: 'Molécula',
      flutterBase: 'No existe',
      hasInteractiveStates: true,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: true,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSFilterChip',
      category: 'Molécula',
      flutterBase: 'FilterChip',
      hasInteractiveStates: true,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSEmptyState',
      category: 'Molécula',
      flutterBase: 'No existe',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSErrorState',
      category: 'Molécula',
      flutterBase: 'No existe',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSLoadingState',
      category: 'Molécula',
      flutterBase: 'No existe',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 4,
      customVariants: 0,
    ),
    // Organismos
    ComponentCapability(
      name: 'DSAppBar',
      category: 'Organismo',
      flutterBase: 'AppBar',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSProductGrid',
      category: 'Organismo',
      flutterBase: 'GridView',
      hasInteractiveStates: false,
      hasAccessibility: false,
      hasThemeSupport: true,
      hasLoading: true,
      sizeVariants: 0,
      customVariants: 0,
    ),
    ComponentCapability(
      name: 'DSBottomNav',
      category: 'Organismo',
      flutterBase: 'NavigationBar',
      hasInteractiveStates: true,
      hasAccessibility: true,
      hasThemeSupport: true,
      hasLoading: false,
      sizeVariants: 0,
      customVariants: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tokens = FakeStoreTheme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color: tokens.colorSurfacePrimary,
          borderRadius: BorderRadius.circular(DSBorderRadius.md),
          border: Border.all(
            color: tokens.colorBorderPrimary,
            width: DSSizes.borderThin,
          ),
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(tokens.colorSurfaceSecondary),
          dataRowColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return tokens.colorSurfaceSecondary.withValues(alpha: 0.5);
            }
            return null;
          }),
          columnSpacing: DSSpacing.lg,
          horizontalMargin: DSSpacing.md,
          columns: [
            _buildHeaderCell(tokens, 'Componente'),
            _buildHeaderCell(tokens, 'Categoría'),
            _buildHeaderCell(tokens, 'Base Flutter'),
            _buildHeaderCell(tokens, 'Estados'),
            _buildHeaderCell(tokens, 'A11y'),
            _buildHeaderCell(tokens, 'Temas'),
            _buildHeaderCell(tokens, 'Loading'),
            _buildHeaderCell(tokens, 'Variantes'),
          ],
          rows: components
              .map((c) => _buildDataRow(tokens, c))
              .toList(),
        ),
      ),
    );
  }

  DataColumn _buildHeaderCell(DSThemeData tokens, String label) {
    return DataColumn(
      label: Text(
        label,
        style: tokens.typographyLabelMedium.copyWith(
          color: tokens.colorTextPrimary,
          fontWeight: DSFontWeight.bold,
        ),
      ),
    );
  }

  DataRow _buildDataRow(DSThemeData tokens, ComponentCapability component) {
    return DataRow(
      cells: [
        // Nombre del componente
        DataCell(
          Text(
            component.name,
            style: tokens.typographyBodySmall.copyWith(
              color: tokens.colorBrandPrimary,
              fontWeight: DSFontWeight.medium,
            ),
          ),
        ),
        // Categoría
        DataCell(
          _buildCategoryBadge(tokens, component.category),
        ),
        // Base Flutter
        DataCell(
          Text(
            component.flutterBase,
            style: tokens.typographyCaption.copyWith(
              color: component.flutterBase == 'No existe'
                  ? tokens.colorTextTertiary
                  : tokens.colorTextSecondary,
              fontStyle: component.flutterBase == 'No existe'
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
        ),
        // Estados interactivos
        DataCell(_buildCheckIcon(tokens, component.hasInteractiveStates)),
        // Accesibilidad
        DataCell(_buildCheckIcon(tokens, component.hasAccessibility)),
        // Soporte de temas
        DataCell(_buildCheckIcon(tokens, component.hasThemeSupport)),
        // Loading
        DataCell(_buildCheckIcon(tokens, component.hasLoading)),
        // Variantes
        DataCell(
          Text(
            _formatVariants(component),
            style: tokens.typographyCaption.copyWith(
              color: tokens.colorTextSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(DSThemeData tokens, String category) {
    Color bgColor;
    Color textColor;

    switch (category) {
      case 'Átomo':
        bgColor = tokens.colorFeedbackSuccessLight;
        textColor = tokens.colorFeedbackSuccess;
        break;
      case 'Molécula':
        bgColor = tokens.colorFeedbackInfoLight;
        textColor = tokens.colorFeedbackInfo;
        break;
      case 'Organismo':
        bgColor = tokens.colorFeedbackWarningLight;
        textColor = tokens.colorFeedbackWarning;
        break;
      default:
        bgColor = tokens.colorSurfaceSecondary;
        textColor = tokens.colorTextSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.sm,
        vertical: DSSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DSBorderRadius.full),
      ),
      child: Text(
        category,
        style: tokens.typographyLabelSmall.copyWith(
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildCheckIcon(DSThemeData tokens, bool value) {
    return Icon(
      value ? Icons.check_circle : Icons.remove_circle_outline,
      size: DSSizes.iconSm,
      color: value ? tokens.colorFeedbackSuccess : tokens.colorTextTertiary,
    );
  }

  String _formatVariants(ComponentCapability component) {
    if (component.sizeVariants == 0 && component.customVariants == 0) {
      return '-';
    }
    if (component.sizeVariants > 0 && component.customVariants > 0) {
      return '${component.customVariants} × ${component.sizeVariants}';
    }
    if (component.sizeVariants > 0) {
      return '${component.sizeVariants} tamaños';
    }
    return '${component.customVariants} tipos';
  }
}
