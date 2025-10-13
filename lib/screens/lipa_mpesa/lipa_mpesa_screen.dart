import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class LipaMpesaScreen extends StatelessWidget {
  const LipaMpesaScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Lipa na M-Pesa'),
        backgroundColor: AppColors.info,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Lipa na M-Pesa - Coming Soon'),
      ),
    );
}
