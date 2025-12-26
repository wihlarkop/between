import 'package:flutter/material.dart';
import 'package:mobile/config/theme/app_colors.dart';
import 'package:mobile/config/theme/app_spacing.dart';

class PaginationLoader extends StatelessWidget {
  final bool hasMore;

  const PaginationLoader({
    super.key,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMore) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
