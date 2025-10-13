import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Crypto'),
        backgroundColor: AppColors.textSecondary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Crypto - Coming Soon'),
      ),
    );
}
