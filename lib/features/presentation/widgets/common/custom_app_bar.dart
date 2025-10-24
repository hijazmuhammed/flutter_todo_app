import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'custom_back_button.dart';

/// Reusable custom app bar with consistent styling
/// Includes back button and optional notification icon
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotification;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onBackPressed;
  
  const CustomAppBar({
    super.key,
    required this.title,
    this.showNotification = true,
    this.onNotificationPressed,
    this.onBackPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: CustomBackButton(
        onPressed: onBackPressed,
      ),
      title: Text(
        title,
        style: AppTextStyles.h2,
      ),
      centerTitle: true,
      actions: showNotification
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onNotificationPressed ?? () {},
                ),
              ),
            ]
          : null,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

