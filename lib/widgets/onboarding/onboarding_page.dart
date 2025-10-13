import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/app_colors.dart';

class OnboardingData {

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.particles,
  });
  final String title;
  final String subtitle;
  final String description;
  final String icon;
  final List<Color> gradient;
  final List<String> particles;
}

class OnboardingPage extends StatefulWidget {

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isActive,
  });
  final OnboardingData data;
  final bool isActive;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _glowController;
  late Animation<double> _iconAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _iconAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _iconController.forward();
      _textController.forward();
      _glowController.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _iconController.reset();
      _textController.reset();
      _glowController.stop();
    }
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CYBER ICON CONTAINER
          AnimatedBuilder(
            animation: Listenable.merge([_iconAnimation, _glowAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _iconAnimation.value,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.data.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: widget.data.gradient[0]
                            .withOpacity(0.4 + 0.3 * _glowAnimation.value),
                        blurRadius: 30 + 20 * _glowAnimation.value,
                        spreadRadius: 5 + 3 * _glowAnimation.value,
                      ),
                      BoxShadow(
                        color: widget.data.gradient[1]
                            .withOpacity(0.3 + 0.2 * _glowAnimation.value),
                        blurRadius: 60 + 30 * _glowAnimation.value,
                        spreadRadius: 10 + 5 * _glowAnimation.value,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.data.icon,
                      style: const TextStyle(
                        fontSize: 80,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 60),

          // CYBER TITLE
          AnimatedBuilder(
            animation: _textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - _textAnimation.value)),
                child: Opacity(
                  opacity: _textAnimation.value,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: widget.data.gradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds),
                    child: Text(
                      widget.data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // CYBER SUBTITLE
          AnimatedBuilder(
            animation: _textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - _textAnimation.value)),
                child: Opacity(
                  opacity: _textAnimation.value * 0.9,
                  child: Text(
                    widget.data.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: widget.data.gradient[0],
                      height: 1.2,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // CYBER DESCRIPTION
          AnimatedBuilder(
            animation: _textAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 15 * (1 - _textAnimation.value)),
                child: Opacity(
                  opacity: _textAnimation.value * 0.8,
                  child: Text(
                    widget.data.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.4,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
}
