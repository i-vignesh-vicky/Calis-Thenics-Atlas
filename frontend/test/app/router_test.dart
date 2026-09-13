import 'package:atlas/app/app.dart';
import 'package:atlas/app/shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRouter', () {
    testWidgets('initial route renders without error', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('MainShell is present on initial route', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(MainShell), findsOneWidget);
    });

    testWidgets('NavigationBar has five destinations', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(NavigationDestination), findsNWidgets(5));
    });

    testWidgets('tapping Workouts destination navigates to workouts', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(NavigationDestination).at(1));
      await tester.pumpAndSettle();
      expect(find.text('Workouts'), findsWidgets);
    });

    testWidgets('tapping Progress destination navigates to progress', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(NavigationDestination).at(2));
      await tester.pumpAndSettle();
      expect(find.text('Progress'), findsWidgets);
    });
  });
}
