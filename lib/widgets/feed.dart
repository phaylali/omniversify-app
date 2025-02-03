import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_app/widgets/post_card.dart';
import '../providers/posts_provider.dart'; 

class Feed extends ConsumerWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPosts = ref.watch(filteredPostsProvider);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        return PostCard(post: post);
      },
    );
  }
}
