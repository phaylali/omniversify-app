import 'package:flutter/material.dart';

class EngagementMetrics extends StatelessWidget {
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;

  const EngagementMetrics({
    super.key,
    required this.likes,
    required this.dislikes,
    required this.commentsCount,
    required this.sharesCount,
    required this.repostsCount,
    required this.quotesCount,
  });

  @override
  Widget build(BuildContext context) {
    final totalVotes = likes + dislikes;
    final percentage = totalVotes > 0 ? (likes / totalVotes * 100).round() : 0;

    return Column(
      children: [
        // Aura meter
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'A+',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'A-',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: totalVotes > 0 ? likes / totalVotes : 0,
              backgroundColor: Colors.red.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade300),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Engagement buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEngagementButton(
                icon: _buildAuraIcon(true),
                count: likes,
                onPressed: () {}, context: context,
              ),
              _buildEngagementButton(
                icon: _buildAuraIcon(false),
                count: dislikes,
                onPressed: () {}, context: context,
              ),
              _buildEngagementButton(
                icon: const Icon(Icons.mode_comment_outlined),
                count: commentsCount,
                onPressed: () {}, context: context,
              ),
              _buildEngagementButton(
                icon: const Icon(Icons.repeat),
                count: repostsCount + quotesCount,
                onPressed: () {}, context: context,
              ),
              _buildEngagementButton(
                icon: const Icon(Icons.share_outlined),
                count: sharesCount,
                onPressed: () {}, context: context,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuraIcon(bool isPositive) {
    return Text(
      isPositive ? 'A+' : 'A-',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEngagementButton({
    required Widget icon,
    required int count,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconTheme(
              data: IconThemeData(
                size: 20,
                color: DefaultTextStyle.of(context).style.color,
              ),
              child: icon,
            ),
            const SizedBox(height: 4),
            Text(
              _formatCount(count),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
