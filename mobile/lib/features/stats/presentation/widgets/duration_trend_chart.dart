import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_chart_theme.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';

/// Line chart showing average session duration over the last 30 days.
///
/// Presents patterns over time without judgment or goals.
class DurationTrendChart extends StatelessWidget {
  final Map<DateTime, double> dailyAverageDurations; // date -> avg seconds

  const DurationTrendChart({super.key, required this.dailyAverageDurations});

  @override
  Widget build(BuildContext context) {
    if (dailyAverageDurations.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DURATION TRENDS', style: AppTypography.statLabel),
        SizedBox(height: AppSpacing.sm),
        Text('Average duration over time', style: AppTypography.caption),
        SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => AppColors.text.withOpacity(0.8),
                  tooltipRoundedRadius: 8,
                  tooltipPadding: EdgeInsets.all(AppSpacing.sm),
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final date = _getDateFromIndex(spot.x.toInt());
                      final duration = _formatDuration(spot.y.toInt());
                      return LineTooltipItem(
                        '${DateFormat('MMM d').format(date)}\n',
                        AppChartTheme.tooltipTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: duration,
                            style: AppChartTheme.tooltipTextStyle.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
              titlesData: AppChartTheme.getTitlesData(
                getBottomTitles: _getBottomTitles,
                getLeftTitles: _getLeftTitles,
              ),
              borderData: AppChartTheme.borderData,
              gridData: AppChartTheme.gridData,
              minY: 0,
              maxY: _getMaxValue() * 1.2,
              lineBarsData: [
                LineChartBarData(
                  spots: _buildSpots(),
                  isCurved: true,
                  curveSmoothness: 0.3,
                  color: AppChartTheme.lineColor,
                  barWidth: AppChartTheme.lineWidth,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.surface,
                        strokeWidth: 2,
                        strokeColor: AppChartTheme.lineColor,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppChartTheme.lineAreaColor.withOpacity(0.2),
                        AppChartTheme.lineAreaColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
            duration: AppAnimations.slow,
            curve: AppAnimations.gentle,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DURATION TRENDS', style: AppTypography.statLabel),
        SizedBox(height: AppSpacing.md),
        Text('Not enough data yet', style: AppTypography.emptyStateDescription),
      ],
    );
  }

  List<FlSpot> _buildSpots() {
    final sortedEntries = dailyAverageDurations.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return sortedEntries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.value);
    }).toList();
  }

  Widget _getBottomTitles(double value, TitleMeta meta) {
    final index = value.toInt();
    final sortedEntries = dailyAverageDurations.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    if (index < 0 || index >= sortedEntries.length) {
      return const SizedBox.shrink();
    }

    // Show labels for first, middle, and last dates
    final showLabel =
        index == 0 ||
        index == sortedEntries.length - 1 ||
        index == sortedEntries.length ~/ 2;

    if (showLabel) {
      final date = sortedEntries[index].key;
      return Padding(
        padding: EdgeInsets.only(top: AppSpacing.xs),
        child: Text(
          DateFormat('M/d').format(date),
          style: AppChartTheme.axisLabelStyle,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _getLeftTitles(double value, TitleMeta meta) {
    return Text(
      _formatDurationShort(value.toInt()),
      style: AppChartTheme.axisLabelStyle,
    );
  }

  DateTime _getDateFromIndex(int index) {
    final sortedEntries = dailyAverageDurations.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sortedEntries[index].key;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes == 0) {
      return '${secs}s';
    }
    return '${minutes}m ${secs}s';
  }

  String _formatDurationShort(int seconds) {
    final minutes = seconds ~/ 60;
    if (minutes == 0) return '0';
    if (minutes < 60) return '${minutes}m';
    final hours = minutes ~/ 60;
    return '${hours}h';
  }

  double _getMaxValue() {
    if (dailyAverageDurations.isEmpty) return 60.0;
    final max = dailyAverageDurations.values.reduce((a, b) => a > b ? a : b);
    return max;
  }
}
