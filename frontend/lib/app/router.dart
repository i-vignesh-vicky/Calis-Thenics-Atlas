import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_spacing.dart';
import '../core/widgets/atlas_page_layout.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/services/auth_notifier.dart';
import '../features/auth/services/auth_service.dart';
import '../features/home/screens/home_screen.dart';
import 'shell.dart';

/// Central route configuration for the application.
///
/// Route ownership:
///   /home            — Home tab (dashboard, quick-start)
///   /workouts        — Workouts tab
///   /workouts/:id    — Workout detail / execution
///   /progress        — Progress tab
///   /profile         — Profile tab
///   /settings        — Settings tab
///   /auth/login      — Auth flow (outside shell)
///   /auth/signup     — Auth flow (outside shell)
GoRouter createRouter(AuthNotifier authNotifier, AuthService authService) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuth = authNotifier.isAuthenticated;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isAuth && !isAuthRoute) return '/auth/login';
      if (isAuth && isAuthRoute) return '/home';
      return null;
    },
    errorBuilder: (context, state) => const _NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/auth/login',
        name: 'auth-login',
        builder: (context, state) => LoginScreen(
          authService: authService,
          authNotifier: authNotifier,
        ),
      ),
      GoRoute(
        path: '/auth/signup',
        name: 'auth-signup',
        builder: (context, state) => SignupScreen(
          authService: authService,
          authNotifier: authNotifier,
        ),
      ),

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
                const _PlaceholderScreen(title: 'Workouts', icon: Icons.fitness_center_outlined),
            routes: [
              GoRoute(
                path: ':id',
                name: 'workout-detail',
                builder: (context, state) => _PlaceholderScreen(
                  title: 'Workout ${state.pathParameters['id']}',
                  icon: Icons.play_circle_outline,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/progress',
            name: 'progress',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Progress', icon: Icons.bar_chart_outlined),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Profile', icon: Icons.person_outline),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Settings', icon: Icons.settings_outlined),
          ),
        ],
      ),
    ],
  );
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title, this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AtlasPageLayout(
      title: title,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AtlasPageLayout(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Page not found', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
