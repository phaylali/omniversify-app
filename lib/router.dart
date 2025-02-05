import 'package:go_router/go_router.dart';
import 'package:social_media_app/pages/login_screen.dart';

import 'widgets/post_creation_screen.dart';
import 'pages/doom_scroll_screen.dart';
import 'pages/home_screen.dart';
import 'pages/profile_screen.dart';
import 'pages/settings_screen.dart';
import 'pages/tv_screen.dart';

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
      builder: (context, state) => const TvScreen(),
    ),
    GoRoute(
      path: '/new_post',
      builder: (context, state) => const PostCreationScreen(),
    ),
  ],
);
