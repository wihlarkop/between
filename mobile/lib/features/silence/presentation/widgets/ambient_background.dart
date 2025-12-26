import 'package:flutter/material.dart';
import 'package:mobile/config/theme/app_colors.dart';

class AmbientBackground extends StatefulWidget {
  final bool isActive;
  final bool lowPowerMode;
  final Widget child;
  final Color? ambientColor;

  const AmbientBackground({
    super.key,
    required this.isActive,
    this.lowPowerMode = false,
    required this.child,
    this.ambientColor,
  });

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // For throttling updates in low power mode
  final ValueNotifier<double> _throttledValue = ValueNotifier(0.8);
  int _lastUpdateTime = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animation.addListener(_handleAnimationUpdate);

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  void _handleAnimationUpdate() {
    if (widget.lowPowerMode) {
      final now = DateTime.now().millisecondsSinceEpoch;
      // Throttle to ~15 FPS (66ms) in low power mode
      if (now - _lastUpdateTime >= 66) {
        _lastUpdateTime = now;
        _throttledValue.value = _animation.value;
      }
    } else {
      _throttledValue.value = _animation.value;
    }
  }

  @override
  void didUpdateWidget(AmbientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
      _controller.animateTo(0, duration: const Duration(milliseconds: 500));
    }
  }

  @override
  void dispose() {
    _animation.removeListener(_handleAnimationUpdate);
    _controller.dispose();
    _throttledValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.ambientColor ?? AppColors.moduleSilence;

    return Stack(
      children: [
        if (widget.isActive)
          ValueListenableBuilder<double>(
            valueListenable: _throttledValue,
            builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      effectiveColor.withOpacity(0.05 * value),
                      Colors.transparent,
                    ],
                    radius: 1.5 * value,
                  ),
                ),
              );
            },
          ),
        widget.child,
      ],
    );
  }
}
