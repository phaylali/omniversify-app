import 'package:flutter_riverpod/flutter_riverpod.dart';

final isExpandedProvider = StateNotifierProvider.family<IsExpandedNotifier, bool, String>((ref, postId) {
  return IsExpandedNotifier();
});

class IsExpandedNotifier extends StateNotifier<bool> {
  IsExpandedNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}
