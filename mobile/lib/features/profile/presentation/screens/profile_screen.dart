import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/config/theme/app_animations.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/utils/haptic_feedback.dart';
import 'package:mobile/core/utils/timezone_helper.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/profile/presentation/providers/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: AppAnimations.medium,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.gentle,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: AppAnimations.gentle,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), elevation: 0),
      body: user == null
          ? const Center(child: Text('Not logged in'))
          : FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.screenPaddingHorizontal,
                    AppSpacing.screenPaddingHorizontal,
                    AppSpacing.screenPaddingHorizontal,
                    120, // Bottom padding for glass nav bar
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar with scale animation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 48), // Spacer for balance
                          Center(
                            child: TweenAnimationBuilder<double>(
                              duration: AppAnimations.slow,
                              curve: AppAnimations.gentle,
                              tween: Tween(begin: 0.8, end: 1.0),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surfaceVariant,
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    user.fullname[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.push('/edit-profile'),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: AppColors.textSecondary,
                            ),
                            tooltip: 'Edit Profile',
                          ),
                        ],
                      ),

                      SizedBox(height: AppSpacing.xl),

                      // User Info Section
                      Text('ACCOUNT', style: AppTypography.statLabel),

                      SizedBox(height: AppSpacing.sm),

                      _ProfileCard(
                        children: [
                          _ProfileItem(
                            icon: Icons.person_outline,
                            label: 'Name',
                            value: user.fullname,
                          ),
                          Divider(height: 1, color: AppColors.divider),
                          _ProfileItem(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: user.email,
                          ),
                          Divider(height: 1, color: AppColors.divider),
                          _ProfileItem(
                            icon: Icons.schedule_outlined,
                            label: 'Timezone',
                            value: user.timezone,
                            onTap: () => _showTimezoneUpdateDialog(context),
                            trailing: const Icon(
                              Icons.edit_outlined,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSpacing.xl),

                      // Logout Section
                      Text('ACTIONS', style: AppTypography.statLabel),

                      SizedBox(height: AppSpacing.sm),

                      _ProfileCard(
                        children: [
                          _LogoutButton(
                            onLogout: () => _showLogoutConfirmation(context),
                          ),
                        ],
                      ),

                      SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    await AppHaptics.light();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        titleTextStyle: AppTypography.onboardingTitle.copyWith(fontSize: 20),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await AppHaptics.medium();
      await ref.read(authProvider.notifier).logout();
    }
  }

  Future<void> _showTimezoneUpdateDialog(BuildContext context) async {
    await AppHaptics.light();

    final currentTimezone = ref.read(authProvider).user?.timezone ?? 'UTC';

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Timezone'),
        titleTextStyle: AppTypography.onboardingTitle.copyWith(fontSize: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current timezone: $currentTimezone',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Would you like to update to your current device timezone?',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newTimezone = await TimezoneHelper.getCurrentTimezone();
              if (context.mounted) {
                Navigator.of(context).pop(newTimezone);
              }
            },
            child: const Text('Auto-Detect'),
          ),
        ],
      ),
    );

    if (result != null && context.mounted) {
      await AppHaptics.medium();

      // Update timezone via profile provider
      await ref.read(profileProvider.notifier).updateTimezone(result);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Timezone updated to $result'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }
}

/// Card container for profile items
class _ProfileCard extends StatelessWidget {
  final List<Widget> children;

  const _ProfileCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }
}

/// Individual profile item with icon
class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _ProfileItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTypography.caption),
                SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: content,
      );
    }

    return content;
  }
}

/// Logout button
class _LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const _LogoutButton({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onLogout,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(Icons.logout, size: 20, color: AppColors.error),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.error,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: AppColors.textDisabled),
          ],
        ),
      ),
    );
  }
}
