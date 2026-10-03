import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/atlas_media_card.dart';
import '../../../core/widgets/atlas_section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _movements = [
    (label: 'Pull', color: Color(0xFF1A2A1A)),
    (label: 'Push', color: Color(0xFF1A1A2A)),
    (label: 'Core', color: Color(0xFF2A1A10)),
    (label: 'Legs', color: Color(0xFF2A1A2A)),
    (label: 'Skills', color: Color(0xFF10202A)),
    (label: 'Mobility', color: Color(0xFF1A2020)),
  ];

  static const _todayCards = [
    (
      title: 'Push-up Progression',
      subtitle: 'Push • Beginner',
      badge: 'Today',
      color: Color(0xFF1C1C28),
    ),
    (
      title: 'Dead Hang Hold',
      subtitle: 'Pull • Beginner',
      badge: 'Today',
      color: Color(0xFF1C2818),
    ),
    (
      title: 'L-Sit Foundation',
      subtitle: 'Core • Intermediate',
      badge: 'Today',
      color: Color(0xFF28201C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomScrollView(
        slivers: [
          _HomeAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program progress strip
                  _ProgramStrip(),
                  const SizedBox(height: AppSpacing.xl),

                  // Hero question — Equinox-style
                  Text(
                    'What will you\naccomplish today?',
                    style: tt.displaySmall,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Today's focus
                  AtlasSectionHeader(
                    label: "Today's Focus",
                    onSeeAll: () => context.go('/workouts'),
                  ),
                ],
              ),
            ),
          ),

          // Horizontal card carousel
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: _todayCards.length,
                separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, i) {
                  final card = _todayCards[i];
                  return AtlasMediaCard(
                    title: card.title,
                    subtitle: card.subtitle,
                    badge: card.badge,
                    placeholderColor: card.color,
                    width: 200,
                    height: 190,
                  );
                },
              ),
            ),
          ),

          // Browse by movement
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: AtlasSectionHeader(label: 'Browse by Movement'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 2.4,
              children: _movements
                  .map((m) => _MovementTile(label: m.label, color: m.color))
                  .toList(),
            ),
          ),

          // Quick links
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: AtlasSectionHeader(label: 'Quick Access'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  _QuickLink(
                    icon: Icons.star_outline_rounded,
                    label: 'My Favorites',
                    onTap: () {},
                  ),
                  _QuickLink(
                    icon: Icons.history_rounded,
                    label: 'Recent Workouts',
                    onTap: () {},
                  ),
                  _QuickLink(
                    icon: Icons.emoji_events_outlined,
                    label: 'Milestones',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.black,
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          // Avatar / initials
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.surfaceElevated,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'A',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.amber,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Atlas',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: AppColors.white, size: 22),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: AppColors.white, size: 22),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _ProgramStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'YOUR PROGRAM',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.muted,
                ),
              ),
              Spacer(),
              Text(
                'WEEK 1',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.subtle,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          _ProgressBar(),
          SizedBox(height: AppSpacing.xs),
          Text(
            '2 / 4 Required Sessions',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovementTile extends StatelessWidget {
  const _MovementTile({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: const LinearProgressIndicator(
        value: 0.5,
        minHeight: 3,
        backgroundColor: AppColors.border,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.teal),
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.subtle),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}
