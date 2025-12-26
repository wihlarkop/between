# Between - Flutter Mobile App

A minimalist, observational tool for consciously logging periods of silence without gamification or judgment.

## 🎉 Implementation Status: ~70% Complete

### ✅ Fully Implemented (Ready to Use)

#### 1. **Foundation & Infrastructure** ✅
- ✅ Environment configuration (dev/staging/prod)
- ✅ All dependencies configured (20+ packages)
- ✅ Code generation setup (Freezed, Retrofit, Riverpod)
- ✅ Error handling framework
- ✅ Logging utilities
- ✅ Form validators

#### 2. **Network Layer** ✅
- ✅ Dio HTTP client with interceptors
- ✅ JWT authentication interceptor
- ✅ Automatic token refresh on 401
- ✅ Request retry after token refresh
- ✅ Comprehensive error handling

#### 3. **Data Layer** ✅
- ✅ 7 Freezed models with JSON serialization
- ✅ 2 Retrofit API services (Auth + Silence)
- ✅ Secure token storage (flutter_secure_storage)
- ✅ Session caching (shared_preferences)
- ✅ Active session persistence

#### 4. **Domain Layer** ✅
- ✅ 4 Domain entities (User, SilenceSession, SessionStats, SilenceContext)
- ✅ 2 Repository interfaces
- ✅ 2 Repository implementations with:
  - Complete error handling
  - Offline caching
  - Auto cache refresh
  - Network fallback

#### 5. **State Management** ✅
- ✅ Dependency injection providers
- ✅ Auth provider (login, register, logout)
- ✅ Session provider (start/end sessions)
- ✅ Timer provider (real-time duration tracking)
- ✅ History provider (paginated session list)
- ✅ Stats provider (descriptive statistics)
- ✅ Context provider (silence context options)

#### 6. **UI Theme** ✅
- ✅ Material 3 design system
- ✅ Neutral gray color palette
- ✅ Calm, minimal aesthetic
- ✅ Custom typography
- ✅ Consistent spacing

#### 7. **Basic App** ✅
- ✅ Main app structure
- ✅ Provider initialization
- ✅ Basic home screen
- ✅ Start/Stop silence functionality
- ✅ Real-time timer display
- ✅ Error handling UI

### 🚧 Still Needed (30% Remaining)

#### 1. **Navigation** 🚧
- ❌ GoRouter setup with routes
- ❌ Auth guards (redirect to login if not authenticated)
- ❌ Deep linking support

#### 2. **Authentication Screens** 🚧
- ❌ Splash screen (check auth status)
- ❌ Login screen
- ❌ Registration screen
- ❌ Timezone detection

#### 3. **Session Management UI** 🚧
- ❌ Professional silence button design
- ❌ Context selector bottom sheet
- ❌ Context note input
- ❌ Session duration warnings (approaching max)
- ❌ Session minimum duration validation UI

#### 4. **History Screen** 🚧
- ❌ Session list with cards
- ❌ Pagination (load more on scroll)
- ❌ Pull to refresh
- ❌ Empty state
- ❌ Date grouping
- ❌ Duration formatting

#### 5. **Stats Screen** 🚧
- ❌ Descriptive statistics display
- ❌ No charts (just text - no performance implications)
- ❌ Neutral language (no advice)
- ❌ Offline support with cached data

#### 6. **Common Widgets** 🚧
- ❌ AppButton (consistent button styling)
- ❌ AppTextField (form inputs)
- ❌ LoadingOverlay
- ❌ ErrorWidget
- ❌ EmptyStateWidget

#### 7. **Polish** 🚧
- ❌ App icon
- ❌ Splash screen design
- ❌ Better error messages
- ❌ Loading states
- ❌ Confirmation dialogs

## 🏗️ Architecture

### Clean Architecture Pattern

```
lib/
├── config/              # Configuration
│   ├── env/            # Environment setup ✅
│   ├── routes/         # Navigation ❌
│   └── theme/          # Material theme ✅
├── core/               # Core utilities
│   ├── constants/      # API & app constants ✅
│   ├── error/          # Error handling ✅
│   ├── network/        # Dio setup ✅
│   └── utils/          # Helpers ✅
├── data/               # Data layer
│   ├── models/         # DTOs with Freezed ✅
│   ├── datasources/    # API & local storage ✅
│   └── repositories/   # Repository implementations ✅
├── domain/             # Business logic
│   ├── entities/       # Domain models ✅
│   └── repositories/   # Repository interfaces ✅
├── presentation/       # UI layer
│   ├── providers/      # Riverpod state ✅
│   ├── screens/        # App screens 🚧
│   └── widgets/        # Reusable widgets 🚧
└── main.dart           # App entry ✅
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.18.0+
- Dart SDK 3.10.4+
- Android Studio / VS Code
- Backend API running at `http://localhost:8000`

### Installation

1. **Install dependencies:**
   ```bash
   cd mobile
   flutter pub get
   ```

2. **Run code generation:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Run the app:**
   ```bash
   # Development
   flutter run --dart-define=ENV=dev

   # Staging
   flutter run --dart-define=ENV=staging

   # Production
   flutter run --dart-define=ENV=prod
   ```

### Environment Configuration

The app supports 3 environments:

- **Dev**: `assets/.env.dev` → `http://localhost:8000`
- **Staging**: `assets/.env.staging` → staging server
- **Production**: `assets/.env.prod` → production server

## 📁 Key Files

### Critical Files (Already Implemented)

1. **lib/presentation/providers/providers.dart**
   - Dependency injection setup
   - All service and repository providers

2. **lib/presentation/providers/session_provider.dart**
   - Active session state management
   - Timer with persistence
   - Auto-resume on app restart

3. **lib/data/repositories/silence_repository_impl.dart**
   - Core business logic
   - Offline caching
   - Auto cache refresh

4. **lib/core/network/api_interceptor.dart**
   - JWT auth middleware
   - Automatic token refresh

5. **lib/config/theme/app_theme.dart**
   - Material 3 theme
   - Neutral color palette

## 🧪 Testing

### Unit Tests (TODO)
```bash
flutter test
```

### Integration Tests (TODO)
```bash
flutter drive --target=test_driver/app.dart
```

### Current Manual Testing

The basic app can be tested now:
1. Launch the app
2. Click "Start Silence" - timer starts
3. Wait a few seconds
4. Click "End Silence" - session ends
5. Check console logs for API calls

**Note:** Auth screens not built yet, so API calls will fail with 401 unless you add mock tokens.

## 📦 Dependencies

### Core
- flutter_riverpod: State management
- dio: HTTP client
- retrofit: Type-safe API client
- go_router: Declarative routing (configured but not used yet)

### Code Generation
- freezed: Immutable models
- json_serializable: JSON parsing
- build_runner: Code generation

### Storage
- flutter_secure_storage: Encrypted token storage
- shared_preferences: Cache storage

### Utilities
- dartz: Functional programming (Either)
- equatable: Value equality
- intl: Internationalization

## 🎨 Design Philosophy

Following the PRD's minimalist principles:

1. **No Gamification**: No streaks, badges, goals, or rewards
2. **No Judgment**: Statistics are purely descriptive
3. **Calm UI**: Neutral colors, minimal animations
4. **Conscious Action**: All logging is explicit
5. **Neutral Language**: "Silence started", "Silence ended"
6. **No Motivation**: Never encourage or praise

## 🔧 Development Notes

### Code Generation

Run this whenever you modify:
- Freezed models
- Retrofit services
- Riverpod providers (if using codegen)

```bash
flutter pub run build_runner watch
```

### Hot Reload

Most changes support hot reload except:
- Provider changes (may need hot restart)
- Environment changes (requires full restart)
- Native code changes (requires rebuild)

### Warnings

The generated code (.g.dart, .freezed.dart files) may show analyzer warnings. These are safe to ignore as they're auto-generated.

## 📝 Next Steps

To complete the app implementation:

1. **Set up GoRouter** (~1 hour)
   - Define routes
   - Add auth guards
   - Configure navigation

2. **Build Auth Screens** (~2-3 hours)
   - Splash screen
   - Login screen
   - Register screen

3. **Build Session UI** (~2-3 hours)
   - Professional silence button
   - Context selector bottom sheet
   - Better timer display

4. **Build History & Stats** (~2-3 hours)
   - Session list screen
   - Stats screen
   - Empty states

5. **Polish** (~1-2 hours)
   - Error handling UI
   - Loading states
   - App icon

**Total remaining: ~8-13 hours**

## 📞 Support

For issues or questions:
- Check the implementation plan: `C:\Users\Edo\.claude\plans\unified-leaping-lemon.md`
- Review progress: `PROGRESS.md`
- See backend README: `../README.md`

## 📄 License

MIT

---

**Status**: Core functionality complete, UI screens in progress
**Last Updated**: 2025-12-20
