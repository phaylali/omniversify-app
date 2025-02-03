import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/attachment_models.dart';

final attachmentListProvider =
    StateNotifierProvider<AttachmentListNotifier, List<Attachment>>((ref) {
  return AttachmentListNotifier();
});

class AttachmentListNotifier extends StateNotifier<List<Attachment>> {
  AttachmentListNotifier() : super([]);

  void addAttachment(Attachment attachment) {
    state = [...state, attachment];
  }

  void removeAttachment(Attachment attachment) {
    state = state.where((a) => a != attachment).toList();
  }
}
