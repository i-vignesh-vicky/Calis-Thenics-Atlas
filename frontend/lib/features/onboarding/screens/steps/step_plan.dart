import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../widgets/particle_painter.dart';

class StepPlan extends StatefulWidget {
  const StepPlan({
    super.key,
    required this.notifier,
    required this.onSubmit,
  });

  final OnboardingNotifier notifier;
  final Future<void> Function() onSubmit;

  @override
  State<StepPlan> createState() => _StepPlanState();
}

class _StepPlanState extends State<StepPlan> with TickerProviderStateMixin {
  late AnimationController _particles;
  late AnimationController _reveal;
  late AnimationController _orbPulse;

  late Animation<double> _orbScale;
  late Animation<double> _planCardOpacity;
  late Animation<Offset> _planCardSlide;
  late Animation<double> _statsOpacity;
  late Animation<double> _ctaOpacity;

  @override
  void initState() {
    super.initState();

    _particles = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _orbPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _orbScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _orbPulse, curve: Curves.easeInOut),
    );

    _reveal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _planCardOpacity = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _planCardSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    ));
    _statsOpacity = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.3, 0.75, curve: Curves.easeOut),
    );
    _ctaOpacity = CurvedAnimation(
      parent: _reveal,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
    );

    _reveal.forward();
  }

  @override
  void dispose() {
    _particles.dispose();
    _reveal.dispose();
    _orbPulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.notifier.data;
    final isLoading = widget.notifier.isSubmitting;
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _particles,
          builder: (_, __) => CustomPaint(
            painter: ParticlePainter(_particles),
            size: size,
          ),
        ),

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Pulsing amber orb
                Center(
                  child: AnimatedBuilder(
                    animation: _orbScale,
                    builder: (_, child) =>
                        Transform.scale(scale: _orbScale.value, child: child),
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.amber.withValues(alpha: 0.9),
                            AppColors.amber.withValues(alpha: 0.4),
                            AppColors.amber.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.amber.withValues(alpha: 0.4),
                            blurRadius: 32,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Color(0xFFFFFFFF),
                        size: 40,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SlideTransition(
                  position: _planCardSlide,
                  child: FadeTransition(
                    opacity: _planCardOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Atlas Plan',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3,
                            color: AppColors.amber.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _planTitle(data),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _planDescription(data),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white.withValues(alpha: 0.5),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                FadeTransition(
                  opacity: _statsOpacity,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _StatPill(
                        label: _freqLabel(data.frequency),
                        icon: Icons.calendar_today_outlined,
                      ),
                      _StatPill(
                        label: _experienceLabel(data.experienceLevel),
                        icon: Icons.bar_chart_rounded,
                      ),
                      _StatPill(
                        label: _goalLabel(data.primaryGoal),
                        icon: Icons.flag_outlined,
                      ),
                      if (data.assessment != null &&
                          _hasAnyMetric(data.assessment!))
                        _StatPill(
                          label: _assessmentSummary(data.assessment!),
                          icon: Icons.analytics_outlined,
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                FadeTransition(
                  opacity: _statsOpacity,
                  child: _MilestoneCard(data: data),
                ),

                const SizedBox(height: 32),

                FadeTransition(
                  opacity: _ctaOpacity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AtlasArrowButton(
                      onPressed: () => widget.onSubmit(),
                      enabled: !isLoading,
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.amber),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.data});
  final OnboardingData data;

  @override
  Widget build(BuildContext context) {
    final milestones = _milestones(data);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF242424)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FIRST MILESTONES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.5,
              color: AppColors.white.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 16),
          ...milestones.asMap().entries.map((e) {
            final isLast = e.key == milestones.length - 1;
            return _MilestoneRow(
              text: e.value,
              week: 'Week ${e.key + 1}',
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow({
    required this.text,
    required this.week,
    required this.isLast,
  });
  final String text;
  final String week;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.amber,
              ),
            ),
            if (!isLast)
              Container(width: 1, height: 32, color: const Color(0xFF2A2A2A)),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: AppColors.amber.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white.withValues(alpha: 0.75),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// — Helpers —

bool _hasAnyMetric(AssessmentResult r) =>
    r.pullUps != null || r.pushUps != null || r.dips != null;

String _planTitle(OnboardingData d) {
  switch (d.primaryGoal) {
    case TrainingGoal.strength:
      return 'Strength Protocol';
    case TrainingGoal.skills:
      return 'Skill Journey';
    case TrainingGoal.muscle:
      return 'Hypertrophy Blueprint';
    case TrainingGoal.mobility:
      return 'Movement Mastery';
    case TrainingGoal.consistency:
      return 'Habit Builder';
    case null:
      return 'Your Atlas Plan';
  }
}

String _planDescription(OnboardingData d) {
  final name = d.firstName.isEmpty ? 'You' : d.firstName;
  final freq = _freqLabel(d.frequency).toLowerCase();
  switch (d.primaryGoal) {
    case TrainingGoal.strength:
      return '$name, your $freq strength plan starts with pull, push, and legs — building from your baseline up.';
    case TrainingGoal.skills:
      return '$name, $freq skill sessions structured around progressions for the moves that matter most to you.';
    case TrainingGoal.muscle:
      return 'High-volume $freq training with progressive overload, tuned to your current level.';
    case TrainingGoal.mobility:
      return '$freq sessions blending strength and range of motion for lasting athletic movement.';
    case TrainingGoal.consistency:
      return 'Three sessions per week, always doable — building the habit before building the body.';
    case null:
      return 'Your personalized calisthenics plan is ready.';
  }
}

List<String> _milestones(OnboardingData d) {
  switch (d.primaryGoal) {
    case TrainingGoal.strength:
      return [
        'Complete first full-week streak',
        'Hit 15 clean push-ups in a row',
        'First unassisted pull-up (or +5 reps)',
      ];
    case TrainingGoal.skills:
      return [
        'Solid 10-second wall handstand hold',
        'First negative muscle-up rep',
        'Consistent 30-second freestanding hold',
      ];
    case TrainingGoal.muscle:
      return [
        'Weekly volume target hit consistently',
        'Progressive overload on all main lifts',
        'Visible strength increase in 30 days',
      ];
    case TrainingGoal.mobility:
      return [
        'Pain-free full squat depth',
        'Shoulders in active overhead position',
        'Bridge and pancake mobility targets',
      ];
    case TrainingGoal.consistency:
      return [
        'First 7-day active streak',
        'Three full weeks without a miss',
        'Habit locked in — 30-day milestone',
      ];
    case null:
      return [
        'Complete your first session',
        'Build a 7-day streak',
        'Hit your first milestone',
      ];
  }
}

String _freqLabel(TrainingFrequency? f) {
  switch (f) {
    case TrainingFrequency.twoDays:
      return '2x/week';
    case TrainingFrequency.threeDays:
      return '3x/week';
    case TrainingFrequency.fourDays:
      return '4x/week';
    case TrainingFrequency.fivePlus:
      return '5+/week';
    case null:
      return '3x/week';
  }
}

String _experienceLabel(ExperienceLevel? e) {
  switch (e) {
    case ExperienceLevel.justStarting:
      return 'Starting fresh';
    case ExperienceLevel.beginner:
      return 'Beginner';
    case ExperienceLevel.intermediate:
      return 'Intermediate';
    case ExperienceLevel.advanced:
      return 'Advanced';
    case null:
      return 'Beginner';
  }
}

String _goalLabel(TrainingGoal? g) {
  switch (g) {
    case TrainingGoal.strength:
      return 'Strength';
    case TrainingGoal.skills:
      return 'Skills';
    case TrainingGoal.muscle:
      return 'Muscle';
    case TrainingGoal.mobility:
      return 'Mobility';
    case TrainingGoal.consistency:
      return 'Consistency';
    case null:
      return 'Goal';
  }
}

String _assessmentSummary(AssessmentResult r) {
  if (r.pullUps != null) return '${r.pullUps} pull-ups';
  if (r.pushUps != null) return '${r.pushUps} push-ups';
  if (r.dips != null) return '${r.dips} dips';
  return 'Assessed';
}
