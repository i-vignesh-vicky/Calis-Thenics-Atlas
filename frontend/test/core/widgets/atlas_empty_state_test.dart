import 'package:atlas/core/widgets/atlas_empty_state.dart';
import 'package:atlas/core/widgets/atlas_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: child));

void main() {
  group('AtlasEmptyState', () {
    testWidgets('renders icon and title', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasEmptyState(
          icon: Icons.fitness_center,
          title: 'No workouts yet',
        )),
      );
      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
      expect(find.text('No workouts yet'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasEmptyState(
          icon: Icons.fitness_center,
          title: 'No workouts yet',
          subtitle: 'Start your first session',
        )),
      );
      expect(find.text('Start your first session'), findsOneWidget);
    });

    testWidgets('no CTA when actionLabel is null', (tester) async {
      await tester.pumpWidget(
        _wrap(const AtlasEmptyState(
          icon: Icons.fitness_center,
          title: 'Empty',
        )),
      );
      expect(find.byType(AtlasButton), findsNothing);
    });

    testWidgets('CTA button fires onAction', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(AtlasEmptyState(
          icon: Icons.fitness_center,
          title: 'Empty',
          actionLabel: 'Add Exercise',
          onAction: () => tapped = true,
        )),
      );
      await tester.tap(find.byType(ElevatedButton));
      expect(tapped, isTrue);
    });
  });
}
