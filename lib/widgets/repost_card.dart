import 'package:flutter/material.dart';
import '../models/models.dart';
import 'embedded_card.dart';
import 'responsive_card_wrapper.dart';

class RepostCard extends StatelessWidget {
  final Repost repost;

  const RepostCard({
    super.key,
    required this.repost,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.repeat,
                        size: 14,
                        color: Colors.yellow.shade300,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${repost.author.displayName ?? repost.author.username} reposted',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.yellow.shade300,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        onSelected: (value) {
                          switch (value) {
                            case 'unfollow':
                              break;
                            case 'block':
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                ),
                EmbeddedCard(
                  post: repost.originalPost,
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
