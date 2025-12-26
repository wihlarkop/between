import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/features/history/presentation/providers/session_history_provider.dart';
import 'package:mobile/features/silence/presentation/providers/session_provider.dart';
import 'package:mobile/core/widgets/app_snackbar.dart';
import 'package:mobile/features/silence/presentation/widgets/context_dialog.dart';
import 'package:mobile/features/silence/presentation/widgets/ambient_background.dart';

class SilenceScreen extends ConsumerStatefulWidget {
  const SilenceScreen({super.key});

  @override
  ConsumerState<SilenceScreen> createState() => _SilenceScreenState();
}

class _SilenceScreenState extends ConsumerState<SilenceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();

    // Setup breathing animation for active session button
    _breathingController = AnimationController(
      duration: AppAnimations.breathing,
      vsync: this,
    );

    _breathingAnimation =
        Tween<double>(
          begin: AppAnimations.breathingOpacityMin,
          end: AppAnimations.breathingOpacityMax,
        ).animate(
          CurvedAnimation(
            parent: _breathingController,
            curve: AppAnimations.linear,
          ),
        );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionProvider);

    // Control breathing animation based on session state
    if (sessionState.hasActiveSession && !_breathingController.isAnimating) {
      _breathingController.repeat(reverse: true);
    } else if (!sessionState.hasActiveSession &&
        _breathingController.isAnimating) {
      _breathingController.stop();
      _breathingController.reset();
    }

    // Check for approaching max duration (6 hours = 21600 seconds)
    final approachingMax = sessionState.currentDuration > 20700; // 5h 45min

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Silence',
          style: AppTypography.sectionHeader.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Session History',
            onPressed: () => context.push('/silence/history'),
          ),
        ],
      ),
      body: AmbientBackground(
        isActive: sessionState.hasActiveSession,
        child: SafeArea(
          top: false, // AppBar already provides top safe area
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingHorizontal,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status text with fade and color animation
                  AnimatedSwitcher(
                    duration: AppAnimations.medium,
                    child: Text(
                      sessionState.hasActiveSession ? 'Focus' : 'Ready',
                      key: ValueKey(sessionState.hasActiveSession),
                      style: AppTypography.statusText.copyWith(
                        color: sessionState.hasActiveSession
                            ? AppColors.moduleSilence
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.xxl),

                  // The Hero Timer with subtle glow when active
                  Container(
                    decoration: sessionState.hasActiveSession
                        ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.moduleSilence.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ],
                          )
                        : null,
                    child: Text(
                      _formatDuration(
                        sessionState.hasActiveSession
                            ? sessionState.currentDuration
                            : 0,
                      ),
                      style: AppTypography.timerLarge,
                    ),
                  ),

                  // Duration warning when approaching max
                  if (approachingMax) ...[
                    SizedBox(height: AppSpacing.md),
                    AnimatedOpacity(
                      opacity: approachingMax ? 1.0 : 0.0,
                      duration: AppAnimations.slow,
                      child: Text(
                        'Approaching 6 hour limit',
                        style: AppTypography.helperText.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: AppSpacing.xxxl + AppSpacing.md),

                  // The Main Action Button with animations
                  _ActionButton(
                    isActive: sessionState.hasActiveSession,
                    isLoading: sessionState.isLoading,
                    breathingAnimation: _breathingAnimation,
                    onTap: sessionState.isLoading
                        ? null
                        : () =>
                              _handleSessionAction(context, ref, sessionState),
                  ),

                  if (sessionState.error != null) ...[
                    SizedBox(height: AppSpacing.xl),
                    Text(
                      sessionState.error!,
                      style: const TextStyle(color: AppColors.error),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSessionAction(
    BuildContext context,
    WidgetRef ref,
    SessionState state,
  ) async {
    // Haptic feedback for interaction
    await AppHaptics.medium();

    if (state.hasActiveSession) {
      final session = await ref.read(sessionProvider.notifier).endSession();
      if (session != null && context.mounted) {
        await AppHaptics.success();

        // Show context dialog and wait for result
        final saved = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ContextDialog(sessionId: session.id),
        );

        // Auto-refresh history after dialog closes (check mounted first)
        if (context.mounted) {
          ref.read(sessionHistoryProvider.notifier).refresh();
        }

        // Show success message after dialog closes
        if (saved == true && context.mounted) {
          AppSnackBar.showSuccess(context, message: 'Context saved');
        }
      }
    } else {
      await ref.read(sessionProvider.notifier).startSession();
      await AppHaptics.success();
    }
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }
}

/// The main action button with scale animation and breathing effect
class _ActionButton extends StatefulWidget {
  final bool isActive;
  final bool isLoading;
  final Animation<double> breathingAnimation;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.isActive,
    required this.isLoading,
    required this.breathingAnimation,
    this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null
          ? (_) {
              setState(() => _isPressed = true);
              AppHaptics.light();
            }
          : null,
      onTapUp: widget.onTap != null
          ? (_) {
              setState(() => _isPressed = false);
              widget.onTap?.call();
            }
          : null,
      onTapCancel: widget.onTap != null
          ? () => setState(() => _isPressed = false)
          : null,
      child: AnimatedScale(
        scale: _isPressed ? AppAnimations.buttonPressScale : 1.0,
        duration: AppAnimations.veryFast,
        curve: AppAnimations.gentle,
        child: AnimatedBuilder(
          animation: widget.breathingAnimation,
          builder: (context, child) {
            return AnimatedContainer(
              duration: AppAnimations.medium,
              curve: AppAnimations.gentle,
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isActive ? AppColors.surface : Colors.black,
                border: widget.isActive
                    ? Border.all(color: AppColors.text, width: 3)
                    : null,
                boxShadow: widget.isActive
                    ? [
                        // Subtle module-colored pulse shadow
                        BoxShadow(
                          color: AppColors.moduleSilence.withOpacity(
                              0.15 * widget.breathingAnimation.value),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                        // Base shadow for depth
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
              ),
              child: Opacity(
                opacity: widget.isActive
                    ? widget.breathingAnimation.value
                    : 1.0,
                child: Center(
                  child: widget.isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: widget.isActive ? Colors.black : Colors.white,
                        )
                      : Icon(
                          widget.isActive ? Icons.stop : Icons.play_arrow,
                          size: 48,
                          color: widget.isActive ? Colors.black : Colors.white,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
