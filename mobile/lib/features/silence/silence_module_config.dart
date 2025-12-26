import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/modules/module_config.dart';

/// Configuration for the Silence module
///
/// This module allows users to track periods of conscious silence in their daily lives.
class SilenceModuleConfig extends ModuleConfig {
  @override
  String get id => ModuleConstants.silence;

  @override
  String get name => ModuleConstants.silenceName;

  @override
  String get description => 'Log periods of conscious silence';

  @override
  IconData get icon => Icons.circle_outlined;

  @override
  Color get accentColor => AppColors.primary;

  @override
  String get baseRoute => '/silence';

  @override
  Future<String?> getQuickStat() async {
    // TODO: Fetch from stats provider
    // For now, return null - can be implemented later to show
    // stats like "3 sessions today" or "Total: 2h 30m"
    return null;
  }

  @override
  void onTap(BuildContext context) {
    // Navigate to the silence session screen
    context.go('/silence/session');
  }
}
