import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class SavingsGoalsScreen extends StatelessWidget {
  const SavingsGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Savings & Goals'),
        backgroundColor: AppColors.success,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Savings & Goals - Coming Soon'),
      ),
    );
}
