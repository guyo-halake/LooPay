import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class BuyAirtimeScreen extends StatelessWidget {
  const BuyAirtimeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Buy Airtime'),
        backgroundColor: AppColors.warning,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Buy Airtime - Coming Soon'),
      ),
    );
}
