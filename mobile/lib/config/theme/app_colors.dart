import 'package:flutter/material.dart';

class AppColors {
  // Brand colors - calm blue for wellness
  static const Color primary = Color(0xFF4F8ECC); // Soft Blue - serene and trustworthy
  static const Color primaryDark = Color(0xFF3A6FA8); // Deeper blue for active states
  static const Color primaryLight = Color(0xFF7AABDC); // Lighter blue for subtle accents

  // Module-specific colors (subtle, not overwhelming)
  static const Color moduleSilence = Color(0xFF4F8ECC); // Cool Blue - calm, focus
  static const Color moduleDecision = Color(0xFFE8A657); // Warm Amber - energy, clarity

  // Backgrounds - grayscale foundation
  static const Color background = Color(0xFFF9FAFB); // Gray-50
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceVariant = Color(0xFFF3F4F6); // Gray-100

  // Text hierarchy
  static const Color text = Color(0xFF111827); // Gray-900 - primary text
  static const Color textSecondary = Color(0xFF4B5563); // Gray-700 - secondary (improved readability)
  static const Color textTertiary = Color(0xFF6B7280); // Gray-500 - tertiary
  static const Color textDisabled = Color(0xFF9CA3AF); // Gray-400 - disabled

  // Borders & dividers
  static const Color border = Color(0xFFE5E7EB); // Gray-200
  static const Color divider = Color(0xFFE5E7EB); // Gray-200

  // Semantic colors
  static const Color error = Color(0xFFDC2626); // Red-600
  static const Color errorLight = Color(0xFFFEE2E2); // Red-100

  static const Color success = Color(0xFF059669); // Green-600
  static const Color successLight = Color(0xFFD1FAE5); // Green-100

  static const Color warning = Color(0xFFF59E0B); // Amber-500 - for approaching limits
  static const Color warningLight = Color(0xFFFEF3C7); // Amber-100

  // Deprecated - use module colors instead
  @Deprecated('Use AppColors.moduleSilence instead')
  static const Color silenceInactive = Color(0xFF9CA3AF); // Gray-400
  @Deprecated('Use AppColors.moduleSilence instead')
  static const Color silenceActive = Color(0xFF4B5563); // Gray-600
}
