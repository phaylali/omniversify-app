import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import 'embedded_card.dart';
import 'engagement_metrics.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCardWrapper(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildQuoteContent(),
                _buildOriginalPost(),
                _buildEngagementMetrics(),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: quote.author.avatarUrl != null
                ? NetworkImage(quote.author.avatarUrl!)
                : null,
            child: quote.author.avatarUrl == null
                ? Text(quote.author.username[0].toUpperCase())
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.author.displayName ?? quote.author.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '@${quote.author.username}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTimestamp(quote.createdAt),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onSelected: (value) {
              switch (value) {
                case 'report':
                  // TODO: Implement report functionality
                  break;
                case 'unfollow':
                  // TODO: Implement unfollow functionality
                  break;
                case 'block':
                  // TODO: Implement block functionality
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'report',
                child: Text('Report'),
              ),
              const PopupMenuItem<String>(
                value: 'unfollow',
                child: Text('Unfollow'),
              ),
              const PopupMenuItem<String>(
                value: 'block',
                child: Text('Block'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quote.content),
          if (quote.hashtags.isNotEmpty) ...[
            const SizedBox(height: 4),
            Wrap(
              spacing: 4.0,
              children: quote.hashtags
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

  Widget _buildOriginalPost() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: EmbeddedCard(
          post: quote.originalPost,
        ),
      ),
    );
  }

  Widget _buildEngagementMetrics() {
    return EngagementMetrics(
      likes: quote.likes,
      dislikes: quote.dislikes,
      commentsCount: quote.commentsCount,
      sharesCount: quote.sharesCount,
      repostsCount: quote.repostsCount,
      quotesCount: quote.quotesCount,
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
