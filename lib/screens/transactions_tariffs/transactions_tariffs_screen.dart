import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TransactionsTariffsScreen extends StatelessWidget {
  const TransactionsTariffsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Transactions & Tariffs'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Transactions & Tariffs - Coming Soon'),
      ),
    );
}
