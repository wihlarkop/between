import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/core/constants/module_constants.dart';
import 'package:mobile/core/modules/module_config.dart';
import 'package:mobile/features/decision/presentation/providers/decision_provider.dart';

class DecisionModuleConfig extends ModuleConfig {
  final WidgetRef? _ref;

  DecisionModuleConfig([this._ref]);

  @override
  String get id => ModuleConstants.decision;

  @override
  String get name => ModuleConstants.decisionName;

  @override
  String get description => 'Track decisions and their outcomes';

  @override
  IconData get icon => Icons.lightbulb_outline;

  @override
  Color get accentColor => AppColors.primary;

  @override
  String get baseRoute => '/decision';

  @override
  Future<String?> getQuickStat() async {
    if (_ref == null) return null;

    try {
      final stats = await _ref.read(decisionStatsProvider.future);
      if (stats.pendingDecisions > 0) {
        return '${stats.pendingDecisions} pending';
      }
      return '${stats.totalDecisions} total';
    } catch (e) {
      return null;
    }
  }

  @override
  void onTap(BuildContext context) {
    context.go('/decision/start');
  }
}
