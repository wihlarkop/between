import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: _EnhancedBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    // Haptic feedback on tap
    AppHaptics.light();

    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

/// Enhanced bottom navigation bar with smooth transitions and active indicators
class _EnhancedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _EnhancedBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.8),
            border: Border(
              top: BorderSide(
                color: AppColors.divider.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.grid_view_outlined,
                activeIcon: Icons.grid_view,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavBarItem(
                icon: Icons.insights_outlined,
                activeIcon: Icons.insights,
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
  }
}

/// Individual navigation bar item with animations
class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: AppAnimations.veryFast,
        curve: AppAnimations.gentle,
        child: Container(
          width: 60,
          height: 60,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Active indicator pill
              AnimatedContainer(
                duration: AppAnimations.medium,
                curve: AppAnimations.gentle,
                width: widget.isActive ? 24 : 0,
                height: 4,
                margin: EdgeInsets.only(bottom: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.text,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                ),
              ),

              // Icon with smooth transition
              AnimatedSwitcher(
                duration: AppAnimations.fast,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  widget.isActive ? widget.activeIcon : widget.icon,
                  key: ValueKey(widget.isActive),
                  color: widget.isActive ? AppColors.text : AppColors.textDisabled,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
