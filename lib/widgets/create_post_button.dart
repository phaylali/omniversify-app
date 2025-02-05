import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: InkWell(
          onTap: () {
            context.go('/new_post');
          },
          child: Center(
            child: const Text(
              'Create Post',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}