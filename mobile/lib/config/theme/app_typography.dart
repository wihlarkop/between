import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';

/// App-wide typography styles beyond Material theme defaults.
///
/// These styles are specifically designed for Between's minimalist,
/// calm aesthetic with focus on readability and visual hierarchy.
class AppTypography {
  // Timer styles - thin, monospaced, prominent
  static const TextStyle timerLarge = TextStyle(
    fontSize: 80,
    fontWeight: FontWeight.w200, // Extra thin for calm feel
    height: 1.0,
    color: AppColors.text,
    fontFeatures: [FontFeature.tabularFigures()], // Monospaced numbers
  );

  static const TextStyle timerMedium = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w200,
    height: 1.0,
    color: AppColors.text,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle timerSmall = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w300,
    height: 1.0,
    color: AppColors.text,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Page titles - for screen headers
  static const TextStyle pageTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.text,
  );

  // Stat display styles
  static const TextStyle statValue = TextStyle(
    fontSize: 36, // Larger for prominence
    fontWeight: FontWeight.w700, // Bolder for emphasis
    letterSpacing: -1.0, // Tighter for large numbers
    height: 1.2,
    color: AppColors.text,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 11, // Smaller for better hierarchy
    fontWeight: FontWeight.w600, // Bolder for readability
    letterSpacing: 1.5, // More spacing for small caps feel
    height: 1.3,
    color: AppColors.textSecondary,
  );

  // Status and context styles
  static const TextStyle statusText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    height: 1.2,
    color: AppColors.textSecondary,
  );

  static const TextStyle contextBadge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.2,
    color: AppColors.textSecondary,
  );

  // Empty and informational states
  static const TextStyle emptyStateTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.text,
  );

  static const TextStyle emptyStateDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  // Section headers
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
    color: AppColors.text,
  );

  // Helper text and captions
  static const TextStyle helperText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textDisabled,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textSecondary,
  );

  // Onboarding styles
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.text,
  );

  static const TextStyle onboardingBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  // Duration display (used in lists, cards)
  static const TextStyle durationText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // Prevent instantiation
  AppTypography._();
}
