import 'package:flutter/material.dart';

import 'package:mobile/config/theme/app_colors.dart';

/// A themed circular progress indicator with consistent sizing.
///
/// Provides a calm, minimal loading indicator that matches the app's aesthetic.
class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;

  const LoadingIndicator({
    super.key,
    this.color,
    this.size = 20.0,
    this.strokeWidth = 2.0,
  });

  /// Small loading indicator (16px)
  const LoadingIndicator.small({super.key, this.color})
    : size = 16.0,
      strokeWidth = 2.0;

  /// Medium loading indicator (20px) - default
  const LoadingIndicator.medium({super.key, this.color})
    : size = 20.0,
      strokeWidth = 2.0;

  /// Large loading indicator (32px)
  const LoadingIndicator.large({super.key, this.color})
    : size = 32.0,
      strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }
}

/// A centered loading indicator with optional message.
///
/// Use this for full-screen loading states.
class CenteredLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;

  const CenteredLoadingIndicator({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingIndicator(color: color),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: color ?? AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
/// A skeleton loader with a subtle shimmering effect.
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surfaceVariant,
                AppColors.border,
                AppColors.surfaceVariant,
              ],
              stops: [
                0.0,
                _controller.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}
