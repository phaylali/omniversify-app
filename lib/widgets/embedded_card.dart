import 'package:flutter/material.dart';
import '../models/models.dart';

class EmbeddedCard extends StatelessWidget {
  final EmbeddedPost post;

  const EmbeddedCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildContent(),
        if (post.hashtags.isNotEmpty) _buildHashtags(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: post.author.avatarUrl != null
                ? NetworkImage(post.author.avatarUrl!)
                : null,
            child: post.author.avatarUrl == null
                ? Text(post.author.username[0].toUpperCase())
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.author.displayName ?? post.author.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '@${post.author.username}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTimestamp(post.createdAt),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: Text(
        post.content,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _buildHashtags() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
      child: Wrap(
        spacing: 4.0,
        children: post.hashtags
            .map((tag) => Text(
                  '#$tag',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
