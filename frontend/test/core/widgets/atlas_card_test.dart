import 'package:atlas/core/widgets/atlas_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('AtlasCard', () {
    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasCard(child: Text('Exercise'))),
      );
      expect(find.text('Exercise'), findsOneWidget);
    });

    testWidgets('wraps content in a Card', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasCard(child: Text('A'))),
      );
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('onTap fires when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(AtlasCard(child: const Text('B'), onTap: () => tapped = true)),
      );
      await tester.tap(find.byType(InkWell));
      expect(tapped, isTrue);
    });
  });
}
