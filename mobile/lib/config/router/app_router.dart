import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:mobile/features/decision/presentation/screens/decision_screen.dart';
import 'package:mobile/features/decision/presentation/screens/decision_detail_screen.dart';
import 'package:mobile/features/decision/presentation/screens/decision_stats_screen.dart';
import 'package:mobile/features/decision/presentation/screens/edit_decision_screen.dart';
import 'package:mobile/features/home/presentation/screens/home_screen.dart';
import 'package:mobile/features/insights/presentation/screens/insights_screen.dart';
import 'package:mobile/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:mobile/features/silence/presentation/screens/silence_screen.dart';
import 'package:mobile/features/silence/presentation/screens/silence_history_screen.dart';
import 'package:mobile/features/activity/presentation/screens/activity_details_screen.dart';
import 'package:mobile/core/widgets/scaffold_with_nav_bar.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authProvider);

  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoggingIn = state.uri.path == '/login';
      final isRegistering = state.uri.path == '/register';

      if (!isLoggedIn && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return '/home';
      }

      // Redirect old root path to new home path for backwards compatibility
      if (state.uri.path == '/') {
        return '/home';
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home (Module Grid)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Branch 1: Insights (History + Analytics)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) => const InsightsScreen(),
              ),
            ],
          ),
          // Branch 2: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      // Module-specific routes (full-screen, outside bottom nav)
      GoRoute(
        path: '/silence/session',
        builder: (context, state) => const SilenceScreen(),
      ),
      GoRoute(
        path: '/silence/history',
        builder: (context, state) => const SilenceHistoryScreen(),
      ),
      GoRoute(
        path: '/decision/start',
        builder: (context, state) => const DecisionScreen(),
      ),
      GoRoute(
        path: '/decision/stats',
        builder: (context, state) => const DecisionStatsScreen(),
      ),
      GoRoute(
        path: '/decision/:id',
        builder: (context, state) {
          final decisionId = state.pathParameters['id']!;
          return DecisionDetailScreen(decisionId: decisionId);
        },
      ),
      GoRoute(
        path: '/decision/:id/edit',
        builder: (context, state) {
          final decisionId = state.pathParameters['id']!;
          return EditDecisionScreen(decisionId: decisionId);
        },
      ),
      GoRoute(
        path: '/activity/:id',
        builder: (context, state) {
          final activityId = state.pathParameters['id']!;
          return ActivityDetailsScreen(activityId: activityId);
        },
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
  );
}
