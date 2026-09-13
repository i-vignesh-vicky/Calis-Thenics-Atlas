import 'package:atlas/app/app.dart';
import 'package:atlas/core/theme/app_colors.dart';
import 'package:atlas/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

GoRouter _testRouter() => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const Scaffold(body: Text('Test')),
        ),
      ],
    );

void main() {
  group('AppTheme.dark', () {
    test('uses Material 3', () {
      expect(AppTheme.dark().useMaterial3, isTrue);
    });

    test('has dark brightness', () {
      expect(AppTheme.dark().brightness, Brightness.dark);
    });

    test('primary color is amber', () {
      expect(AppTheme.dark().colorScheme.primary, AppColors.amber);
    });

    test('surface color matches palette', () {
      expect(AppTheme.dark().colorScheme.surface, AppColors.surface);
    });

    test('scaffold background is near-black', () {
      expect(AppTheme.dark().scaffoldBackgroundColor, AppColors.black);
    });
  });

  group('AppTheme applied to app', () {
    testWidgets('renders without errors with dark theme', (tester) async {
      await tester.pumpWidget(App(routerConfig: _testRouter(), theme: AppTheme.dark()));
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('MaterialApp receives Atlas amber as primary', (tester) async {
      await tester.pumpWidget(App(routerConfig: _testRouter(), theme: AppTheme.dark()));
      await tester.pumpAndSettle();
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.theme?.colorScheme.primary, AppColors.amber);
    });
  });
}
