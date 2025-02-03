import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;

  const FollowButton({
    super.key,
    required this.isFollowing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isFollowing ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFollowing ? Icons.check : Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
