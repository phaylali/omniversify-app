import 'package:flutter/material.dart';

class ReorderableTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController controller;
  final Function(int oldIndex, int newIndex) onReorder;

  const ReorderableTabBar({
    super.key,
    required this.tabs,
    required this.controller,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabs: List.generate(tabs.length, (index) {
          return Draggable<int>(
            data: index,
            feedback: Material(
              color: Colors.transparent,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                child: tabs[index],
              ),
            ),
            childWhenDragging: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white30,
              ),
              child: tabs[index],
            ),
            child: DragTarget<int>(
              onAcceptWithDetails: (details) {
                onReorder(details.data, index);
              },
              builder: (context, candidateData, rejectedData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: tabs[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
