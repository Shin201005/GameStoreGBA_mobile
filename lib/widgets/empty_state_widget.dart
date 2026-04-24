import 'package:flutter/material.dart';
import '../main.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 60, color: AppColors.textSoft),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: AppColors.textSoft, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
