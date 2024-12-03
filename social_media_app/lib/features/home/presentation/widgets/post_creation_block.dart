import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class PostCreationBlock extends ConsumerWidget {
  const PostCreationBlock({super.key});

  Widget _buildAttachmentButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showLabel = true,
  }) {
    final button = Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: showLabel ? 12 : 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: showLabel
                ? Row(
                    children: [
                      Icon(icon, size: 20),
                      const SizedBox(width: 8),
                      Text(label),
                    ],
                  )
                : Icon(icon, size: 20),
          ),
        ),
      ),
    );

    return button;
  }

  Widget _buildPostButton({
    required BuildContext context,
    required String label,
    required bool showLabel,
  }) {
    if (showLabel) {
      return ElevatedButton.icon(
        onPressed: () {
          // Handle post creation
        },
        icon: const Icon(Icons.send),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
        ),
      );
    }

    // Mobile version - icon only
    return Tooltip(
      message: label,
      child: SizedBox(
        width: 40,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            // Handle post creation
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
          ),
          child: const Icon(Icons.send, size: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizer = ref.read(localizationProvider.notifier);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return ResponsiveCardWrapper(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: localizer.translate(context, 'whats_on_your_mind'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.image,
                            label: localizer.translate(context, 'image'),
                            onTap: () {
                              // Handle image attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.videocam,
                            label: localizer.translate(context, 'video'),
                            onTap: () {
                              // Handle video attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.book,
                            label: localizer.translate(context, 'book'),
                            onTap: () {
                              // Handle book attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.movie,
                            label: localizer.translate(context, 'movie'),
                            onTap: () {
                              // Handle movie attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.tv,
                            label: localizer.translate(context, 'series'),
                            onTap: () {
                              // Handle series attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.games,
                            label: localizer.translate(context, 'game'),
                            onTap: () {
                              // Handle game attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.mic,
                            label: localizer.translate(context, 'audio'),
                            onTap: () {
                              // Handle audio attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.music_note,
                            label: localizer.translate(context, 'music'),
                            onTap: () {
                              // Handle music attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                          _buildAttachmentButton(
                            context: context,
                            icon: Icons.location_on,
                            label: localizer.translate(context, 'location'),
                            onTap: () {
                              // Handle location attachment
                            },
                            showLabel: !isSmallScreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildPostButton(
                    context: context,
                    label: localizer.translate(context, 'post'),
                    showLabel: !isSmallScreen,
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
