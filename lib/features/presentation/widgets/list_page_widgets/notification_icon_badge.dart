import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Notification icon with optional badge indicator
/// Shows a small red dot when there are notifications
class NotificationIconBadge extends StatelessWidget {
  final bool showBadge;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color badgeColor;
  final double iconSize;
  
  const NotificationIconBadge({
    super.key,
    this.showBadge = true,
    this.onTap,
    this.iconColor = AppColors.primary,
    this.badgeColor = AppColors.primary,
    this.iconSize = 24,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(
            child: Icon(
              Icons.notifications,
              color: iconColor,
              size: iconSize,
            ),
          ),
          if (showBadge)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

