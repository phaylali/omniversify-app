import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;
  final double height;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuPressed,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: onMenuPressed,
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.logo_dev,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add a placeholder widget with the same width as the menu button
          // to maintain center alignment
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
