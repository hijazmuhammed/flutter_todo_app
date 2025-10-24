import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Reusable gradient background widget
/// Automatically applies the app's standard gradient from AppColors
/// Expands to fill all available space
class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({
    super.key,
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradientColors,
        ),
      ),
      child: child,
    );
  }
}

