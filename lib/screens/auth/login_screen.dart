import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth/custom_text_field.dart';
import '../../widgets/auth/auth_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(
        _phoneController.text.trim(),
        _pinController.text,
      );

      if (success) {
        if (mounted) {
          context.go('/dashboard');
        }
      } else {
        if (mounted) {
          _showErrorSnackBar('Login failed. Please check your credentials.');
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('An error occurred. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    // Logo and Welcome Text
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                            .animate()
                            .scale(duration: 600.ms, delay: 200.ms)
                            .fadeIn(duration: 600.ms, delay: 200.ms),
                        const SizedBox(height: 20),
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                              ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 400.ms)
                            .slideY(
                                begin: 0.3, duration: 600.ms, delay: 400.ms),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue to LooPay',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 600.ms)
                            .slideY(
                                begin: 0.3, duration: 600.ms, delay: 600.ms),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Phone Field
                    AnimatedBuilder(
                      animation: _shakeController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_shakeController.value * 10, 0),
                          child: CustomTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            prefixIcon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.length < 8) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 800.ms)
                        .slideY(begin: 0.3, duration: 600.ms, delay: 800.ms),

                    const SizedBox(height: 16),

                    // PIN Field
                    AnimatedBuilder(
                      animation: _shakeController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_shakeController.value * 10, 0),
                          child: CustomTextField(
                            controller: _pinController,
                            label: 'PIN',
                            hint: 'Enter your 4-6 digit PIN',
                            prefixIcon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your PIN';
                              }
                              if (value.length < 4 || value.length > 6) {
                                return 'PIN must be 4-6 digits';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1000.ms)
                        .slideY(begin: 0.3, duration: 600.ms, delay: 1000.ms),

                    const SizedBox(height: 8),

                    // Forgot PIN
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                        },
                        child: Text(
                          'Forgot PIN?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 1200.ms),

                    const SizedBox(height: 24),

                    // Login Button
                    AuthButton(
                      text: 'Sign In',
                      isLoading: _isLoading,
                      onPressed: _handleLogin,
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1400.ms)
                        .slideY(begin: 0.3, duration: 600.ms, delay: 1400.ms),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppColors.textTertiary)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: AppColors.textTertiary)),
                      ],
                    ).animate().fadeIn(duration: 600.ms, delay: 1600.ms),

                    const SizedBox(height: 24),

                    // Google Login Button
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement Google login
                      },
                      icon: const Icon(Icons.g_mobiledata,
                          color: AppColors.primary),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 1800.ms)
                        .slideY(begin: 0.3, duration: 600.ms, delay: 1800.ms),

                    const SizedBox(height: 24),

                    // Biometric Login Placeholder
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.textTertiary),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fingerprint,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Biometric Login (Coming Soon)',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 2000.ms),

                    const SizedBox(height: 32),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        TextButton(
                          onPressed: () => context.go('/signup'),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 600.ms, delay: 2200.ms),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
