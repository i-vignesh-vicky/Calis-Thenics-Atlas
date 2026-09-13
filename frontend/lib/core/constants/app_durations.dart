/// Atlas animation duration constants.
///
/// Use these for all transition and animation durations.
/// Prefer [fast] for micro-interactions and [normal] for screen transitions.
abstract final class AppDurations {
  static const Duration fast   = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow   = Duration(milliseconds: 350);
}
