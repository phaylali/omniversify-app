import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../providers/attachment_provider.dart';
import '../providers/post_cration_provider.dart';
import 'fab_menu.dart';
import '../models/attachment_models.dart';
import 'attachment_button.dart';

class PostCreationScreen extends ConsumerWidget {
   const PostCreationScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postCreationProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final attachments = ref.watch(attachmentListProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABMENU(
        scaffoldKey: scaffoldKey,
        icon1: Icons.wallet,
        icon2: Icons.favorite,
        icon3: Icons.home,
        tooltip1: 'Button 1',
        tooltip2: 'Button 2',
        tooltip3: 'Button 3',
      ),
      body: Column(
        children: [
          ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60,
                  maxWidth: screenWidth <= 600 ? screenWidth-4 : 600,
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
                    context.go('/new_post');
                  },
                ),
              ),
          Wrap(
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
             
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attachments.length,
              itemBuilder: (context, index) {
                final attachment = attachments[index];
                return ListTile(
                  title: Text(attachment.type),
                  subtitle: Text(attachment.toJson().toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
