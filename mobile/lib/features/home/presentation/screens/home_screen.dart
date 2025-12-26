import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/modules/module_registry.dart';
import 'package:mobile/core/widgets/module_card.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/home/presentation/widgets/recent_activity_section.dart';

/// Home screen displaying module grid and recent activity
///
/// This is the main entry point of the app after login, showing all available
/// modules and cross-module recent activity.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ModuleRegistry().getAll();
    final authState = ref.watch(authProvider);
    final userName = authState.user?.fullname ?? 'There';

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with greeting
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenPaddingHorizontal,
                  AppSpacing.xl,
                  AppSpacing.screenPaddingHorizontal,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Module Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPaddingHorizontal,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ModuleCard(module: modules[index]);
                  },
                  childCount: modules.length,
                ),
              ),
            ),

            // Recent Activity Section
            const SliverToBoxAdapter(
              child: RecentActivitySection(),
            ),

            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xxl),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'GOOD MORNING';
    } else if (hour < 17) {
      return 'GOOD AFTERNOON';
    } else {
      return 'GOOD EVENING';
    }
  }
}
