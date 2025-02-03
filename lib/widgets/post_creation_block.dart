import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart';
import '../providers/post_cration_provider.dart';
import 'responsive_card_wrapper.dart';
import '../models/attachment_models.dart';
import 'attachment_button.dart';

class PostCreationBlock extends ConsumerWidget {
  const PostCreationBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postCreationProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    Widget buildPostButton({
      required BuildContext context,
      required String label,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Tooltip(
          message: label,
          child: IconButton(
            onPressed: () {
              // Handle post creation
              state.textController.clear();
            },
            icon: const Icon(Icons.send, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12),
              disabledBackgroundColor: Theme.of(context).disabledColor,
            ),
          ),
        ),
      );
    }

    return ResponsiveCardWrapper(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  context.go('/create-post');
                },
                label: Text('data'),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 80,
                  maxHeight: screenHeight * 0.5,
                ),
                child: TextField(
                  controller: state.textController,
                  focusNode: state.focusNode,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.whats_on_your_mind,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    context.go('/create-post');
                  },
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 130,
                          child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 8,
                              children: [
                                AttachmentButton(
                                  attachment: AttachmentLink(url: ''),
                                ),
                                AttachmentButton(
                                  attachment: AttachmentImage(url: ''),
                                ),
                                AttachmentButton(
                                  attachment: AttachmentVideo(url: ''),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      buildPostButton(
                        context: context,
                        label: AppLocalizations.of(context)!.post,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
