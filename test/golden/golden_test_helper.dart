import 'package:flutter/material.dart';
import 'package:fake_store_design_system/fake_store_design_system.dart';

/// Helper para crear widgets testeables con tamaño fijo para golden tests
Widget buildGoldenTestWidget(
  Widget child, {
  Size size = const Size(400, 300),
  Brightness brightness = Brightness.light,
}) {
  return MaterialApp(
    theme: brightness == Brightness.light
        ? FakeStoreTheme.light()
        : FakeStoreTheme.dark(),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: RepaintBoundary(
        child: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: child,
          ),
        ),
      ),
    ),
  );
}

/// Creates a grid of widgets for golden testing multiple variants
Widget buildGoldenGrid({
  required List<Widget> children,
  int crossAxisCount = 2,
  double spacing = 16,
}) {
  return Padding(
    padding: EdgeInsets.all(spacing),
    child: Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children,
    ),
  );
}
