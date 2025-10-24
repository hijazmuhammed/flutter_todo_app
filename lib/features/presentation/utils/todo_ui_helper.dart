import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Helper class to determine UI properties based on todo data
/// Separates presentation logic from UI widgets
class TodoUiHelper {
  /// Get icon background color based on todo title
  static Color getIconBackgroundColor(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('office')) {
      return AppColors.iconBgPink;
    } else if (lowerTitle.contains('personal')) {
      return AppColors.iconBgPurple;
    } else if (lowerTitle.contains('study')) {
      return AppColors.iconBgOrange;
    } else {
      return AppColors.iconBgYellow;
    }
  }

  /// Get icon color based on todo title
  static Color getIconColor(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('office')) {
      return AppColors.iconPink;
    } else if (lowerTitle.contains('personal')) {
      return AppColors.iconPurple;
    } else if (lowerTitle.contains('study')) {
      return AppColors.iconOrange;
    } else {
      return AppColors.iconYellow;
    }
  }

  /// Get icon data based on todo title
  static IconData getIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('office')) {
      return Icons.business;
    } else if (lowerTitle.contains('personal')) {
      return Icons.person;
    } else if (lowerTitle.contains('study')) {
      return Icons.book;
    } else {
      return Icons.task;
    }
  }
}

