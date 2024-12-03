import 'package:flutter/material.dart';
import '../../../../shared/widgets/responsive_card_wrapper.dart';

class PostInput extends StatelessWidget {
  const PostInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCardWrapper(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person_outline),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image_outlined),
                        onPressed: () {},
                        tooltip: 'Add image',
                      ),
                      IconButton(
                        icon: const Icon(Icons.gif_box_outlined),
                        onPressed: () {},
                        tooltip: 'Add GIF',
                      ),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions_outlined),
                        onPressed: () {},
                        tooltip: 'Add emoji',
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
