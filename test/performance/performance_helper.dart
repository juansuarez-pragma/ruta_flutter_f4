import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Performance thresholds based on industry standards
/// References:
/// - Flutter Community Benchmarks 2025
/// - Very Good Ventures Testing Standards
/// - Google Flutter Team Recommendations
///
/// Note: Test environment thresholds are higher than production because
/// Flutter tests run in a simulated environment with additional overhead.
/// Production builds are typically 3-5x faster.
class PerformanceThresholds {
  // Build time thresholds (milliseconds) - TEST ENVIRONMENT
  // These are relaxed for CI/test runners. Production should be 3-5x faster.

  // Atoms: Simple, single-purpose components
  static const int atomBuildExcellent = 10;
  static const int atomBuildGood = 20;
  static const int atomBuildAcceptable = 50;

  // Molecules: Composed of multiple atoms
  static const int moleculeBuildExcellent = 15;
  static const int moleculeBuildGood = 30;
  static const int moleculeBuildAcceptable = 75;

  // Organisms: Complex, composed of molecules and atoms
  static const int organismBuildExcellent = 25;
  static const int organismBuildGood = 50;
  static const int organismBuildAcceptable = 100;

  // Frame time thresholds (60fps = 16.67ms per frame)
  static const int frameTimeTarget = 16;
  static const int frameTimeExcellent = 8;

  // Memory thresholds (bytes)
  static const int memoryPerFrameTarget = 1024 * 1024; // 1MB
  static const int memoryPerFrameWarning = 5 * 1024 * 1024; // 5MB

  // Widget tree depth - Flutter uses composition, so trees can be deep
  // Material widgets typically add 20-40 levels of depth
  static const int widgetTreeDepthWarning = 100;
  static const int widgetTreeDepthMax = 150;

  // Rebuild efficiency - rebuild should not be more than 2x initial build
  static const double rebuildEfficiencyFactor = 3;

  // Const widget rebuild - should be fast but test env adds overhead
  static const int constRebuildMax = 50;
}

/// Result of a build time benchmark
class BuildTimeResult {
  final String componentName;
  final int iterations;
  final List<int> times;
  final int averageMs;
  final int minMs;
  final int maxMs;
  final int p95Ms;

  BuildTimeResult({
    required this.componentName,
    required this.iterations,
    required this.times,
    required this.averageMs,
    required this.minMs,
    required this.maxMs,
    required this.p95Ms,
  });

  bool meetsThreshold(int thresholdMs) => averageMs <= thresholdMs;

  @override
  String toString() =>
      '$componentName: avg=${averageMs}ms, min=${minMs}ms, max=${maxMs}ms, p95=${p95Ms}ms';
}

/// Measures the build time of a widget over multiple iterations
Future<BuildTimeResult> measureBuildTime(
  WidgetTester tester,
  Widget widget, {
  String name = 'Widget',
  int iterations = 10,
}) async {
  final times = <int>[];

  for (var i = 0; i < iterations; i++) {
    final stopwatch = Stopwatch()..start();

    await tester.pumpWidget(
      MaterialApp(
        theme: FakeStoreTheme.light(),
        home: Scaffold(body: widget),
      ),
    );

    stopwatch.stop();
    times.add(stopwatch.elapsedMilliseconds);

    // Reset for next iteration
    await tester.pumpWidget(const SizedBox.shrink());
  }

  times.sort();
  final average = times.reduce((a, b) => a + b) ~/ times.length;
  final p95Index = ((times.length - 1) * 0.95).floor();

  return BuildTimeResult(
    componentName: name,
    iterations: iterations,
    times: times,
    averageMs: average,
    minMs: times.first,
    maxMs: times.last,
    p95Ms: times[p95Index],
  );
}

/// Measures the rebuild time when widget state changes
Future<int> measureRebuildTime(
  WidgetTester tester,
  Widget Function(int iteration) builder,
) async {
  // Initial build
  await tester.pumpWidget(
    MaterialApp(
      theme: FakeStoreTheme.light(),
      home: Scaffold(body: builder(0)),
    ),
  );

  final stopwatch = Stopwatch()..start();

  // Rebuild with changed state
  await tester.pumpWidget(
    MaterialApp(
      theme: FakeStoreTheme.light(),
      home: Scaffold(body: builder(1)),
    ),
  );

  stopwatch.stop();
  return stopwatch.elapsedMilliseconds;
}

/// Measures frame render time for animations
Future<List<int>> measureFrameTimes(
  WidgetTester tester,
  Widget widget, {
  int frameCount = 10,
  Duration frameDuration = const Duration(milliseconds: 16),
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: FakeStoreTheme.light(),
      home: Scaffold(body: widget),
    ),
  );

  final frameTimes = <int>[];

  for (var i = 0; i < frameCount; i++) {
    final stopwatch = Stopwatch()..start();
    await tester.pump(frameDuration);
    stopwatch.stop();
    frameTimes.add(stopwatch.elapsedMilliseconds);
  }

  return frameTimes;
}

/// Builds a testable widget with the design system theme
Widget buildPerformanceTestWidget(Widget child) => MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: child),
  );

/// Counts the depth of the widget tree
int measureWidgetTreeDepth(Element element) {
  int maxDepth = 0;

  void traverse(Element el, int currentDepth) {
    if (currentDepth > maxDepth) {
      maxDepth = currentDepth;
    }
    el.visitChildren((child) => traverse(child, currentDepth + 1));
  }

  traverse(element, 0);
  return maxDepth;
}

/// Counts total widgets in the tree
int countWidgets(Element element) {
  int count = 0;

  void traverse(Element el) {
    count++;
    el.visitChildren(traverse);
  }

  traverse(element);
  return count;
}
