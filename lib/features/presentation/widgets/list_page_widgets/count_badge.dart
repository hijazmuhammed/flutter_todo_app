import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Small circular badge displaying a count
/// Used for showing number of todos, notifications, etc.
class CountBadge extends StatelessWidget {
  final int count;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  
  const CountBadge({
    super.key,
    required this.count,
    this.backgroundColor = AppColors.iconBgLightPurple,
    this.textColor = AppColors.primary,
    this.size = 16,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: AppTextStyles.bodySmall.copyWith(
            color: textColor,
            fontSize: size * 0.6875, // 11px when size is 16
          ),
        ),
      ),
    );
  }
}

