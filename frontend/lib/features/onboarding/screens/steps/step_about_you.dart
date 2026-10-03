import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atlas_arrow_button.dart';
import '../../models/onboarding_data.dart';
import '../../notifiers/onboarding_notifier.dart';
import '_step_shell.dart';

// Weight: 30–200 kg
const _weightMin = 30;
const _weightMax = 200;
const _weightDefault = 70;

// Height: 140–230 cm
const _heightMin = 140;
const _heightMax = 230;
const _heightDefault = 170;

class StepAboutYou extends StatefulWidget {
  const StepAboutYou({
    super.key,
    required this.notifier,
    required this.onNext,
  });
  final OnboardingNotifier notifier;
  final VoidCallback onNext;

  @override
  State<StepAboutYou> createState() => _StepAboutYouState();
}

class _StepAboutYouState extends State<StepAboutYou> {
  late final TextEditingController _nameCtrl;
  late final FixedExtentScrollController _weightCtrl;
  late final FixedExtentScrollController _heightCtrl;

  BiologicalSex? _sex;
  bool _nameFilled = false;

  bool get _ready => _nameFilled && _sex != null;

  @override
  void initState() {
    super.initState();
    final data = widget.notifier.data;

    _nameCtrl = TextEditingController(text: data.firstName);
    _nameFilled = data.firstName.trim().length >= 2;
    _nameCtrl.addListener(_onNameChanged);

    _sex = data.sex;

    final weightIdx = ((data.weightKg ?? _weightDefault) - _weightMin)
        .clamp(0, _weightMax - _weightMin);
    final heightIdx = ((data.heightCm ?? _heightDefault) - _heightMin)
        .clamp(0, _heightMax - _heightMin);

    _weightCtrl = FixedExtentScrollController(initialItem: weightIdx);
    _heightCtrl = FixedExtentScrollController(initialItem: heightIdx);

    // Persist defaults immediately so they're captured if the user doesn't scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.notifier.setWeight(data.weightKg ?? _weightDefault);
      widget.notifier.setHeight(data.heightCm ?? _heightDefault);
    });
  }

  @override
  void dispose() {
    _nameCtrl.removeListener(_onNameChanged);
    _nameCtrl.dispose();
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    final filled = _nameCtrl.text.trim().length >= 2;
    if (filled != _nameFilled) setState(() => _nameFilled = filled);
    widget.notifier.updateName(_nameCtrl.text.trim());
  }

  void _setSex(BiologicalSex sex) {
    setState(() => _sex = sex);
    widget.notifier.setSex(sex);
  }

  @override
  Widget build(BuildContext context) {
    return StepShell(
      headline: 'Tell us about you.',
      subtext: 'Name, sex, and body stats help us personalize everything.',
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NameField(controller: _nameCtrl),
          const SizedBox(height: 28),
          _SectionLabel('BIOLOGICAL SEX'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SexCard(
                  sex: BiologicalSex.male,
                  selected: _sex == BiologicalSex.male,
                  onTap: () => _setSex(BiologicalSex.male),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SexCard(
                  sex: BiologicalSex.female,
                  selected: _sex == BiologicalSex.female,
                  onTap: () => _setSex(BiologicalSex.female),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SectionLabel('WEIGHT'),
          const SizedBox(height: 10),
          _HorizontalDrumRoll(
            controller: _weightCtrl,
            values: List.generate(
              _weightMax - _weightMin + 1,
              (i) => _weightMin + i,
            ),
            unit: 'kg',
            onChanged: (v) => widget.notifier.setWeight(v),
          ),
          const SizedBox(height: 24),
          _SectionLabel('HEIGHT'),
          const SizedBox(height: 10),
          _VerticalDrumRoll(
            controller: _heightCtrl,
            values: List.generate(
              _heightMax - _heightMin + 1,
              (i) => _heightMin + i,
            ),
            unit: 'cm',
            onChanged: (v) => widget.notifier.setHeight(v),
          ),
          const SizedBox(height: 36),
          Align(
            alignment: Alignment.centerRight,
            child: AtlasArrowButton(onPressed: widget.onNext, enabled: _ready),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Section label ───────────────────────────────────────────────────────────

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

// ─── Name field ──────────────────────────────────────────────────────────────

class _NameField extends StatefulWidget {
  const _NameField({required this.controller});
  final TextEditingController controller;

  @override
  State<_NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField>
    with SingleTickerProviderStateMixin {
  late AnimationController _focus;
  late Animation<Color?> _borderColor;

  @override
  void initState() {
    super.initState();
    _focus = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _borderColor = ColorTween(
      begin: AppColors.border,
      end: AppColors.amber.withValues(alpha: 0.5),
    ).animate(CurvedAnimation(parent: _focus, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) =>
          focused ? _focus.forward() : _focus.reverse(),
      child: AnimatedBuilder(
        animation: _borderColor,
        builder: (_, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _borderColor.value!, width: 1.5),
          ),
          child: child,
        ),
        child: TextField(
          controller: widget.controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [LengthLimitingTextInputFormatter(32)],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            letterSpacing: 0.2,
          ),
          decoration: InputDecoration(
            hintText: 'Your name',
            hintStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: AppColors.white.withValues(alpha: 0.18),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
        ),
      ),
    );
  }
}

// ─── Sex selector ─────────────────────────────────────────────────────────────

class _SexCard extends StatelessWidget {
  const _SexCard({
    required this.sex,
    required this.selected,
    required this.onTap,
  });
  final BiologicalSex sex;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isMale = sex == BiologicalSex.male;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 90,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.amber.withValues(alpha: 0.08)
              : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.amber.withValues(alpha: 0.7)
                : const Color(0xFF252525),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isMale ? Icons.male_rounded : Icons.female_rounded,
              size: 32,
              color: selected ? AppColors.amber : const Color(0xFF555555),
            ),
            const SizedBox(height: 6),
            Text(
              sex.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: selected ? AppColors.white : const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Horizontal drum-roll (weight) ────────────────────────────────────────────

class _HorizontalDrumRoll extends StatelessWidget {
  const _HorizontalDrumRoll({
    required this.controller,
    required this.values,
    required this.unit,
    required this.onChanged,
  });
  final FixedExtentScrollController controller;
  final List<int> values;
  final String unit;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF222222)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The drum-roll wheel rotated to scroll horizontally
          RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 62,
              diameterRatio: 1.8,
              perspective: 0.002,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (i) => onChanged(values[i]),
              childDelegate: ListWheelChildListDelegate(
                children: values
                    .map(
                      (v) => RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            '$v',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          // Left fade
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 72,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF111111),
                    const Color(0xFF111111).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Right fade
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 72,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF111111).withValues(alpha: 0),
                    const Color(0xFF111111),
                  ],
                ),
              ),
            ),
          ),
          // Center selection bracket
          IgnorePointer(
            child: Center(
              child: Container(
                width: 62,
                height: 110,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Color(0x33F5A623),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Unit label pinned to right
          Positioned(
            right: 20,
            child: Text(
              unit,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Vertical drum-roll (height) ──────────────────────────────────────────────

class _VerticalDrumRoll extends StatelessWidget {
  const _VerticalDrumRoll({
    required this.controller,
    required this.values,
    required this.unit,
    required this.onChanged,
  });
  final FixedExtentScrollController controller;
  final List<int> values;
  final String unit;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF222222)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 52,
            diameterRatio: 1.8,
            perspective: 0.002,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (i) => onChanged(values[i]),
            childDelegate: ListWheelChildListDelegate(
              children: values
                  .map(
                    (v) => Center(
                      child: Text(
                        '$v',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Top fade
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 52,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF111111),
                    const Color(0xFF111111).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Bottom fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 52,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF111111),
                    const Color(0xFF111111).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Center selection bracket
          IgnorePointer(
            child: Center(
              child: Container(
                height: 52,
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color(0x33F5A623),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Unit label pinned to right
          Positioned(
            right: 20,
            child: Text(
              unit,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
