import 'package:flutter_riverpod/flutter_riverpod.dart';

final isExpandedProvider =
    StateNotifierProvider.family<IsExpandedNotifier, bool, String>(
        (ref, postId) {
  return IsExpandedNotifier();
});

class IsExpandedNotifier extends StateNotifier<bool> {
  IsExpandedNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = duration.inHours > 0 ? '${duration.inHours}:' : '';
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$hours$minutes:$seconds';
}

String formatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d';
  } else {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
