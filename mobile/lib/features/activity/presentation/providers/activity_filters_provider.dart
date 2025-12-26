import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_filters_provider.g.dart';

@riverpod
class ActivityDateRangeFilter extends _$ActivityDateRangeFilter {
  @override
  DateTimeRange? build() {
    return null; // Default: no date filter
  }

  void setDateRange(DateTimeRange? range) {
    state = range;
  }

  void clearDateRange() {
    state = null;
  }
}
