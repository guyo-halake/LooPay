import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth/custom_text_field.dart';
import '../../widgets/auth/auth_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  bool _isLoading = false;
  bool _isSendingOtp = false;
  bool _otpSent = false;
  bool _biometricOptIn = false;
  int _currentStep = 0;
  late AnimationController _shakeController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    _shakeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
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
      final success = await authProvider.signup(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _pinController.text,
      );

      if (success) {
        if (mounted) {
          context.go('/dashboard');
        }
      } else {
        if (mounted) {
          _showErrorSnackBar('Signup failed. Please try again.');
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

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with Progress
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: _currentStep > 0
                                ? _previousStep
                                : () => context.go('/login'),
                            icon: const Icon(Icons.arrow_back,
                                color: AppColors.textPrimary),
                          ),
                          Expanded(
                            child: Text(
                              'Create Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 48), // Balance the back button
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Progress Bar
                      Row(
                        children: List.generate(3, (index) {
                          return Expanded(
                            child: Container(
                              height: 4,
                              margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                              decoration: BoxDecoration(
                                color: index <= _currentStep
                                    ? AppColors.primary
                                    : AppColors.textTertiary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Step ${_currentStep + 1} of 3',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Content
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentStep = index;
                        });
                      },
                      children: [
                        _buildPhoneStep(),
                        _buildOtpAndDetailsStep(),
                        _buildPinAndBiometricStep(),
                      ],
                    ),
                  ),
                ),

                // Bottom Actions
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (_currentStep < 2) ...[
                        AuthButton(
                          text: 'Continue',
                          onPressed: _nextStep,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          child: Text(
                            'Already have an account? Sign In',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ] else ...[
                        AuthButton(
                          text: 'Create Account',
                          isLoading: _isLoading,
                          onPressed: _handleSignup,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildPhoneStep() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Phone Number',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              'We’ll verify via SMS. Works for Kenya and diaspora numbers.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: '+2547XXXXXXXX or international format',
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
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 600.ms),
            const SizedBox(height: 16),
            AuthButton(
              text: _otpSent ? 'Resend Code' : 'Send Verification Code',
              isLoading: _isSendingOtp,
              onPressed: () async {
                if (_phoneController.text.trim().isEmpty) return;
                setState(() {
                  _isSendingOtp = true;
                });
                await Future.delayed(const Duration(seconds: 1));
                if (mounted) {
                  setState(() {
                    _otpSent = true;
                    _isSendingOtp = false;
                  });
                  _nextStep();
                }
              },
            ),
          ],
        ),
      );

  Widget _buildOtpAndDetailsStep() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verify & Details',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              'Enter the 6-digit code we sent to your phone.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _otpController,
              label: 'OTP Code',
              hint: 'Enter 6-digit code',
              prefixIcon: Icons.sms,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (_currentStep == 1) {
                  if (value == null || value.length != 6) {
                    return 'Enter the 6-digit code';
                  }
                }
                return null;
              },
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 600.ms),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              label: 'Email (Optional)',
              hint: 'Enter your email address',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                }
                return null;
              },
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 600.ms),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 700.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 700.ms),
          ],
        ),
      );

  Widget _buildPinAndBiometricStep() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create Your PIN',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              'Use a 4-6 digit PIN for quick and secure access.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _pinController,
              label: 'Create PIN',
              hint: 'Enter 4-6 digits',
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a PIN';
                }
                if (value.length < 4 || value.length > 6) {
                  return 'PIN must be 4-6 digits';
                }
                return null;
              },
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 600.ms),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _confirmPinController,
              label: 'Confirm PIN',
              hint: 'Re-enter PIN',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your PIN';
                }
                if (value != _pinController.text) {
                  return 'PINs do not match';
                }
                return null;
              },
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 700.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 700.ms),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.textTertiary),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fingerprint,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Enable biometrics (Face ID / Fingerprint) - Coming Soon',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                  Switch(
                    value: _biometricOptIn,
                    onChanged: (v) {
                      setState(() {
                        _biometricOptIn = v;
                      });
                    },
                  )
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 800.ms)
                .slideY(begin: 0.3, duration: 600.ms, delay: 800.ms),
          ],
        ),
      );
}
