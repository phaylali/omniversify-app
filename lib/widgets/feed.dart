import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/posts_provider.dart'; // Import the Post model

class Feed extends ConsumerWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPosts = ref.watch(filteredPostsProvider);

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return ListTile(
          title: Text(post.content),
          subtitle: Text(
            post.attachments.isNotEmpty
                ? post.attachments.map((a) => a.type).join(', ')
                : 'No Attachments',
          ),
        );
      },
    );
  }
}
