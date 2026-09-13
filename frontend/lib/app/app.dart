import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router.dart';

/// Root application widget.
class App extends StatelessWidget {
  const App({super.key, ThemeData? theme}) : _theme = theme;

  final ThemeData? _theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Atlas',
      theme: _theme ?? AppTheme.dark(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
