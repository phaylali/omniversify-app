import 'package:flutter/material.dart';

class AuraMeter extends StatelessWidget {
  final int likes;
  final int dislikes;
  final double height;

  const AuraMeter({
    super.key,
    required this.likes,
    required this.dislikes,
    this.height = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final total = likes + dislikes;
    
    // Show a neutral gray strip when there are no interactions
    if (total == 0) {
      return SizedBox(
        height: height,
        child: Container(
          color: Colors.grey.shade200,
        ),
      );
    }

    final likeRatio = likes / total;
    
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: (likeRatio * 100).round(),
            child: Container(
              color: Colors.green.shade300,
            ),
          ),
          Expanded(
            flex: ((1 - likeRatio) * 100).round(),
            child: Container(
              color: Colors.red.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
