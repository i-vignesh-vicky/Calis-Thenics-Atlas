import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';

/// Persistent bottom-navigation shell — 4 tabs matching Equinox+ nav pattern.
/// Settings is accessible from the Profile tab.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    (label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home_rounded, route: '/home'),
    (
      label: 'Explore',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view_rounded,
      route: '/workouts'
    ),
    (
      label: 'Activity',
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded,
      route: '/progress'
    ),
    (
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      route: '/profile'
    ),
  ];

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    // Settings lives under /settings but is accessed from Profile tab
    if (location.startsWith('/settings')) return 3;
    final index = _destinations.indexWhere((d) => location.startsWith(d.route));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _selectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: _AtlasNavBar(
        selectedIndex: selectedIndex,
        onTap: (i) => context.go(_destinations[i].route),
        destinations: _destinations,
      ),
    );
  }
}

class _AtlasNavBar extends StatelessWidget {
  const _AtlasNavBar({
    required this.selectedIndex,
    required this.onTap,
    required this.destinations,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<({String label, IconData icon, IconData activeIcon, String route})> destinations;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(destinations.length, (i) {
              final d = destinations[i];
              final selected = i == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        selected ? d.activeIcon : d.icon,
                        size: 23,
                        color: selected ? AppColors.amber : AppColors.muted,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        d.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? AppColors.amber : AppColors.muted,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
