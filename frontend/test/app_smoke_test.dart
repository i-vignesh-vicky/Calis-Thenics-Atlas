import 'package:atlas/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders without runtime errors', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Main route renders landing screen', (tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Atlas'), findsWidgets);
  });
}
