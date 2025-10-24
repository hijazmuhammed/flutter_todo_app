import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headers - using Lexend Deca font family from Figma
  static TextStyle get h1 => GoogleFonts.lexendDeca(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get h2 => GoogleFonts.lexendDeca(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get h3 => GoogleFonts.lexendDeca(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  // Body text
  static TextStyle get bodyLarge => GoogleFonts.lexendDeca(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.lexendDeca(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get bodySmall => GoogleFonts.lexendDeca(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: AppColors.textSecondary,
  );
  
  // Button text
  static TextStyle get buttonLarge => GoogleFonts.lexendDeca(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.background,
  );
  
  static TextStyle get buttonMedium => GoogleFonts.lexendDeca(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  // Caption
  static TextStyle get caption => GoogleFonts.lexendDeca(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: AppColors.textSecondary,
  );
  
  // Label
  static TextStyle get labelLarge => GoogleFonts.lexendDeca(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.textPrimary,
  );
  
  static TextStyle get labelMedium => GoogleFonts.lexendDeca(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.textSecondary,
  );
  
  static TextStyle get labelSmall => GoogleFonts.lexendDeca(
    fontSize: 9,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.textSecondary,
  );
}

