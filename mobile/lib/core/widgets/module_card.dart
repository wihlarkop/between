import 'package:flutter/material.dart';
import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/modules/module_config.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/core/widgets/elevated_card.dart';

/// A card widget displaying a module with its icon, name, and optional quick stat
///
/// Features colored icon backgrounds and subtle elevation for visual interest
/// while maintaining the app's calm aesthetic.
class ModuleCard extends StatefulWidget {
  final ModuleConfig module;

  const ModuleCard({
    super.key,
    required this.module,
  });

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        AppHaptics.light();
        widget.module.onTap(context);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: AppAnimations.veryFast,
        curve: AppAnimations.gentle,
        child: ElevatedCard(
          elevation: CardElevation.elevated,
          mode: CardElevationMode.shadow,
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Colored circular icon background
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.module.accentColor.withOpacity(0.1),
                ),
                child: Icon(
                  widget.module.icon,
                  size: 28,
                  color: widget.module.accentColor,
                ),
              ),
              SizedBox(height: AppSpacing.md),

              // Module name
              Text(
                widget.module.name,
                style: AppTypography.durationText.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.xs),

              // Quick stat (if available)
              FutureBuilder<String?>(
                future: widget.module.getQuickStat(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: widget.module.accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                      ),
                      child: Text(
                        snapshot.data!,
                        style: AppTypography.caption.copyWith(
                          color: widget.module.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
