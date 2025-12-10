import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';

import 'package:fake_store_design_system_example/features/atoms/atoms_page.dart';
import 'package:fake_store_design_system_example/features/estado_del_arte/estado_del_arte_page.dart';
import 'package:fake_store_design_system_example/features/molecules/molecules_page.dart';
import 'package:fake_store_design_system_example/features/organisms/organisms_page.dart';
import 'package:fake_store_design_system_example/features/tokens/tokens_page.dart';

/// Aplicación de showcase del sistema de diseño.
class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Store Design System',
      debugShowCheckedModeBanner: false,
      theme: FakeStoreTheme.light(),
      darkTheme: FakeStoreTheme.dark(),
      themeMode: _themeMode,
      home: _ShowcaseHome(themeMode: _themeMode, onToggleTheme: _toggleTheme),
    );
  }
}

class _ShowcaseHome extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const _ShowcaseHome({required this.themeMode, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: tokens.colorSurfacePrimary,
        appBar: AppBar(
          backgroundColor: tokens.colorSurfacePrimary,
          elevation: 0,
          title: Row(
            children: [
              Icon(Icons.palette_outlined, color: tokens.colorBrandPrimary),
              const SizedBox(width: DSSpacing.sm),
              Text(
                'Design System',
                style: tokens.typographyTitleLarge.copyWith(
                  color: tokens.colorTextPrimary,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeMode == ThemeMode.light
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: tokens.colorIconPrimary,
              ),
              tooltip: themeMode == ThemeMode.light
                  ? 'Cambiar a tema oscuro'
                  : 'Cambiar a tema claro',
              onPressed: onToggleTheme,
            ),
            const SizedBox(width: DSSpacing.sm),
          ],
          bottom: TabBar(
            labelColor: tokens.colorBrandPrimary,
            unselectedLabelColor: tokens.colorTextSecondary,
            indicatorColor: tokens.colorBrandPrimary,
            labelStyle: tokens.typographyLabelLarge,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'Tokens'),
              Tab(text: 'Átomos'),
              Tab(text: 'Moléculas'),
              Tab(text: 'Organismos'),
              Tab(text: 'Estado del Arte'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TokensPage(),
            AtomsPage(),
            MoleculesPage(),
            OrganismsPage(),
            EstadoDelArtePage(),
          ],
        ),
      ),
    );
  }
}
