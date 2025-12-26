import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'module_filter_provider.g.dart';

/// Provider for the currently selected module filter in Insights screen
///
/// null = "All Modules"
/// 'silence' = Silence module only
/// 'decision' = Decision module only
/// etc.
@riverpod
class SelectedModuleFilter extends _$SelectedModuleFilter {
  @override
  String? build() {
    // Default to "All Modules" (null)
    return null;
  }

  /// Set the module filter
  void setFilter(String? moduleId) {
    state = moduleId;
  }

  /// Clear the filter (show all modules)
  void clearFilter() {
    state = null;
  }

  /// Check if a specific module is selected
  bool isFilteredBy(String moduleId) {
    return state == moduleId;
  }

  /// Check if showing all modules
  bool get isShowingAll => state == null;
}
