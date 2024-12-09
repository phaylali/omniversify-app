import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/doom_scroll/presentation/doom_scroll_screen.dart';
import '../../features/tv/presentation/pages/tv_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
        routes: [
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: 'settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
          ),
          GoRoute(
            path: 'doom-scroll',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const DoomScrollScreen(),
            ),
          ),
          GoRoute(
            path: 'tv',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const TvPage(),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('Navigation Error: ${state.error}'),
        ),
      ),
    ),
  );
});

// Navigation Extension for easier navigation
extension NavigationExtension on BuildContext {
  void goToHome() => go('/');
  void goToProfile() => go('/profile');
  void goToSettings() => go('/settings');
  void goToDoomScroll() => go('/doom-scroll');
  void goToTv() => go('/tv');
}
