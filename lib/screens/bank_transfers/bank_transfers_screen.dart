import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class BankTransfersScreen extends StatelessWidget {
  const BankTransfersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Bank Transfers'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Bank Transfers - Coming Soon'),
      ),
    );
}
