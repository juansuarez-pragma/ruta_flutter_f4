import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_design_system/fake_store_design_system.dart';

Widget buildTestableWidget(Widget child) {
  return MaterialApp(
    theme: FakeStoreTheme.light(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('DSTextField', () {
    group('Rendering', () {
      testWidgets('renders with label', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
            ),
          ),
        );

        expect(find.text('Email'), findsOneWidget);
      });

      testWidgets('renders with hint text', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              hint: 'Enter your email',
            ),
          ),
        );

        expect(find.text('Enter your email'), findsOneWidget);
      });

      testWidgets('renders with label and hint', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              hint: 'example@email.com',
            ),
          ),
        );

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('example@email.com'), findsOneWidget);
      });

      testWidgets('renders with prefix icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Search',
              prefixIcon: Icons.search,
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('renders with suffix icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Password',
              suffixIcon: Icons.visibility,
            ),
          ),
        );

        expect(find.byIcon(Icons.visibility), findsOneWidget);
      });

      testWidgets('renders with both prefix and suffix icons',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Search',
              prefixIcon: Icons.search,
              suffixIcon: Icons.clear,
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.clear), findsOneWidget);
      });

      testWidgets('renders with helper text', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Username',
              helperText: 'Must be at least 3 characters',
            ),
          ),
        );

        expect(find.text('Must be at least 3 characters'), findsOneWidget);
      });
    });

    group('States', () {
      testWidgets('renders in enabled state by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Name',
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.enabled, isTrue);
      });

      testWidgets('renders in disabled state when enabled is false',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Name',
              enabled: false,
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.enabled, isFalse);
      });

      testWidgets('renders error state with error text',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              errorText: 'Invalid email address',
            ),
          ),
        );

        expect(find.text('Invalid email address'), findsOneWidget);
      });

      testWidgets('does not render error when errorText is null',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              errorText: null,
            ),
          ),
        );

        // No error text should be rendered
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.decoration?.errorText, isNull);
      });

      testWidgets('does not render error when errorText is empty',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              errorText: '',
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.decoration?.errorText, isNull);
      });

      testWidgets('obscures text when obscureText is true',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Password',
              obscureText: true,
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.obscureText, isTrue);
      });

      testWidgets('does not obscure text by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Username',
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.obscureText, isFalse);
      });

      testWidgets('renders read-only when readOnly is true',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'ID',
              readOnly: true,
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.readOnly, isTrue);
      });
    });

    group('Validation', () {
      testWidgets('shows error text when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              errorText: 'Please enter a valid email',
            ),
          ),
        );

        expect(find.text('Please enter a valid email'), findsOneWidget);
      });

      testWidgets('respects maxLength constraint',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Code',
              maxLength: 6,
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.maxLength, equals(6));
      });
    });

    group('Interactions', () {
      testWidgets('calls onChanged when text changes',
          (WidgetTester tester) async {
        String? changedValue;
        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              label: 'Name',
              onChanged: (value) => changedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextField), 'John');
        expect(changedValue, equals('John'));
      });

      testWidgets('calls onSubmitted when submitted',
          (WidgetTester tester) async {
        String? submittedValue;
        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              label: 'Search',
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextField), 'query');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        expect(submittedValue, equals('query'));
      });

      testWidgets('calls onSuffixIconTap when suffix icon is tapped',
          (WidgetTester tester) async {
        bool wasTapped = false;
        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              label: 'Password',
              suffixIcon: Icons.visibility,
              onSuffixIconTap: () => wasTapped = true,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.visibility));
        expect(wasTapped, isTrue);
      });

      testWidgets('does not accept input when disabled',
          (WidgetTester tester) async {
        String? changedValue;
        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              label: 'Name',
              enabled: false,
              onChanged: (value) => changedValue = value,
            ),
          ),
        );

        await tester.enterText(find.byType(TextField), 'John');
        expect(changedValue, isNull);
      });

      testWidgets('uses provided controller', (WidgetTester tester) async {
        final controller = TextEditingController(text: 'Initial');
        await tester.pumpWidget(
          buildTestableWidget(
            DSTextField(
              label: 'Name',
              controller: controller,
            ),
          ),
        );

        expect(find.text('Initial'), findsOneWidget);
        controller.dispose();
      });

      testWidgets('autofocuses when autofocus is true',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Search',
              autofocus: true,
            ),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.autofocus, isTrue);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
            ),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('uses label as semantic label by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email Address',
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(Column),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.label, equals('Email Address'));
      });

      testWidgets('uses custom semanticLabel when provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              semanticLabel: 'Enter your email address',
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(Column),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.label, equals('Enter your email address'));
      });

      testWidgets('includes error in semantic hint when error exists',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Email',
              errorText: 'Invalid email',
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(Column),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.hint, contains('Error: Invalid email'));
      });

      testWidgets('indicates disabled state in semantics',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Name',
              enabled: false,
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(Column),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.enabled, isFalse);
      });

      testWidgets('indicates password field in semantic hint',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const DSTextField(
              label: 'Password',
              obscureText: true,
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.ancestor(
            of: find.byType(Column),
            matching: find.byType(Semantics),
          ).first,
        );
        expect(semantics.properties.hint, contains('Password field'));
      });
    });
  });
}
