import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile/config/env/env.dart';
import 'package:mobile/config/env/env_config.dart';
import 'package:mobile/config/router/app_router.dart';
import 'package:mobile/config/theme/app_theme.dart';
import 'package:mobile/core/modules/module_registry.dart';
import 'package:mobile/core/providers/common_providers.dart';
import 'package:mobile/core/utils/timezone_helper.dart';
import 'package:mobile/features/decision/decision_module_config.dart';
import 'package:mobile/features/silence/presentation/providers/session_provider.dart';
import 'package:mobile/features/silence/presentation/widgets/context_dialog.dart';
import 'package:mobile/features/silence/silence_module_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configuration
  const environment = String.fromEnvironment('ENV', defaultValue: 'dev');
  await Env.load(
    environment: environment == 'prod'
        ? Environment.prod
        : environment == 'staging'
        ? Environment.staging
        : Environment.dev,
  );

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize timezone database
  await TimezoneHelper.initialize();

  // Register modules
  final registry = ModuleRegistry();
  registry.register(SilenceModuleConfig());
  registry.register(DecisionModuleConfig());

  runApp(
    ProviderScope(
      overrides: [
        // Override the sharedPreferences provider with actual instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Between',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

// Temporary home page to test the app
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Between - Silence Module'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => GoRouter.of(context).push('/stats'),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => GoRouter.of(context).push('/history'),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Between'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Environment: ${String.fromEnvironment('ENV', defaultValue: 'dev')}',
                      ),
                      const SizedBox(height: 8),
                      Text('API: ${Env.apiBaseUrl}'),
                      const SizedBox(height: 16),
                      const Text(
                        'A minimalist, observational tool for consciously logging periods of silence.',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer display
              if (sessionState.hasActiveSession) ...[
                Text(
                  _formatDuration(sessionState.currentDuration),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Silence in progress',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 48),
              ] else ...[
                const Icon(
                  Icons.radio_button_unchecked,
                  size: 80,
                  color: Colors.grey,
                ),
                const SizedBox(height: 24),
                Text(
                  'No active session',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 48),
              ],

              // Start/Stop button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: sessionState.isLoading
                      ? null
                      : () async {
                          if (sessionState.hasActiveSession) {
                            final session = await ref
                                .read(sessionProvider.notifier)
                                .endSession();
                            if (session != null && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Silence ended. Duration: ${session.durationSeconds}s',
                                  ),
                                ),
                              );

                              // Show context dialog
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    ContextDialog(sessionId: session.id),
                              );
                            }
                          } else {
                            final success = await ref
                                .read(sessionProvider.notifier)
                                .startSession();
                            if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Silence started'),
                                ),
                              );
                            }
                          }
                        },
                  child: sessionState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          sessionState.hasActiveSession
                              ? 'End Silence'
                              : 'Start Silence',
                        ),
                ),
              ),

              // Error display
              if (sessionState.error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sessionState.error!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 48),

              // Info text
              const Text(
                'This is a basic implementation.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Full UI with auth, history, stats, and context selection still needs to be built.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }
}
