import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/core/widgets/widgets.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/widgets/widgets.dart';

/// Sección con limitaciones globales del Design System.
class LimitationsSection extends StatelessWidget {
  const LimitationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Limitaciones del Sistema',
          subtitle:
              'Áreas de mejora y funcionalidades no cubiertas actualmente',
        ),
        const SizedBox(height: DSSpacing.lg),
        _buildLimitationsGrid(),
        const SizedBox(height: DSSpacing.xxl),
      ],
    );
  }

  Widget _buildLimitationsGrid() {
    const limitations = [
      _LimitationData(
        category: 'Animaciones',
        description: 'Sin transiciones personalizadas entre estados de componentes',
        impact: 'UX básica',
        icon: Icons.animation,
      ),
      _LimitationData(
        category: 'Responsividad',
        description: 'No hay componentes breakpoint-aware que se adapten automáticamente',
        impact: 'Manual por proyecto',
        icon: Icons.devices,
      ),
      _LimitationData(
        category: 'Adaptabilidad',
        description: 'Sin NavigationRail para tablets o pantallas grandes',
        impact: 'Limitado a móviles',
        icon: Icons.tablet_android,
      ),
      _LimitationData(
        category: 'Formularios',
        description: 'Sin wrapper de TextFormField con validación integrada',
        impact: 'Validación manual',
        icon: Icons.checklist,
      ),
      _LimitationData(
        category: 'Rich Text',
        description: 'Sin soporte para RichText o TextSpan en DSText',
        impact: 'Solo texto plano',
        icon: Icons.format_color_text,
      ),
      _LimitationData(
        category: 'Imágenes',
        description: 'Sin manejo de caché de imágenes integrado',
        impact: 'Dependencia de network',
        icon: Icons.image,
      ),
      _LimitationData(
        category: 'Internacionalización',
        description: 'Strings hardcodeados en componentes (ej: "Reintentar")',
        impact: 'Requiere i18n manual',
        icon: Icons.translate,
      ),
      _LimitationData(
        category: 'Paginación',
        description: 'Sin scroll infinito o paginación integrada en grids',
        impact: 'Carga completa',
        icon: Icons.view_list,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 4 :
                               constraints.maxWidth > 500 ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: crossAxisCount > 2 ? 1.3 : 2.0,
            crossAxisSpacing: DSSpacing.md,
            mainAxisSpacing: DSSpacing.md,
          ),
          itemCount: limitations.length,
          itemBuilder: (context, index) {
            final limitation = limitations[index];
            return LimitationCard(
              category: limitation.category,
              description: limitation.description,
              impact: limitation.impact,
              icon: limitation.icon,
            );
          },
        );
      },
    );
  }
}

class _LimitationData {
  final String category;
  final String description;
  final String impact;
  final IconData icon;

  const _LimitationData({
    required this.category,
    required this.description,
    required this.impact,
    required this.icon,
  });
}
