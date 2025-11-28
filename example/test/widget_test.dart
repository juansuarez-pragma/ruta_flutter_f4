import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system_example/app/showcase_app.dart';

void main() {
  testWidgets('ShowcaseApp renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ShowcaseApp());

    // Verify that the app title is displayed
    expect(find.text('Design System'), findsOneWidget);

    // Verify that the tabs are displayed
    expect(find.text('Tokens'), findsOneWidget);
    expect(find.text('Átomos'), findsOneWidget);
    expect(find.text('Moléculas'), findsOneWidget);
    expect(find.text('Organismos'), findsOneWidget);
  });
}
