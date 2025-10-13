import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class SplitFriendsScreen extends StatelessWidget {
  const SplitFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Split with Friends'),
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Split with Friends - Coming Soon'),
      ),
    );
}
