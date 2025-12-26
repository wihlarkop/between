import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';
import 'package:mobile/config/theme/app_typography.dart';
import 'package:mobile/core/modules/module_registry.dart';
import 'package:mobile/features/insights/presentation/providers/module_filter_provider.dart';

class ModuleFilterDropdown extends ConsumerWidget {
  const ModuleFilterDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModule = ref.watch(selectedModuleFilterProvider);
    final registry = ModuleRegistry();
    final modules = registry.getAll();

    return PopupMenuButton<String?>(
      icon: Icon(
        Icons.filter_list,
        color: AppColors.text,
      ),
      tooltip: 'Filter by module',
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        side: BorderSide(
          color: AppColors.border,
          width: 0.5,
        ),
      ),
      color: AppColors.surface,
      onSelected: (String? moduleId) {
        ref.read(selectedModuleFilterProvider.notifier).setFilter(moduleId);
      },
      itemBuilder: (BuildContext context) {
        return [
          // "All Modules" option
          PopupMenuItem<String?>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.grid_view,
                  size: 20,
                  color: selectedModule == null
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                SizedBox(width: AppSpacing.sm),
                Text(
                  'All Modules',
                  style: AppTypography.caption.copyWith(
                    fontSize: 14,
                    color: selectedModule == null
                        ? AppColors.primary
                        : AppColors.text,
                    fontWeight: selectedModule == null
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ),
                if (selectedModule == null) ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ],
              ],
            ),
          ),

          // Divider
          const PopupMenuDivider(),

          // Module options
          ...modules.map((module) {
            final isSelected = selectedModule == module.id;
            return PopupMenuItem<String?>(
              value: module.id,
              child: Row(
                children: [
                  Icon(
                    module.icon,
                    size: 20,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    module.name,
                    style: AppTypography.caption.copyWith(
                      fontSize: 14,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.text,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                  if (isSelected) ...[
                    const Spacer(),
                    Icon(
                      Icons.check,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ],
                ],
              ),
            );
          }),
        ];
      },
    );
  }
}
