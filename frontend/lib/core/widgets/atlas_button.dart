import 'package:flutter/material.dart';

enum AtlasButtonVariant { primary, secondary, text }

class AtlasButton extends StatelessWidget {
  const AtlasButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AtlasButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AtlasButtonVariant variant;
  final Widget? icon;
  final bool loading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveCallback = loading ? null : onPressed;
    final child = loading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == AtlasButtonVariant.primary
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [icon!, const SizedBox(width: 8), Text(label)],
              )
            : Text(label);

    Widget button = switch (variant) {
      AtlasButtonVariant.primary => ElevatedButton(
          onPressed: effectiveCallback,
          child: child,
        ),
      AtlasButtonVariant.secondary => OutlinedButton(
          onPressed: effectiveCallback,
          child: child,
        ),
      AtlasButtonVariant.text => TextButton(
          onPressed: effectiveCallback,
          child: child,
        ),
    };

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
