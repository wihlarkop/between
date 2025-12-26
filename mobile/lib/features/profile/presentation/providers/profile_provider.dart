import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/auth/presentation/providers/providers.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  /// Update user's timezone
  Future<void> updateTimezone(String timezone) async {
    if (!ref.mounted) return;

    state = const AsyncValue.loading();

    try {
      // Get current user to preserve their fullname
      final currentUser = ref.read(authProvider).user;
      if (currentUser == null) {
        throw Exception('User not found');
      }

      if (!ref.mounted) return;

      final profileRepository = ref.read(profileRepositoryProvider);
      await profileRepository.updateProfile(
        fullname: currentUser.fullname,
        timezone: timezone,
        password: '', // Empty password means no change
      );

      if (!ref.mounted) return;

      // Refresh auth state to get updated user
      await ref.read(authProvider.notifier).checkAuthStatus();

      if (!ref.mounted) return;

      state = const AsyncValue.data(null);
      Logger.log('Timezone updated to: $timezone', tag: 'ProfileProvider');
    } catch (e, st) {
      Logger.error('Failed to update timezone', error: e, stackTrace: st);
      if (ref.mounted) {
        state = AsyncValue.error(e, st);
      }
      rethrow;
    }
  }
}
