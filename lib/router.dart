import 'package:go_router/go_router.dart';
import 'package:social_media_app/pages/login.dart';

import 'pages/doom_scroll_screen.dart';
import 'pages/home_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/settings_screen.dart';
import 'pages/tv_page.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/scroll',
      builder: (context, state) => const DoomScrollScreen(),
    ),
    GoRoute(
      path: '/tv',
      builder: (context, state) => const TvPage(),
    ),
  ],
);
