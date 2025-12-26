import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/core/utils/logger.dart';
import 'package:mobile/features/auth/domain/entities/user.dart';
import 'providers.dart';

part 'auth_provider.g.dart';

// Auth state
class AuthState {
  final bool isAuthenticated;
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Auth state notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    checkAuthStatus();
    return const AuthState();
  }

  Future<void> checkAuthStatus() async {
    final authRepository = ref.read(authRepositoryProvider);
    final profileRepository = ref.read(profileRepositoryProvider);
    final isAuth = await authRepository.isAuthenticated();

    if (isAuth) {
      final result = await profileRepository.getProfile();
      result.fold(
        (failure) {
          Logger.warning(
            'Token is valid but profile fetch failed: ${failure.message}',
            tag: 'AuthProvider',
          );
          state = state.copyWith(isAuthenticated: false);
        },
        (user) {
          state = state.copyWith(isAuthenticated: true, user: user);
        },
      );
    } else {
      state = state.copyWith(isAuthenticated: false);
    }
  }

  Future<bool> register({
    required String fullname,
    required String email,
    required String password,
    required String timezone,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.register(
      fullname: fullname,
      email: email,
      password: password,
      timezone: timezone,
    );

    return result.fold(
      (failure) {
        Logger.error(
          'Registration failed',
          tag: 'AuthProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (authResponse) async {
        Logger.log('Registration successful', tag: 'AuthProvider');
        // Fetch profile explicitly
        await checkAuthStatus();
        state = state.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.login(email: email, password: password);

    return result.fold(
      (failure) {
        Logger.error(
          'Login failed',
          tag: 'AuthProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (authResponse) async {
        Logger.log('Login successful', tag: 'AuthProvider');
        // Fetch profile explicitly
        await checkAuthStatus();
        state = state.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.logout();

    result.fold(
      (failure) {
        Logger.error(
          'Logout failed, forcing local logout',
          tag: 'AuthProvider',
          error: failure.message,
        );
        forceLogout();
      },
      (_) {
        Logger.log('Logout successful', tag: 'AuthProvider');
        state = const AuthState(isAuthenticated: false);
      },
    );
  }

  Future<bool> updateProfile({
    String? fullname,
    String? timezone,
    String? password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final profileRepository = ref.read(profileRepositoryProvider);
    final result = await profileRepository.updateProfile(
      fullname: fullname,
      timezone: timezone,
      password: password,
    );

    return result.fold(
      (failure) {
        Logger.error(
          'Profile update failed',
          tag: 'AuthProvider',
          error: failure.message,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (_) async {
        Logger.log('Profile update successful', tag: 'AuthProvider');
        // Refresh profile data
        await checkAuthStatus();
        state = state.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  void forceLogout() {
    Logger.warning('Forcing local logout', tag: 'AuthProvider');
    state = const AuthState(isAuthenticated: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
