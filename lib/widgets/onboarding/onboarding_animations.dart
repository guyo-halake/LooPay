import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/app_colors.dart';

class OnboardingAnimations extends StatefulWidget {

  const OnboardingAnimations({
    super.key,
    required this.animationType,
    required this.isActive,
  });
  final String animationType;
  final bool isActive;

  @override
  State<OnboardingAnimations> createState() => _OnboardingAnimationsState();
}

class _OnboardingAnimationsState extends State<OnboardingAnimations>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(OnboardingAnimations oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.animationType) {
          case "phone_to_mpesa":
            return _buildPhoneToMpesaAnimation();
          case "calculator_coins":
            return _buildCalculatorCoinsAnimation();
          case "kenya_mpesa":
            return _buildKenyaMpesaAnimation();
          default:
            return _buildDefaultAnimation();
        }
      },
    );

  Widget _buildPhoneToMpesaAnimation() => Stack(
      alignment: Alignment.center,
      children: [
        // Background wave
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface.withOpacity(0.3),
                AppColors.primary.withOpacity(0.1),
              ],
            ),
          ),
        ),

        // Phone sending money
        Positioned(
          left: 50,
          child: Container(
            width: 60,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.phone_android,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
            .animate()
            .slideX(begin: 0, end: 0.3, duration: 2000.ms)
            .fadeIn(duration: 1000.ms),

        // Money flow animation
        Positioned(
          left: 120 + (_animation.value * 100),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),

        // M-Pesa logo
        Positioned(
          right: 50,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Center(
              child: Text(
                'M-Pesa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
            .animate()
            .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 2000.ms)
            .fadeIn(duration: 1000.ms, delay: 500.ms),
      ],
    );

  Widget _buildCalculatorCoinsAnimation() => Stack(
      alignment: Alignment.center,
      children: [
        // Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface.withOpacity(0.3),
                AppColors.accent.withOpacity(0.1),
              ],
            ),
          ),
        ),

        // Calculator
        Positioned(
          top: 80,
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.calculate,
              color: AppColors.primary,
              size: 40,
            ),
          ),
        )
            .animate()
            .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 2000.ms)
            .fadeIn(duration: 1000.ms),

        // Floating coins
        ...List.generate(3, (index) {
          return Positioned(
            left: 50 + (index * 40),
            top: 50 + (_animation.value * 20 * (index % 2 == 0 ? 1 : -1)),
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.monetization_on,
                color: Colors.white,
                size: 16,
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms, delay: (index * 200).ms).scale(
              begin: const Offset(0.5, 0.5),
              duration: 1000.ms,
              delay: (index * 200).ms);
        }),
      ],
    );

  Widget _buildKenyaMpesaAnimation() => Stack(
      alignment: Alignment.center,
      children: [
        // Background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface.withOpacity(0.3),
                AppColors.primary.withOpacity(0.1),
              ],
            ),
          ),
        ),

        // Kenya flag colors
        Positioned(
          top: 60,
          child: Row(
            children: [
              Container(
                width: 20,
                height: 60,
                color: Colors.black,
              ),
              Container(
                width: 20,
                height: 60,
                color: Colors.red,
              ),
              Container(
                width: 20,
                height: 60,
                color: Colors.green,
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 1000.ms)
            .slideY(begin: -0.5, duration: 1000.ms),

        // M-Pesa shield
        Positioned(
          bottom: 80,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(height: 4),
                Text(
                  'M-Pesa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
            .animate()
            .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
                duration: 2000.ms)
            .fadeIn(duration: 1000.ms, delay: 500.ms),

        // Trust badges
        Positioned(
          top: 40,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Trusted',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 1000.ms, delay: 1000.ms)
            .slideX(begin: -0.5, duration: 1000.ms, delay: 1000.ms),
      ],
    );

  Widget _buildDefaultAnimation() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface.withOpacity(0.3),
            AppColors.primary.withOpacity(0.1),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.monetization_on,
          color: AppColors.primary,
          size: 80,
        ),
      ),
    );
}
