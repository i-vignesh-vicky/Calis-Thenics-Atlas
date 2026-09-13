import 'package:atlas/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

GoRouter _testRouter() => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const Scaffold(body: Text('Atlas')),
        ),
      ],
    );

void main() {
  testWidgets('App renders without runtime errors', (tester) async {
    await tester.pumpWidget(App(routerConfig: _testRouter()));
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Main route renders landing screen', (tester) async {
    await tester.pumpWidget(App(routerConfig: _testRouter()));
    await tester.pumpAndSettle();

    expect(find.text('Atlas'), findsWidgets);
  });
}
