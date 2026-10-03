import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_notifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.authNotifier});

  final AuthNotifier authNotifier;

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: const Text('Sign out?', style: TextStyle(color: AppColors.white)),
        content: const Text(
          'You can sign back in at any time.',
          style: TextStyle(color: AppColors.subtle),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.subtle)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Sign out', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await authNotifier.logout();
      if (context.mounted) context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              // Avatar + name
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceHighest,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'A',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.amber,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('Athlete', style: tt.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      'atlas@example.com',
                      style: tt.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Stats row
              Row(
                children: [
                  _StatBox(label: 'DAYS ACTIVE', value: '12'),
                  const SizedBox(width: AppSpacing.sm),
                  _StatBox(label: 'WORKOUTS', value: '8'),
                  const SizedBox(width: AppSpacing.sm),
                  _StatBox(label: 'STREAK', value: '3'),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Account section
              _SectionLabel('Account'),
              const SizedBox(height: AppSpacing.sm),
              _MenuTile(
                icon: Icons.settings_outlined,
                label: 'Settings',
                onTap: () => context.push('/settings'),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Sign out — full width, red tint
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmSignOut(context),
                  icon: const Icon(Icons.logout_rounded, size: 18, color: Colors.redAccent),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: AppColors.muted,
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
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
