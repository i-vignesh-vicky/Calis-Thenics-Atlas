import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_spacing.dart';
import '../core/widgets/atlas_page_layout.dart';
import '../features/home/screens/home_screen.dart';
import 'shell.dart';

/// Central route configuration for the application.
///
/// All routes are declared here. Feature modules must not define their own
/// top-level routes; they add sub-routes beneath their shell branch.
///
/// Route ownership:
///   /home            — Home tab (dashboard, quick-start)
///   /workouts        — Workouts tab (exercise library, routine list, execution)
///   /workouts/:id    — Workout detail / execution
///   /progress        — Progress tab (timeline, skills, milestones)
///   /profile         — Profile tab (user info, goals)
///   /settings        — Settings tab (preferences, account)
///   /auth/login      — Auth flow (outside shell)
///   /auth/signup     — Auth flow (outside shell)
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  errorBuilder: (context, state) => const _NotFoundScreen(),
  routes: [
    // Auth flow — outside the main shell (no bottom nav)
    GoRoute(
      path: '/auth/login',
      name: 'auth-login',
      builder: (context, state) =>
          const _PlaceholderScreen(title: 'Login', icon: Icons.lock_outline),
    ),
    GoRoute(
      path: '/auth/signup',
      name: 'auth-signup',
      builder: (context, state) =>
          const _PlaceholderScreen(title: 'Sign Up', icon: Icons.person_add_outlined),
    ),

    // Main shell — persistent bottom nav
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        // Workouts tab
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

        // Progress tab
        GoRoute(
          path: '/progress',
          name: 'progress',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Progress', icon: Icons.bar_chart_outlined),
        ),

        // Profile tab
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Profile', icon: Icons.person_outline),
        ),

        // Settings tab
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

/// Generic placeholder used until a feature screen is implemented.
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

/// Shown when navigation reaches an unknown route.
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
