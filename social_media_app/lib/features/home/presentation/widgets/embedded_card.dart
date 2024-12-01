import 'package:flutter/material.dart';
import '../../domain/models/models.dart';

class EmbeddedCard extends StatelessWidget {
  final EmbeddedPost post;

  const EmbeddedCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),
          if (post.hashtags.isNotEmpty) _buildHashtags(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: post.author.avatarUrl != null
            ? NetworkImage(post.author.avatarUrl!)
            : null,
        child: post.author.avatarUrl == null
            ? Text(post.author.username[0].toUpperCase())
            : null,
      ),
      title: Text(
        post.author.displayName ?? post.author.username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('@${post.author.username}'),
      trailing: Text(
        _formatTimestamp(post.createdAt),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(post.content),
    );
  }

  Widget _buildHashtags() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 8.0,
        children: post.hashtags
            .map((tag) => Text(
                  '#$tag',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ))
            .toList(),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
