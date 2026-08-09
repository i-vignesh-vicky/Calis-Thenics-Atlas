import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/screens/home_screen.dart';
import 'shell.dart';

/// Central route configuration for the application.
///
/// All routes are declared here. Feature modules must not define their own
/// top-level routes; they add sub-routes beneath their shell branch.
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/workouts',
          name: 'workouts',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Workouts'),
        ),
        GoRoute(
          path: '/progress',
          name: 'progress',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Progress'),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Profile'),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Settings'),
        ),
      ],
    ),
  ],
);

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
