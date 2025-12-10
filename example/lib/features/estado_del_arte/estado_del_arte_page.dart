import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'sections/sections.dart';

/// Página de Estado del Arte del Design System.
///
/// Muestra una comparativa visual entre los componentes Flutter nativos
/// y los componentes del Design System, con playgrounds interactivos
/// y tabla de capacidades.
class EstadoDelArtePage extends StatelessWidget {
  const EstadoDelArtePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(DSSpacing.lg),
      children: const [
        // Resumen con métricas
        SummarySection(),

        // Comparativas de Átomos
        AtomsComparisonSection(),

        // Comparativas de Moléculas
        MoleculesComparisonSection(),

        // Comparativas de Organismos
        OrganismsComparisonSection(),

        // Tabla de capacidades
        CapabilitiesSection(),

        // Limitaciones
        LimitationsSection(),
      ],
    );
  }
}
