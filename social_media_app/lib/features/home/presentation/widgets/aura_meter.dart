import 'package:flutter/material.dart';

class AuraMeter extends StatelessWidget {
  final int likes;
  final int dislikes;
 // final double height;

  const AuraMeter({
    super.key,
    required this.likes,
    required this.dislikes,
    //required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final totalVotes = likes + dislikes;
    final percentage = totalVotes > 0 ? (likes / totalVotes * 100).round() : 0;

    return SizedBox(
      width: 40,
      //height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'A+',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  
                  height: 10,
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
              ),
            ),
          ),
          const Text(
            'A-',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          if (totalVotes > 0) ...[
            const SizedBox(height: 2),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}
