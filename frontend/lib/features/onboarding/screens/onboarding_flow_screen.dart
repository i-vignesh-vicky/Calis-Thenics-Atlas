import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/onboarding_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../notifiers/onboarding_notifier.dart';
import '../services/onboarding_service.dart';
import '../widgets/onboarding_progress_bar.dart';
import 'steps/step_about_you.dart';
import 'steps/step_baseline.dart';
import 'steps/step_experience.dart';
import 'steps/step_goals.dart';
import 'steps/step_plan.dart';
import 'steps/step_schedule.dart';
import 'steps/step_setup.dart';

class OnboardingFlowScreen extends StatefulWidget {
  const OnboardingFlowScreen({
    super.key,
    required this.onboardingStorage,
    required this.onboardingService,
  });

  final OnboardingStorage onboardingStorage;
  final OnboardingService onboardingService;

  @override
  State<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends State<OnboardingFlowScreen>
    with TickerProviderStateMixin {
  final _notifier = OnboardingNotifier();
  final PageController _page = PageController();
  int _currentStep = 0;
  static const _totalSteps = 7;

  late AnimationController _entryCtrl;
  late Animation<double> _entryOpacity;
  late Animation<Offset> _entrySlide;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _entryOpacity = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _entrySlide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic),
    );
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _notifier.dispose();
    _page.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    HapticFeedback.lightImpact();
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _page.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      HapticFeedback.lightImpact();
      setState(() => _currentStep--);
      _page.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _submit() async {
    try {
      await _notifier.submit(widget.onboardingService);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save profile. Please try again.')),
      );
      return;
    }
    if (mounted && _notifier.completed) {
      await widget.onboardingStorage.setCompleted();
      if (mounted) context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: FadeTransition(
        opacity: _entryOpacity,
        child: SlideTransition(
          position: _entrySlide,
          child: Column(
            children: [
              // Progress bar — flush to very top
              ListenableBuilder(
                listenable: _notifier,
                builder: (_, __) => OnboardingProgressBar(
                  current: _currentStep + 1,
                  total: _totalSteps,
                ),
              ),

              // Nav row
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 8,
                  right: 20,
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    AnimatedOpacity(
                      opacity: _currentStep > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: GestureDetector(
                        onTap: _currentStep > 0 ? _prevStep : null,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: AppColors.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_currentStep + 1} of $_totalSteps',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white.withValues(alpha: 0.3),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  controller: _page,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // 1 — Name
                    StepAboutYou(notifier: _notifier, onNext: _nextStep),
                    // 2 — Goals
                    StepGoals(notifier: _notifier, onNext: _nextStep),
                    // 3 — Experience
                    StepExperience(notifier: _notifier, onNext: _nextStep),
                    // 4 — Training setup (location + equipment)
                    StepSetup(notifier: _notifier, onNext: _nextStep),
                    // 5 — Training schedule (frequency + session length)
                    StepSchedule(notifier: _notifier, onNext: _nextStep),
                    // 6 — Starting point (baseline numbers + injury areas)
                    StepBaseline(notifier: _notifier, onNext: _nextStep),
                    // 7 — Plan
                    ListenableBuilder(
                      listenable: _notifier,
                      builder: (_, __) => StepPlan(
                        notifier: _notifier,
                        onSubmit: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
