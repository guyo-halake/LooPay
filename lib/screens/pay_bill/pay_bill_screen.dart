import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PayBillScreen extends StatelessWidget {
  const PayBillScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bill'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Pay Bill - Coming Soon'),
      ),
    );
}
