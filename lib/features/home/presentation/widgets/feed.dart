import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import 'post_card.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary sample posts
    return Column(
      children: List.generate(
        5,
        (index) => PostCard(
          post: Post(
            id: index.toString(),
            content: 'This is sample post #$index',
            author: UserInfo(
              id: index.toString(),
              username: 'user$index',
              displayName: 'User $index',
            ),
            createdAt: DateTime.now().subtract(Duration(hours: index)),
            likes: index * 10,
            dislikes: index,
            commentsCount: index * 2,
            hashtags: ['sample', 'post$index'],
            attachments: [],
          ),
        ),
      ),
    );
  }
}
