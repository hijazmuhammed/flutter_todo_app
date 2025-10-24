import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

// Reusable card container with consistent shadow and styling
// Used for input fields, todo cards, and other elevated content
class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double borderRadius;
  
  const CardContainer({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius = 15,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 32,
            offset: Offset(0, 4),
          ),
        ],
      ),
      // Add clipBehavior to prevent overflow/gaps
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}