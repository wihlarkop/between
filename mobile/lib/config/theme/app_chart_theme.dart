import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';

/// Chart styling configuration for Between's minimal aesthetic.
///
/// Principles:
/// - No gradients, no shadows
/// - Gray color palette only
/// - Thin lines and bars
/// - No animations (static, calm)
/// - Clean axes with minimal labels
/// - No grid lines (too busy)
class AppChartTheme {
  // Bar chart styling
  static const double barWidth = 8.0;
  static const double barBorderRadius = 4.0;
  static const Color barColor = AppColors.primaryLight;
  static const Color barBackgroundColor = AppColors.surfaceVariant;

  // Line chart styling
  static const double lineWidth = 2.0;
  static const Color lineColor = AppColors.primary;
  static const Color lineAreaColor = AppColors.surfaceVariant;
  static const double lineAreaOpacity = 0.3;

  // Axis styling
  static const Color axisColor = AppColors.divider;
  static const double axisBorderWidth = 1.0;
  static const TextStyle axisLabelStyle = TextStyle(
    fontSize: 10,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
  );

  // Grid styling (disabled by default)
  static const bool showGrid = false;
  static const Color gridColor = AppColors.divider;
  static const double gridLineWidth = 0.5;

  // Touch/interaction
  static const bool enableTouch = true;
  static const Color touchLineColor = AppColors.border;
  static const double touchLineWidth = 1.0;

  // Tooltip styling
  static BoxDecoration get tooltipDecoration => BoxDecoration(
    color: AppColors.text,
    borderRadius: BorderRadius.circular(4),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
    ],
  );

  static const TextStyle tooltipTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  // Common border data for charts
  static FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      left: BorderSide(color: axisColor, width: axisBorderWidth),
      bottom: BorderSide(color: axisColor, width: axisBorderWidth),
      right: BorderSide.none,
      top: BorderSide.none,
    ),
  );

  // Common grid data (hidden by default)
  static FlGridData get gridData => FlGridData(
    show: showGrid,
    drawVerticalLine: false,
    drawHorizontalLine: showGrid,
    horizontalInterval: 1,
    getDrawingHorizontalLine: (value) {
      return FlLine(color: gridColor, strokeWidth: gridLineWidth);
    },
  );

  // Common titles data
  static FlTitlesData getTitlesData({
    required Widget Function(double, TitleMeta) getBottomTitles,
    required Widget Function(double, TitleMeta) getLeftTitles,
  }) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getBottomTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: getLeftTitles,
        ),
      ),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  // Prevent instantiation
  AppChartTheme._();
}
