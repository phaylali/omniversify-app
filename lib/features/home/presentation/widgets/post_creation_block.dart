import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/post_cration_provider.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostCreationBlock extends ConsumerWidget {
  const PostCreationBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postCreationProvider);
    //final notifier = ref.read(postCreationProvider.notifier);
    
    final screenHeight = MediaQuery.of(context).size.height;
Widget buildAttachmentButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: label,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
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
                          child: Wrap(direction: Axis.horizontal,
                            //controller: _scrollController,
                            //scrollDirection: Axis.horizontal,
                           // physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.image,
                                label: AppLocalizations.of(context)!.image,
                                onTap: () {
                                  // Handle image attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.videocam,
                                label: AppLocalizations.of(context)!.video,
                                onTap: () {
                                  // Handle video attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.book,
                                label: AppLocalizations.of(context)!.book,
                                onTap: () {
                                  // Handle book attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.link,
                                label: AppLocalizations.of(context)!.link,
                                onTap: () {
                                  // Handle link attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.gif,
                                label: AppLocalizations.of(context)!.gif,
                                onTap: () {
                                  // Handle GIF attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.poll,
                                label: AppLocalizations.of(context)!.poll,
                                onTap: () {
                                  // Handle poll creation
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.tv,
                                label: AppLocalizations.of(context)!.series,
                                onTap: () {
                                  // Handle series attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.movie,
                                label: AppLocalizations.of(context)!.movie,
                                onTap: () {
                                  // Handle movie attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.location_on,
                                label: AppLocalizations.of(context)!.location,
                                onTap: () {
                                  // Handle location attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.music_note,
                                label: AppLocalizations.of(context)!.music,
                                onTap: () {
                                  // Handle music attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.mic,
                                label: AppLocalizations.of(context)!.audio,
                                onTap: () {
                                  // Handle audio attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.sports_esports,
                                label: AppLocalizations.of(context)!.game,
                                onTap: () {
                                  // Handle game attachment
                                },
                              ),
                              const SizedBox(width: 2),
                              buildAttachmentButton(
                                context: context,
                                icon: Icons.local_activity,
                                label: AppLocalizations.of(context)!.activity,
                                onTap: () {
                                  // Handle activity attachment
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
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