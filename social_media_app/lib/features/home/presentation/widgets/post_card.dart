import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import 'engagement_metrics.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool isEmbedded;

  const PostCard({
    super.key,
    required this.post,
    this.isEmbedded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCardWrapper(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: isEmbedded ? 8 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildContent(),
            if (post.attachments.isNotEmpty) _buildAttachments(),
            if (!isEmbedded) _buildEngagementMetrics(),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.content),
          if (post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
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
          ],
        ],
      ),
    );
  }

  Widget _buildAttachments() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.attachments.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.network(
              post.attachments[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEngagementMetrics() {
    return EngagementMetrics(
      likes: post.likes,
      dislikes: post.dislikes,
      commentsCount: post.commentsCount,
      sharesCount: post.sharesCount,
      repostsCount: post.repostsCount,
      quotesCount: post.quotesCount,
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
