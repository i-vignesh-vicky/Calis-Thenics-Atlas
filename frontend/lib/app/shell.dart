import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Persistent bottom-navigation shell that wraps all five top-level destinations.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    (label: 'Home', icon: Icons.home_outlined, route: '/home'),
    (label: 'Workouts', icon: Icons.fitness_center_outlined, route: '/workouts'),
    (label: 'Progress', icon: Icons.bar_chart_outlined, route: '/progress'),
    (label: 'Profile', icon: Icons.person_outline, route: '/profile'),
    (label: 'Settings', icon: Icons.settings_outlined, route: '/settings'),
  ];

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _destinations.indexWhere((d) => location.startsWith(d.route));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (i) => context.go(_destinations[i].route),
        destinations: _destinations
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
