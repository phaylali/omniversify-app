import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCreationState {
  final TextEditingController textController;
  final FocusNode focusNode;


  PostCreationState({
    required this.textController,
    required this.focusNode,

  });

  PostCreationState copyWith({
    TextEditingController? textController,
    FocusNode? focusNode,

  }) {
    return PostCreationState(
      textController: textController ?? this.textController,
      focusNode: focusNode ?? this.focusNode,

    );
  }
}

class PostCreationNotifier extends StateNotifier<PostCreationState> {
  PostCreationNotifier()
      : super(PostCreationState(
          textController: TextEditingController(),
          focusNode: FocusNode(),

        ));




  void handlePost() {
    state.textController.clear();
  }

  @override
  void dispose() {
    state.focusNode.dispose();
    state.textController.dispose();
    super.dispose();
  }
}

final postCreationProvider =
    StateNotifierProvider<PostCreationNotifier, PostCreationState>((ref) {
  return PostCreationNotifier();
});
