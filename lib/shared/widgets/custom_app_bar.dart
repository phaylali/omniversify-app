import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<Widget> tabs;
  final VoidCallback onReorder;

  const CustomAppBar({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(80),
      centerTitle: true,
      title:  Text(
        AppLocalizations.of(context)!.app_title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.view_list),
          onPressed: onReorder,
          tooltip: 'Manage tabs',
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
