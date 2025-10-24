import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Modal position variants
enum ModalPosition { bottom, center }

/// Modal size variants
enum ModalSize { small, medium, large }

/// Modal type variants (affects colors and icons)
enum ModalType { success, error, warning, info, neutral }

/// Custom reusable modal with multiple variants
/// Supports bottom sheet and center dialog styles
class CustomModal {
  /// Show a modal with the specified configuration
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    ModalPosition position = ModalPosition.center,
    ModalSize size = ModalSize.medium,
    ModalType type = ModalType.neutral,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool isDismissible = true,
    bool showCloseButton = true,
  }) {
    switch (position) {
      case ModalPosition.bottom:
        return _showBottomModal<T>(
          context: context,
          title: title,
          message: message,
          size: size,
          type: type,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryPressed: onPrimaryPressed,
          onSecondaryPressed: onSecondaryPressed,
          customContent: customContent,
          isDismissible: isDismissible,
          showCloseButton: showCloseButton,
        );
      case ModalPosition.center:
        return _showCenterModal<T>(
          context: context,
          title: title,
          message: message,
          size: size,
          type: type,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryPressed: onPrimaryPressed,
          onSecondaryPressed: onSecondaryPressed,
          customContent: customContent,
          isDismissible: isDismissible,
          showCloseButton: showCloseButton,
        );
    }
  }
  
  static Future<T?> _showBottomModal<T>({
    required BuildContext context,
    required String title,
    required String message,
    required ModalSize size,
    required ModalType type,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    required bool isDismissible,
    required bool showCloseButton,
  }) {
    final dimensions = _getModalDimensions(size);
    
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: dimensions.maxHeight,
        ),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            if (isDismissible) ...[
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
            ] else
              const SizedBox(height: 20),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: _ModalContent(
                  title: title,
                  message: message,
                  type: type,
                  primaryButtonText: primaryButtonText,
                  secondaryButtonText: secondaryButtonText,
                  onPrimaryPressed: onPrimaryPressed,
                  onSecondaryPressed: onSecondaryPressed,
                  customContent: customContent,
                  showCloseButton: showCloseButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  static Future<T?> _showCenterModal<T>({
    required BuildContext context,
    required String title,
    required String message,
    required ModalSize size,
    required ModalType type,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    required bool isDismissible,
    required bool showCloseButton,
  }) {
    final dimensions = _getModalDimensions(size);
    
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => Dialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: dimensions.maxWidth,
            maxHeight: dimensions.maxHeight,
          ),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: _ModalContent(
              title: title,
              message: message,
              type: type,
              primaryButtonText: primaryButtonText,
              secondaryButtonText: secondaryButtonText,
              onPrimaryPressed: onPrimaryPressed,
              onSecondaryPressed: onSecondaryPressed,
              customContent: customContent,
              showCloseButton: showCloseButton,
            ),
          ),
        ),
      ),
    );
  }
  
  static _ModalDimensions _getModalDimensions(ModalSize size) {
    switch (size) {
      case ModalSize.small:
        return _ModalDimensions(maxWidth: 300, maxHeight: 300);
      case ModalSize.medium:
        return _ModalDimensions(maxWidth: 400, maxHeight: 500);
      case ModalSize.large:
        return _ModalDimensions(maxWidth: 500, maxHeight: 700);
    }
  }
}

class _ModalContent extends StatelessWidget {
  final String title;
  final String message;
  final ModalType type;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Widget? customContent;
  final bool showCloseButton;
  
  const _ModalContent({
    required this.title,
    required this.message,
    required this.type,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.customContent,
    required this.showCloseButton,
  });
  
  @override
  Widget build(BuildContext context) {
    final typeConfig = _getTypeConfig();
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button
        if (showCloseButton)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        
        // Icon
        if (typeConfig.icon != null) ...[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: typeConfig.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              typeConfig.icon,
              size: 32,
              color: typeConfig.iconColor,
            ),
          ),
          const SizedBox(height: 16),
        ],
        
        // Title
        Text(
          title,
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        
        // Message
        Text(
          message,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        
        // Custom content
        if (customContent != null) ...[
          const SizedBox(height: 16),
          customContent!,
        ],
        
        // Buttons
        if (primaryButtonText != null || secondaryButtonText != null) ...[
          const SizedBox(height: 24),
          Row(
            children: [
              if (secondaryButtonText != null) ...[
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onSecondaryPressed?.call();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.textSecondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        secondaryButtonText!,
                        style: AppTextStyles.buttonMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              if (primaryButtonText != null)
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPrimaryPressed?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: typeConfig.primaryButtonColor,
                        foregroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        primaryButtonText!,
                        style: AppTextStyles.buttonMedium.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
  
  _ModalTypeConfig _getTypeConfig() {
    switch (type) {
      case ModalType.success:
        return _ModalTypeConfig(
          icon: Icons.check_circle,
          iconColor: AppColors.success,
          backgroundColor: AppColors.success.withOpacity(0.1),
          primaryButtonColor: AppColors.primary,
        );
      case ModalType.error:
        return _ModalTypeConfig(
          icon: Icons.error,
          iconColor: AppColors.error,
          backgroundColor: AppColors.error.withOpacity(0.1),
          primaryButtonColor: AppColors.error,
        );
      case ModalType.warning:
        return _ModalTypeConfig(
          icon: Icons.warning,
          iconColor: AppColors.warning,
          backgroundColor: AppColors.warning.withOpacity(0.1),
          primaryButtonColor: AppColors.warning,
        );
      case ModalType.info:
        return _ModalTypeConfig(
          icon: Icons.info,
          iconColor: AppColors.info,
          backgroundColor: AppColors.info.withOpacity(0.1),
          primaryButtonColor: AppColors.info,
        );
      case ModalType.neutral:
        return _ModalTypeConfig(
          icon: null,
          iconColor: AppColors.primary,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          primaryButtonColor: AppColors.primary,
        );
    }
  }
}

class _ModalDimensions {
  final double maxWidth;
  final double maxHeight;
  
  _ModalDimensions({required this.maxWidth, required this.maxHeight});
}

class _ModalTypeConfig {
  final IconData? icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color primaryButtonColor;
  
  _ModalTypeConfig({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.primaryButtonColor,
  });
}

