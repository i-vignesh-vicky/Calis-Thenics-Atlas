import 'package:flutter/material.dart';

import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '../../widgets/selection_card.dart';
import '_step_shell.dart';

class StepSetup extends StatelessWidget {
  const StepSetup({
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
        final locs = notifier.data.locations;
        final gear = notifier.data.equipment;
        return StepShell(
          headline: 'Your training setup.',
          subtext: 'Where you train and what you have shapes your entire program.',
          scrollable: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel('WHERE'),
              const SizedBox(height: 10),
              ..._locations.map((l) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectionCard(
                      label: l.title,
                      subtitle: l.subtitle,
                      icon: l.icon,
                      selected: locs.contains(l.location),
                      multiSelect: true,
                      onTap: () => notifier.toggleLocation(l.location),
                    ),
                  )),
              const SizedBox(height: 24),
              const _SectionLabel('WITH WHAT'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _equipment.map((e) => _GearChip(
                      label: e.label,
                      selected: gear.contains(e.equipment),
                      onTap: () => notifier.toggleEquipment(e.equipment),
                    )).toList(),
              ),
              const SizedBox(height: 36),
              Align(
                alignment: Alignment.centerRight,
                child: AtlasArrowButton(
                  onPressed: onNext,
                  enabled: locs.isNotEmpty && gear.isNotEmpty,
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

class _LocationOption {
  const _LocationOption(this.location, this.icon, this.title, this.subtitle);
  final TrainingLocation location;
  final IconData icon;
  final String title;
  final String subtitle;
}

const _locations = [
  _LocationOption(TrainingLocation.home, Icons.home_outlined, 'Home',
      'Living room, bedroom, wherever'),
  _LocationOption(TrainingLocation.gym, Icons.fitness_center_outlined, 'Gym',
      'Pull-up bars, dip bars, rings available'),
  _LocationOption(TrainingLocation.outdoors, Icons.park_outlined, 'Outdoors',
      'Parks, bars, open sky'),
];

class _GearOption {
  const _GearOption(this.equipment, this.label);
  final Equipment equipment;
  final String label;
}

const _equipment = [
  _GearOption(Equipment.bodyweightOnly, 'Bodyweight'),
  _GearOption(Equipment.pullUpBar, 'Pull-up Bar'),
  _GearOption(Equipment.rings, 'Rings'),
  _GearOption(Equipment.parallettes, 'Parallettes'),
  _GearOption(Equipment.resistanceBands, 'Bands'),
  _GearOption(Equipment.dumbbells, 'Dumbbells'),
  _GearOption(Equipment.fullGym, 'Full Gym'),
];

class _GearChip extends StatelessWidget {
  const _GearChip({
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFF5A623).withValues(alpha: 0.10)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: selected
                ? const Color(0xFFF5A623).withValues(alpha: 0.65)
                : const Color(0xFF2A2A2A),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? const Color(0xFFF5A623) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}
