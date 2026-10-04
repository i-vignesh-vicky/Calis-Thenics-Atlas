import 'package:flutter/material.dart';

import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '../../widgets/selection_card.dart';
import '_step_shell.dart';

class StepGoals extends StatelessWidget {
  const StepGoals({
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
        final selected = notifier.data.primaryGoal;
        return StepShell(
          headline: 'Your main goal?',
          subtext: 'We build your entire Atlas plan around this.',
          child: Column(
            children: [
              ..._goals.map((g) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectionCard(
                      label: g.title,
                      subtitle: g.subtitle,
                      icon: g.icon,
                      selected: selected == g.goal,
                      onTap: () => notifier.setPrimaryGoal(g.goal),
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

class _GoalOption {
  const _GoalOption(this.goal, this.icon, this.title, this.subtitle);
  final TrainingGoal goal;
  final IconData icon;
  final String title;
  final String subtitle;
}

const _goals = [
  _GoalOption(TrainingGoal.strength, Icons.fitness_center_outlined,
      'Build Strength', 'Max force output — pull, push, hold'),
  _GoalOption(TrainingGoal.skills, Icons.self_improvement_outlined,
      'Learn Skills', 'Handstand, muscle-up, front lever, planche'),
  _GoalOption(TrainingGoal.muscle, Icons.accessibility_new_outlined,
      'Build Muscle', 'Hypertrophy through bodyweight resistance'),
  _GoalOption(TrainingGoal.mobility, Icons.directions_run_outlined,
      'Improve Mobility', 'Move better, recover faster, stay pain-free'),
  _GoalOption(TrainingGoal.consistency, Icons.track_changes_outlined,
      'Build the Habit', 'Just show up, 3x per week, build momentum'),
];
