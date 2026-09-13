import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.routerConfig, ThemeData? theme})
      : _theme = theme;

  final RouterConfig<Object?> routerConfig;
  final ThemeData? _theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Atlas',
      theme: _theme ?? AppTheme.dark(),
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
