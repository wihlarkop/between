import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_chart_theme.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';

/// Bar chart showing when silence sessions occur throughout the day (0-23 hours).
///
/// Shows distribution of sessions by hour without judgment,
/// just observation of patterns.
class TimeDistributionChart extends StatelessWidget {
  final Map<int, int> hourlyDistribution; // hour -> session count

  const TimeDistributionChart({super.key, required this.hourlyDistribution});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TIME DISTRIBUTION', style: AppTypography.statLabel),
        SizedBox(height: AppSpacing.sm),
        Text('When silence occurs', style: AppTypography.caption),
        SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxValue() * 1.2, // 20% padding on top
              minY: 0,
              barTouchData: BarTouchData(
                enabled: AppChartTheme.enableTouch,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => AppColors.text,
                  tooltipRoundedRadius: 4,
                  tooltipPadding: EdgeInsets.all(AppSpacing.sm),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final hour = group.x.toInt();
                    final count = rod.toY.toInt();
                    return BarTooltipItem(
                      '${_formatHour(hour)}\n$count ${count == 1 ? 'session' : 'sessions'}',
                      AppChartTheme.tooltipTextStyle,
                    );
                  },
                ),
              ),
              titlesData: AppChartTheme.getTitlesData(
                getBottomTitles: _getBottomTitles,
                getLeftTitles: _getLeftTitles,
              ),
              borderData: AppChartTheme.borderData,
              gridData: AppChartTheme.gridData,
              barGroups: _buildBarGroups(),
            ),
            swapAnimationDuration: Duration.zero, // No animations
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    // Create bars for all 24 hours
    final bars = <BarChartGroupData>[];

    for (int hour = 0; hour < 24; hour++) {
      final count = hourlyDistribution[hour] ?? 0;
      bars.add(
        BarChartGroupData(
          x: hour,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: count > 0
                  ? AppChartTheme.barColor
                  : AppChartTheme.barBackgroundColor,
              width: AppChartTheme.barWidth,
              borderRadius: BorderRadius.circular(
                AppChartTheme.barBorderRadius,
              ),
            ),
          ],
        ),
      );
    }

    return bars;
  }

  Widget _getBottomTitles(double value, TitleMeta meta) {
    final hour = value.toInt();
    // Show only 0, 6, 12, 18 hours to avoid clutter
    if (hour % 6 == 0) {
      return Padding(
        padding: EdgeInsets.only(top: AppSpacing.xs),
        child: Text(_formatHour(hour), style: AppChartTheme.axisLabelStyle),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _getLeftTitles(double value, TitleMeta meta) {
    // Show only whole numbers
    if (value == value.toInt()) {
      return Text(
        value.toInt().toString(),
        style: AppChartTheme.axisLabelStyle,
      );
    }
    return const SizedBox.shrink();
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12AM';
    if (hour < 12) return '${hour}AM';
    if (hour == 12) return '12PM';
    return '${hour - 12}PM';
  }

  double _getMaxValue() {
    if (hourlyDistribution.isEmpty) return 5.0;
    final max = hourlyDistribution.values.reduce((a, b) => a > b ? a : b);
    return max.toDouble();
  }
}
