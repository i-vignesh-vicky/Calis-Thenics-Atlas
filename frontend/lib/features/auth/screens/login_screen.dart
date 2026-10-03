import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/atlas_button.dart';
import '../../../core/widgets/atlas_input.dart';
import '../services/auth_notifier.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authService,
    required this.authNotifier,
  });

  final AuthService authService;
  final AuthNotifier authNotifier;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.authService.signInWithGoogle();
      widget.authNotifier.onLoginSuccess();
      if (mounted) context.go('/home');
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      widget.authNotifier.onLoginSuccess();
      if (mounted) context.go('/home');
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxxl),
                Text('Welcome back', style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Sign in to continue your training',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                if (_error != null) ...[
                  _ErrorBanner(message: _error!),
                  const SizedBox(height: AppSpacing.md),
                ],
                AtlasInput(
                  label: 'Email',
                  hint: 'you@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.md),
                AtlasInput(
                  label: 'Password',
                  hint: '••••••••',
                  controller: _passwordController,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: AppSpacing.xl),
                AtlasButton(
                  label: 'Sign in',
                  onPressed: _loading ? null : _submit,
                  loading: _loading,
                  fullWidth: true,
                ),
                const SizedBox(height: AppSpacing.lg),
                const _OrDivider(),
                const SizedBox(height: AppSpacing.lg),
                _SocialButton(
                  icon: const _GoogleIcon(),
                  label: 'Continue with Google',
                  onPressed: _signInWithGoogle,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: theme.textTheme.bodyMedium,
                    ),
                    AtlasButton(
                      label: 'Sign up',
                      variant: AtlasButtonVariant.text,
                      onPressed: () => context.go('/auth/signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!value.contains('@') || !value.contains('.')) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Divider(color: scheme.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
        ),
        Expanded(child: Divider(color: scheme.outlineVariant)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleGPainter()),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sw = size.width * 0.19;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2 - sw / 2;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.butt;

    p.color = const Color(0xFF34A853);
    canvas.drawArc(rect, pi / 6, pi / 3, false, p);
    p.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, pi / 2, pi / 2, false, p);
    p.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, pi, pi / 2, false, p);
    p.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, 3 * pi / 2, pi / 3, false, p);

    canvas.drawRect(
      Rect.fromLTWH(cx, cy - sw * 0.45, r - sw * 0.15, sw * 0.9),
      Paint()
        ..color = const Color(0xFF4285F4)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
