import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/auth/register_screen.dart';
import '../../presentation/views/auth/onboarding_screen.dart';
import '../../presentation/views/quiz/personality_quiz_screen.dart';
import '../../presentation/views/dashboard/dashboard_screen.dart';
import '../../presentation/views/closet/closet_screen.dart';
import '../../presentation/views/closet/upload_clothing_screen.dart';
import '../../presentation/views/closet/clothing_detail_screen.dart';
import '../../presentation/views/outfits/outfit_suggestions_screen.dart';
import '../../presentation/views/outfits/virtual_tryon_screen.dart';
import '../../presentation/views/trends/global_trends_screen.dart';
import '../../presentation/views/trends/nearby_feed_screen.dart';
import '../../presentation/views/explore/explore_screen.dart';
import '../../presentation/views/settings/settings_screen.dart';
import '../../presentation/providers/auth_provider.dart';
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.maybeWhen(
        authenticated: (user) => true,
        orElse: () => false,
      );

      final isOnboardingComplete = authState.maybeWhen(
        authenticated: (user) => user.isOnboardingComplete,
        orElse: () => false,
      );

      final currentPath = state.uri.path;

      // If not logged in and trying to access protected routes
      if (!isLoggedIn) {
        if (currentPath == RouteNames.splash ||
            currentPath == RouteNames.login ||
            currentPath == RouteNames.register ||
            currentPath == RouteNames.onboarding) {
          return null; // Allow access to these routes
        }
        return RouteNames.login;
      }

      // If logged in but onboarding not complete
      if (isLoggedIn && !isOnboardingComplete) {
        if (currentPath == RouteNames.quiz) {
          return null; // Allow access to quiz
        }
        return RouteNames.quiz;
      }

      // If logged in and onboarding complete, redirect away from auth screens
      if (isLoggedIn && isOnboardingComplete) {
        if (currentPath == RouteNames.login ||
            currentPath == RouteNames.register ||
            currentPath == RouteNames.onboarding ||
            currentPath == RouteNames.quiz ||
            currentPath == RouteNames.splash) {
          return RouteNames.dashboard;
        }
      }

      return null;
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Personality Quiz
      GoRoute(
        path: RouteNames.quiz,
        name: RouteNames.quiz,
        builder: (context, state) => const PersonalityQuizScreen(),
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: RouteNames.dashboard,
            name: RouteNames.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),

          // Closet Routes
          GoRoute(
            path: RouteNames.closet,
            name: RouteNames.closet,
            builder: (context, state) => const ClosetScreen(),
            routes: [
              GoRoute(
                path: 'upload',
                name: RouteNames.uploadClothing,
                builder: (context, state) => const UploadClothingScreen(),
              ),
              GoRoute(
                path: 'item/:itemId',
                name: RouteNames.clothingDetail,
                builder: (context, state) {
                  final itemId = state.pathParameters['itemId']!;
                  return ClothingDetailScreen(itemId: itemId);
                },
              ),
            ],
          ),

          // Outfit Routes
          GoRoute(
            path: RouteNames.outfits,
            name: RouteNames.outfits,
            builder: (context, state) => const OutfitSuggestionsScreen(),
            routes: [
              GoRoute(
                path: 'virtual-tryon',
                name: RouteNames.virtualTryon,
                builder: (context, state) => const VirtualTryonScreen(),
              ),
            ],
          ),

          // Trends Routes
          GoRoute(
            path: RouteNames.trends,
            name: RouteNames.trends,
            builder: (context, state) => const GlobalTrendsScreen(),
            routes: [
              GoRoute(
                path: 'nearby',
                name: RouteNames.nearbyFeed,
                builder: (context, state) => const NearbyFeedScreen(),
              ),
            ],
          ),

          // Explore
          GoRoute(
            path: RouteNames.explore,
            name: RouteNames.explore,
            builder: (context, state) => const ExploreScreen(),
          ),

          // Settings
          GoRoute(
            path: RouteNames.settings,
            name: RouteNames.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.dashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

class MainShell extends ConsumerWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = GoRouterState.of(context).uri.path;

    int getCurrentIndex() {
      if (currentLocation.startsWith(RouteNames.closet)) return 1;
      if (currentLocation.startsWith(RouteNames.outfits)) return 2;
      if (currentLocation.startsWith(RouteNames.trends)) return 3;
      if (currentLocation.startsWith(RouteNames.explore)) return 4;
      return 0; // Dashboard
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(RouteNames.dashboard);
            break;
          case 1:
            context.go(RouteNames.closet);
            break;
          case 2:
            context.go(RouteNames.outfits);
            break;
          case 3:
            context.go(RouteNames.trends);
            break;
          case 4:
            context.go(RouteNames.explore);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checkroom_outlined),
          activeIcon: Icon(Icons.checkroom),
          label: 'Closet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.style_outlined),
          activeIcon: Icon(Icons.style),
          label: 'Outfits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_outlined),
          activeIcon: Icon(Icons.trending_up),
          label: 'Trends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Explore',
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate app initialization
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E1E2F),
              Color(0xFF2A2A3E),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6363),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6363).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.checkroom,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // App Name
              Text(
                'FitSync',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8),

              // Tagline
              Text(
                'AI-Powered Fashion Assistant',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 48),

              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFFF6363),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
