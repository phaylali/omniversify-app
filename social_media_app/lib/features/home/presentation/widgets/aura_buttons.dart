import 'package:flutter/material.dart';

class AuraButtons extends StatelessWidget {
  final int likes;
  final int dislikes;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;

  const AuraButtons({
    super.key,
    required this.likes,
    required this.dislikes,
    this.onLike,
    this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    final total = likes + dislikes;
    final percentage = total > 0 ? (likes / total * 100).round() : 0;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Text(
            'A+',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onPressed: onLike,
        ),
        Text(
          '$percentage%',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: const Text(
            'A-',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onPressed: onDislike,
        ),
      ],
    );
  }
}
