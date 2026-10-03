import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '_step_shell.dart';

class StepBaseline extends StatefulWidget {
  const StepBaseline({
    super.key,
    required this.notifier,
    required this.onNext,
  });
  final OnboardingNotifier notifier;
  final VoidCallback onNext;

  @override
  State<StepBaseline> createState() => _StepBaselineState();
}

class _StepBaselineState extends State<StepBaseline> {
  int? _pullUps;
  int? _pushUps;
  int? _dips;
  bool _allClear = false;

  @override
  void initState() {
    super.initState();
    final a = widget.notifier.data.assessment;
    if (a != null) {
      _pullUps = a.pullUps;
      _pushUps = a.pushUps;
      _dips = a.dips;
    }
    // If step was previously completed and no injuries were selected, restore All Clear
    _allClear = widget.notifier.data.injuries.isEmpty && a != null;
  }

  void _setMetric(String key, int? val) {
    setState(() {
      if (key == 'pullUps') _pullUps = val;
      if (key == 'pushUps') _pushUps = val;
      if (key == 'dips') _dips = val;
    });
    widget.notifier.setAssessment(
      AssessmentResult(pullUps: _pullUps, pushUps: _pushUps, dips: _dips),
    );
  }

  void _toggleInjury(InjuryArea area) {
    setState(() => _allClear = false);
    widget.notifier.toggleInjury(area);
  }

  void _tapAllClear() {
    widget.notifier.clearInjuries();
    setState(() => _allClear = !_allClear);
  }

  @override
  Widget build(BuildContext context) {
    final injuries = widget.notifier.data.injuries;
    return ListenableBuilder(
      listenable: widget.notifier,
      builder: (_, __) => StepShell(
        headline: 'Your starting point.',
        subtext: 'Calibrates your program from day one. Nothing here is required.',
        scrollable: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel('BASELINE NUMBERS'),
            const SizedBox(height: 12),
            _MetricCard(
              label: 'Pull-ups',
              description: 'Max clean reps from dead hang',
              icon: Icons.arrow_upward_rounded,
              value: _pullUps,
              onChanged: (v) => _setMetric('pullUps', v),
            ),
            const SizedBox(height: 10),
            _MetricCard(
              label: 'Push-ups',
              description: 'Max controlled reps, chest to floor',
              icon: Icons.arrow_downward_rounded,
              value: _pushUps,
              onChanged: (v) => _setMetric('pushUps', v),
            ),
            const SizedBox(height: 10),
            _MetricCard(
              label: 'Dips',
              description: 'Max reps, parallel bars or rings',
              icon: Icons.swap_vert_rounded,
              value: _dips,
              onChanged: (v) => _setMetric('dips', v),
            ),
            const SizedBox(height: 28),
            _SectionLabel('ANYTHING TO PROTECT'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: InjuryArea.values
                  .map((area) => _InjuryChip(
                        label: area.label,
                        selected: injuries.contains(area),
                        onTap: () => _toggleInjury(area),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            _AllClearChip(selected: _allClear, onTap: _tapAllClear),
            const SizedBox(height: 36),
            Align(
              alignment: Alignment.centerRight,
              child: AtlasArrowButton(onPressed: widget.onNext, enabled: true),
            ),
            const SizedBox(height: 24),
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

class _MetricCard extends StatefulWidget {
  const _MetricCard({
    required this.label,
    required this.description,
    required this.icon,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final String description;
  final IconData icon;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  late final TextEditingController _ctrl;
  bool _active = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.value != null ? widget.value.toString() : '',
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (f) => setState(() => _active = f),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _active
              ? AppColors.amber.withValues(alpha: 0.06)
              : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _active
                ? AppColors.amber.withValues(alpha: 0.5)
                : const Color(0xFF252525),
            width: _active ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _active
                    ? AppColors.amber.withValues(alpha: 0.12)
                    : const Color(0xFF202020),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: _active ? AppColors.amber : const Color(0xFF555555),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _active ? AppColors.white : const Color(0xFFBBBBBB),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF4A4A4A),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 52,
              child: TextField(
                controller: _ctrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                textAlign: TextAlign.center,
                onChanged: (v) => widget.onChanged(int.tryParse(v)),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _active ? AppColors.amber : AppColors.white,
                ),
                decoration: InputDecoration(
                  hintText: '—',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: AppColors.white.withValues(alpha: 0.15),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InjuryChip extends StatelessWidget {
  const _InjuryChip({
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
              ? const Color(0xFFFF6B6B).withValues(alpha: 0.12)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: selected
                ? const Color(0xFFFF6B6B).withValues(alpha: 0.65)
                : const Color(0xFF2A2A2A),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color:
                selected ? const Color(0xFFFF8080) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _AllClearChip extends StatelessWidget {
  const _AllClearChip({required this.selected, required this.onTap});
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
              ? const Color(0xFF34A853).withValues(alpha: 0.12)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: selected
                ? const Color(0xFF34A853).withValues(alpha: 0.65)
                : const Color(0xFF2A2A2A),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.check_circle_outline,
              size: 14,
              color: selected
                  ? const Color(0xFF34A853)
                  : const Color(0xFF666666),
            ),
            const SizedBox(width: 7),
            Text(
              'All clear — no restrictions',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected
                    ? const Color(0xFF34A853)
                    : const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
