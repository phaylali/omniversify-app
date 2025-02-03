import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFollowingProvider = StateNotifierProvider<IsFollowingNotifier, bool>((ref) {
  return IsFollowingNotifier();
});

class IsFollowingNotifier extends StateNotifier<bool> {
  IsFollowingNotifier() : super(false);

  void toggleFollowing() {
    state = !state;
  }
}
