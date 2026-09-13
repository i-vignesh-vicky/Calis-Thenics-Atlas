import 'package:atlas/core/widgets/atlas_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('AtlasButton', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasButton(label: 'Start', onPressed: () {})),
      );
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('primary variant uses ElevatedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasButton(label: 'Go', onPressed: () {})),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('secondary variant uses OutlinedButton', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasButton(
          label: 'Cancel',
          onPressed: () {},
          variant: AtlasButtonVariant.secondary,
        )),
      );
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('text variant uses TextButton', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasButton(
          label: 'Skip',
          onPressed: () {},
          variant: AtlasButtonVariant.text,
        )),
      );
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('loading state disables tap and shows indicator', (tester) async {
      await tester.pumpWidget(
        _wrap(AtlasButton(label: 'Save', onPressed: () {}, loading: true)),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('onPressed is invoked on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(AtlasButton(label: 'Log', onPressed: () => tapped = true)),
      );
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, isTrue);
    });
  });
}
