import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';

/// Reusable status badge widget
/// Displays completion status with consistent styling
class StatusBadge extends StatelessWidget {
  final bool isCompleted;
  
  const StatusBadge({
    super.key,
    required this.isCompleted,
  });
  
  @override
  Widget build(BuildContext context) {
    if (!isCompleted) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.iconBgLightPurple,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        AppStrings.done,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

