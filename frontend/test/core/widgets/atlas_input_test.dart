import 'package:atlas/core/widgets/atlas_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Padding(padding: const EdgeInsets.all(16), child: child)));

void main() {
  group('AtlasInput', () {
    testWidgets('renders hint text', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasInput(hint: 'Enter weight')),
      );
      expect(find.text('Enter weight'), findsOneWidget);
    });

    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasInput(label: 'Reps')),
      );
      expect(find.text('Reps'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? result;
      await tester.pumpWidget(
        _wrap(AtlasInput(onChanged: (v) => result = v)),
      );
      await tester.enterText(find.byType(TextFormField), '10');
      expect(result, '10');
    });

    testWidgets('shows error text when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasInput(errorText: 'Required')),
      );
      expect(find.text('Required'), findsOneWidget);
    });
  });
}
