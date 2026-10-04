import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '_step_shell.dart';

class StepExperience extends StatelessWidget {
  const StepExperience({
    super.key,
    required this.notifier,
    required this.onNext,
  });
  final OnboardingNotifier notifier;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (_, __) {
        final selected = notifier.data.experienceLevel;
        return StepShell(
          headline: 'Experience level?',
          subtext: 'Honest answers unlock the right starting program.',
          child: Column(
            children: [
              ..._options.map((o) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ExperienceCard(
                      level: o.level,
                      title: o.title,
                      description: o.description,
                      emoji: o.emoji,
                      selected: selected == o.level,
                      onTap: () => notifier.setExperience(o.level),
                    ),
                  )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: AtlasArrowButton(
                  onPressed: onNext,
                  enabled: selected != null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    required this.level,
    required this.title,
    required this.description,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  final ExperienceLevel level;
  final String title;
  final String description;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _press;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 280),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _press.forward(),
      onTapUp: (_) {
        _press.reverse();
        widget.onTap();
      },
      onTapCancel: () => _press.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: widget.selected
                ? AppColors.amber.withValues(alpha: 0.07)
                : const Color(0xFF161616),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selected
                  ? AppColors.amber.withValues(alpha: 0.65)
                  : const Color(0xFF252525),
              width: widget.selected ? 1.5 : 1,
            ),
            boxShadow: widget.selected
                ? [
                    BoxShadow(
                      color: AppColors.amber.withValues(alpha: 0.10),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.selected
                      ? AppColors.amber.withValues(alpha: 0.12)
                      : const Color(0xFF202020),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(widget.emoji,
                      style: const TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: widget.selected
                            ? AppColors.white
                            : const Color(0xFFCCCCCC),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: widget.selected
                            ? AppColors.amber.withValues(alpha: 0.75)
                            : const Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      widget.selected ? AppColors.amber : Colors.transparent,
                  border: Border.all(
                    color: widget.selected
                        ? AppColors.amber
                        : const Color(0xFF444444),
                    width: 1.5,
                  ),
                ),
                child: widget.selected
                    ? const Icon(Icons.check,
                        size: 12, color: Color(0xFFFFFFFF))
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Option {
  const _Option(this.level, this.emoji, this.title, this.description);
  final ExperienceLevel level;
  final String emoji;
  final String title;
  final String description;
}

const _options = [
  _Option(ExperienceLevel.justStarting, '🌱', 'Just Starting',
      'Never trained calisthenics before, or returning after a long break'),
  _Option(ExperienceLevel.beginner, '💪', 'Beginner',
      'Can do 5–10 push-ups. Working toward first pull-up'),
  _Option(ExperienceLevel.intermediate, '🔥', 'Intermediate',
      '10+ pull-ups, dips. Exploring muscle-up or handstand'),
  _Option(ExperienceLevel.advanced, '⚡', 'Advanced',
      'Muscle-up, handstand push-ups, working toward planche or front lever'),
];
