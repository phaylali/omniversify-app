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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildQuoteContent(),
            _buildOriginalPost(),
            _buildEngagementMetrics(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: quote.author.avatarUrl != null
            ? NetworkImage(quote.author.avatarUrl!)
            : null,
        child: quote.author.avatarUrl == null
            ? Text(quote.author.username[0].toUpperCase())
            : null,
      ),
      title: Text(
        quote.author.displayName ?? quote.author.username,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('@${quote.author.username}'),
      trailing: Text(
        _formatTimestamp(quote.createdAt),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildQuoteContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quote.content),
          if (quote.hashtags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
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

  Widget _buildMetricText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
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
