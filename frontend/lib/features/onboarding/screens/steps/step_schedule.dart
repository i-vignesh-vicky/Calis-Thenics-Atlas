import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '_step_shell.dart';

class StepSchedule extends StatelessWidget {
  const StepSchedule({
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
        final freq = notifier.data.frequency;
        final dur = notifier.data.sessionLength;
        return StepShell(
          headline: 'Your schedule.',
          subtext: 'How often and how long — everything else adapts to this.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionLabel('HOW OFTEN'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: TrainingFrequency.values.map((f) => _FreqChip(
                      label: f.label,
                      selected: freq == f,
                      onTap: () => notifier.setFrequency(f),
                    )).toList(),
              ),
              const SizedBox(height: 28),
              _SectionLabel('HOW LONG'),
              const SizedBox(height: 12),
              ...SessionLength.values.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DurCard(
                      length: s,
                      selected: dur == s,
                      onTap: () => notifier.setSessionLength(s),
                    ),
                  )),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerRight,
                child: AtlasArrowButton(
                  onPressed: onNext,
                  enabled: freq != null && dur != null,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
        color: Color(0xFF444444),
      ),
    );
  }
}

class _FreqChip extends StatelessWidget {
  const _FreqChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.amber.withValues(alpha: 0.10)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: selected
                ? AppColors.amber.withValues(alpha: 0.65)
                : const Color(0xFF2A2A2A),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.amber : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _DurCard extends StatelessWidget {
  const _DurCard({
    required this.length,
    required this.selected,
    required this.onTap,
  });
  final SessionLength length;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.amber.withValues(alpha: 0.08)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.amber.withValues(alpha: 0.65)
                : const Color(0xFF2A2A2A),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    length.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: selected ? AppColors.white : const Color(0xFFBBBBBB),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    length.subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: selected
                          ? AppColors.amber.withValues(alpha: 0.65)
                          : const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: selected ? AppColors.amber : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: selected ? AppColors.amber : const Color(0xFF444444),
                  width: 1.5,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 11, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
