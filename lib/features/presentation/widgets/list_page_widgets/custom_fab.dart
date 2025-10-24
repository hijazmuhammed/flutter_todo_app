import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Custom Floating Action Button with shadow and custom styling
/// Provides a consistent FAB design throughout the app
class CustomFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  
  const CustomFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor = AppColors.primary,
    this.iconColor = AppColors.background,
    this.size = 44,
    this.iconSize = 28,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.49),
            blurRadius: 18,
            offset: const Offset(2, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(size / 2),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

