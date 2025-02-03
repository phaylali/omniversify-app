import 'package:flutter_gen/gen_l10n/app_localizations.dart';

ResponsiveCardWrapper(
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
                  hintText: AppLocalizations.of(context)!.whats_on_your_mind,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.image,
                      label: AppLocalizations.of(context)!.image,
                      onTap: () {
                        // Handle image attachment
                      },
                    ),
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.videocam,
                      label: AppLocalizations.of(context)!.video,
                      onTap: () {
                        // Handle video attachment
                      },
                    ),
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.book,
                      label: AppLocalizations.of(context)!.book,
                      onTap: () {
                        // Handle book attachment
                      },
                    ),
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.link,
                      label: AppLocalizations.of(context)!.link,
                      onTap: () {
                        // Handle link attachment
                      },
                    ),
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.gif,
                      label: AppLocalizations.of(context)!.gif,
                      onTap: () {
                        // Handle GIF attachment
                      },
                    ),
                    _buildAttachmentButton(
                      context: context,
                      icon: Icons.poll,
                      label: AppLocalizations.of(context)!.poll,
                      onTap: () {
                        // Handle poll creation
                      },
                    ),
                    _buildPostButton(
                      context: context,
                      label: AppLocalizations.of(context)!.post,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );