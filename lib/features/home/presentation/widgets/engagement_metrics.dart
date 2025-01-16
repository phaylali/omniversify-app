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
    //final totalVotes = likes + dislikes;
    //final percentage = totalVotes > 0 ? (likes / totalVotes * 100).round() : 0;

    return Column(
      children: [
        // Aura meter
        //_buildVerticalAuraMeter(
        //  percentage: percentage,
        //  totalVotes: totalVotes,
        //),
        const SizedBox(height: 16),
        // Engagement buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildEngagementButton(
                  icon: _buildAuraIcon(true),
                  count: likes,
                  onPressed: () {},
                  context: context,
                ),
                const SizedBox(width: 2),
                _buildEngagementButton(
                  icon: _buildAuraIcon(false),
                  count: dislikes,
                  onPressed: () {},
                  context: context,
                ),
                const SizedBox(width: 2),
                _buildEngagementButton(
                  icon: const Icon(Icons.mode_comment_outlined),
                  count: commentsCount,
                  onPressed: () {},
                  context: context,
                ),
                const SizedBox(width: 2),
                _buildEngagementButton(
                  icon: const Icon(Icons.repeat),
                  count: repostsCount + quotesCount,
                  onPressed: () {},
                  context: context,
                ),
                const SizedBox(width: 2),
                _buildEngagementButton(
                  icon: const Icon(Icons.share_outlined),
                  count: sharesCount,
                  onPressed: () {},
                  context: context,
                ),
              ],
            ),
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
    return Tooltip(
      message: 'Engage',
      child: IconButton(
        onPressed: onPressed,
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(
                size: 20,
                color: DefaultTextStyle.of(context).style.color,
              ),
              child: icon,
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                _formatCount(count),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
