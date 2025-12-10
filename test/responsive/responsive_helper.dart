import 'package:fake_store_design_system/fake_store_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// Standard breakpoints based on Material Design 3 guidelines
/// Reference: https://m3.material.io/foundations/layout/applying-layout
class ResponsiveBreakpoints {
  // Compact (phones in portrait)
  static const Size compactPhone = Size(360, 640);
  static const Size compactPhoneLarge = Size(400, 800);

  // Medium (tablets in portrait, foldables)
  static const Size mediumTablet = Size(600, 960);
  static const Size mediumTabletLarge = Size(720, 1024);

  // Expanded (tablets in landscape, small desktops)
  static const Size expandedTablet = Size(840, 600);
  static const Size expandedDesktop = Size(1024, 768);

  // Large (desktops)
  static const Size largeDesktop = Size(1280, 800);
  static const Size largeDesktopWide = Size(1440, 900);

  // Extra large (large desktops, TVs)
  static const Size extraLarge = Size(1920, 1080);

  // Common device sizes for testing
  static const Size iPhone8 = Size(375, 667);
  static const Size iPhoneSE = Size(320, 568);
  static const Size iPhone14Pro = Size(393, 852);
  static const Size iPhone14ProMax = Size(430, 932);
  static const Size iPadMini = Size(744, 1133);
  static const Size iPadPro11 = Size(834, 1194);
  static const Size iPadPro12 = Size(1024, 1366);

  // Android common sizes
  static const Size pixelPhone = Size(412, 915);
  static const Size galaxyS21 = Size(360, 800);
  static const Size galaxyTab = Size(800, 1280);

  /// All breakpoints for comprehensive testing
  static List<Size> get allBreakpoints => [
        compactPhone,
        compactPhoneLarge,
        mediumTablet,
        mediumTabletLarge,
        expandedTablet,
        expandedDesktop,
        largeDesktop,
        extraLarge,
      ];

  /// Mobile-only breakpoints
  static List<Size> get mobileBreakpoints => [
        iPhoneSE,
        iPhone8,
        iPhone14Pro,
        iPhone14ProMax,
        pixelPhone,
        galaxyS21,
      ];

  /// Tablet breakpoints
  static List<Size> get tabletBreakpoints => [
        iPadMini,
        iPadPro11,
        iPadPro12,
        galaxyTab,
      ];
}

/// Text scale factors for accessibility testing
/// Reference: WCAG 2.1 guidelines
class TextScaleFactors {
  static const double normal = 1;
  static const double large = 1.3;
  static const double extraLarge = 1.5;
  static const double huge = 2;

  /// iOS accessibility text sizes mapping
  static const double accessibilityMedium = 1.12;
  static const double accessibilityLarge = 1.24;
  static const double accessibilityExtraLarge = 1.35;

  /// All scale factors for testing
  static List<double> get allScales => [
        normal,
        large,
        extraLarge,
        huge,
      ];
}

/// Orientation configurations
enum TestOrientation {
  portrait,
  landscape,
}

/// Helper class for responsive testing
class ResponsiveTestConfig {
  final Size size;
  final String name;
  final TestOrientation orientation;
  final double textScaleFactor;
  final Brightness brightness;

  const ResponsiveTestConfig({
    required this.size,
    required this.name,
    this.orientation = TestOrientation.portrait,
    this.textScaleFactor = 1.0,
    this.brightness = Brightness.light,
  });

  /// Returns the effective size considering orientation
  Size get effectiveSize {
    if (orientation == TestOrientation.landscape) {
      return Size(size.height, size.width);
    }
    return size;
  }

  @override
  String toString() =>
      '$name (${effectiveSize.width.toInt()}x${effectiveSize.height.toInt()})';
}

/// Pre-configured test scenarios
class ResponsiveTestScenarios {
  static List<ResponsiveTestConfig> get phones => [
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhoneSE,
          name: 'iPhone SE',
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhone14Pro,
          name: 'iPhone 14 Pro',
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.pixelPhone,
          name: 'Pixel Phone',
        ),
      ];

  static List<ResponsiveTestConfig> get tablets => [
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPadMini,
          name: 'iPad Mini',
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPadPro11,
          name: 'iPad Pro 11',
        ),
      ];

  static List<ResponsiveTestConfig> get desktops => [
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.expandedDesktop,
          name: 'Desktop',
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.largeDesktop,
          name: 'Large Desktop',
        ),
      ];

  static List<ResponsiveTestConfig> get allDevices => [
        ...phones,
        ...tablets,
        ...desktops,
      ];

  static List<ResponsiveTestConfig> get accessibilityScales => [
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhone14Pro,
          name: 'Normal (1.0x)',
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhone14Pro,
          name: 'Large (1.3x)',
          textScaleFactor: TextScaleFactors.large,
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhone14Pro,
          name: 'Extra Large (1.5x)',
          textScaleFactor: TextScaleFactors.extraLarge,
        ),
        const ResponsiveTestConfig(
          size: ResponsiveBreakpoints.iPhone14Pro,
          name: 'Huge (2.0x)',
          textScaleFactor: TextScaleFactors.huge,
        ),
      ];
}

/// Sets up the test environment with specific viewport size
Future<void> setViewportSize(WidgetTester tester, Size size) async {
  await tester.binding.setSurfaceSize(size);
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
}

/// Resets the viewport to default size
Future<void> resetViewportSize(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(null);
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

/// Builds a widget with responsive configuration
Widget buildResponsiveTestWidget(
  Widget child, {
  Size? size,
  double textScaleFactor = 1.0,
  Brightness brightness = Brightness.light,
}) => MaterialApp(
    theme: brightness == Brightness.light
        ? FakeStoreTheme.light()
        : FakeStoreTheme.dark(),
    builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScaleFactor),
        ),
        child: widget!,
      ),
    home: Scaffold(body: child),
  );

/// Pumps a widget with specific viewport configuration
Future<void> pumpResponsiveWidget(
  WidgetTester tester,
  Widget widget, {
  required ResponsiveTestConfig config,
}) async {
  await setViewportSize(tester, config.effectiveSize);

  await tester.pumpWidget(
    buildResponsiveTestWidget(
      widget,
      size: config.effectiveSize,
      textScaleFactor: config.textScaleFactor,
      brightness: config.brightness,
    ),
  );
}

/// Tests a widget at multiple breakpoints
Future<void> testAtBreakpoints(
  WidgetTester tester,
  Widget widget, {
  required List<ResponsiveTestConfig> configs,
  required Future<void> Function(ResponsiveTestConfig config) verify,
}) async {
  for (final config in configs) {
    await pumpResponsiveWidget(tester, widget, config: config);
    await verify(config);
  }
}

/// Measures the rendered size of a widget
Size? getWidgetSize(WidgetTester tester, Finder finder) {
  final element = tester.element(finder);
  final renderBox = element.renderObject as RenderBox?;
  return renderBox?.size;
}

/// Checks if a widget fits within the viewport
bool widgetFitsInViewport(WidgetTester tester, Finder finder, Size viewport) {
  final size = getWidgetSize(tester, finder);
  if (size == null) return false;
  return size.width <= viewport.width && size.height <= viewport.height;
}

/// Checks if text is not clipped (has sufficient space)
bool textIsVisible(WidgetTester tester, String text) {
  final finder = find.text(text);
  return finder.evaluate().isNotEmpty;
}

/// Gets the number of lines a text widget uses
int getTextLines(WidgetTester tester, Finder finder) {
  final text = tester.widget<Text>(finder);
  final renderParagraph =
      tester.renderObject<RenderParagraph>(finder);
  final textSpan = renderParagraph.text as TextSpan;
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
    maxLines: text.maxLines,
  );
  textPainter.layout(maxWidth: renderParagraph.constraints.maxWidth);
  return textPainter.computeLineMetrics().length;
}

/// Verifies minimum touch target size (48x48 per WCAG)
bool meetsTouchTargetSize(WidgetTester tester, Finder finder) {
  const minSize = 48.0;
  final size = getWidgetSize(tester, finder);
  if (size == null) return false;
  return size.width >= minSize && size.height >= minSize;
}

/// Extension for easier responsive testing
extension ResponsiveWidgetTester on WidgetTester {
  /// Sets viewport to phone size
  Future<void> setPhoneSize() async {
    await setViewportSize(this, ResponsiveBreakpoints.iPhone14Pro);
  }

  /// Sets viewport to tablet size
  Future<void> setTabletSize() async {
    await setViewportSize(this, ResponsiveBreakpoints.iPadPro11);
  }

  /// Sets viewport to desktop size
  Future<void> setDesktopSize() async {
    await setViewportSize(this, ResponsiveBreakpoints.largeDesktop);
  }

  /// Sets viewport to a specific size
  Future<void> setSize(Size size) async {
    await setViewportSize(this, size);
  }

  /// Resets viewport to default
  Future<void> resetSize() async {
    await resetViewportSize(this);
  }
}
