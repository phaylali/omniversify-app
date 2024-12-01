import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import 'embedded_card.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class RepostCard extends StatelessWidget {
  final Repost repost;

  const RepostCard({
    super.key,
    required this.repost,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCardWrapper(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.repeat, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    '${repost.author.displayName ?? repost.author.username} reposted',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            EmbeddedCard(
              post: repost.originalPost,
            ),
          ],
        ),
      ),
    );
  }
}
