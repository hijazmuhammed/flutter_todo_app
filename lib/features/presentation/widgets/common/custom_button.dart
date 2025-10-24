import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Button size variants
enum ButtonSize { small, medium, large }

/// Button style variants
enum ButtonVariant { primary, success, error, warning, info, secondary, outline }

/// Custom reusable button with multiple size and style variants
/// Provides consistent button styling throughout the app
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool iconRight;
  
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconRight = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final dimensions = _getDimensions();
    final colors = _getColors();
    final textStyle = _getTextStyle();
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: dimensions.height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.foreground,
          disabledBackgroundColor: colors.background.withOpacity(0.5),
          disabledForegroundColor: colors.foreground.withOpacity(0.5),
          elevation: variant == ButtonVariant.outline ? 0 : 2,
          shadowColor: colors.background.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.borderRadius),
            side: variant == ButtonVariant.outline
                ? BorderSide(color: colors.background, width: 1.5)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: dimensions.horizontalPadding,
            vertical: dimensions.verticalPadding,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: dimensions.iconSize,
                height: dimensions.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.foreground),
                ),
              )
            : _buildContent(textStyle, dimensions.iconSize),
      ),
    );
  }
  
  Widget _buildContent(TextStyle textStyle, double iconSize) {
    if (icon == null) {
      return Text(text, style: textStyle);
    }
    
    final iconWidget = Icon(icon, size: iconSize);
    final textWidget = Text(text, style: textStyle);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconRight
          ? [textWidget, SizedBox(width: iconSize * 0.4), iconWidget]
          : [iconWidget, SizedBox(width: iconSize * 0.4), textWidget],
    );
  }
  
  _ButtonDimensions _getDimensions() {
    switch (size) {
      case ButtonSize.small:
        return _ButtonDimensions(
          height: 36,
          horizontalPadding: 16,
          verticalPadding: 8,
          borderRadius: 10,
          iconSize: 16,
        );
      case ButtonSize.medium:
        return _ButtonDimensions(
          height: 44,
          horizontalPadding: 20,
          verticalPadding: 12,
          borderRadius: 12,
          iconSize: 20,
        );
      case ButtonSize.large:
        return _ButtonDimensions(
          height: 52,
          horizontalPadding: 24,
          verticalPadding: 14,
          borderRadius: 14,
          iconSize: 24,
        );
    }
  }
  
  _ButtonColors _getColors() {
    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          background: AppColors.primary,
          foreground: AppColors.background,
        );
      case ButtonVariant.success:
        return _ButtonColors(
          background: AppColors.success,
          foreground: AppColors.background,
        );
      case ButtonVariant.error:
        return _ButtonColors(
          background: AppColors.error,
          foreground: AppColors.background,
        );
      case ButtonVariant.warning:
        return _ButtonColors(
          background: AppColors.warning,
          foreground: AppColors.background,
        );
      case ButtonVariant.info:
        return _ButtonColors(
          background: AppColors.info,
          foreground: AppColors.background,
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          background: AppColors.iconBgLightPurple,
          foreground: AppColors.primary,
        );
      case ButtonVariant.outline:
        return _ButtonColors(
          background: AppColors.primary,
          foreground: AppColors.primary,
        );
    }
  }
  
  TextStyle _getTextStyle() {
    final baseStyle = size == ButtonSize.large
        ? AppTextStyles.buttonLarge
        : AppTextStyles.buttonMedium;
    
    return baseStyle.copyWith(
      color: variant == ButtonVariant.outline || variant == ButtonVariant.secondary
          ? _getColors().foreground
          : AppColors.background,
      fontSize: size == ButtonSize.small ? 12 : baseStyle.fontSize,
    );
  }
}

class _ButtonDimensions {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double iconSize;
  
  _ButtonDimensions({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
    required this.iconSize,
  });
}

class _ButtonColors {
  final Color background;
  final Color foreground;
  
  _ButtonColors({
    required this.background,
    required this.foreground,
  });
}

