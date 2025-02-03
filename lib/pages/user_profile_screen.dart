import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/follow_provider.dart';
import '../widgets/follow_button.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = ref.watch(isFollowingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: FollowButton(
          isFollowing: isFollowing,
          onPressed: () {
            ref.read(isFollowingProvider.notifier).toggleFollowing();
          },
        ),
      ),
    );
  }
}
