import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../providers/tabs_provider.dart';

class TabsNavigationDrawer extends ConsumerWidget {
  const TabsNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(tabsProvider);
    final selectedTabIndex = ref.watch(selectedTabProvider);
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const Gap(16),
            Flexible(
              child: SingleChildScrollView(
                child: Flex(direction: Axis.vertical, 
                children: tabs.map((tab) {
                    return ListTile(
                      leading: SizedBox(
                        width: 28,
                        child: tab.icon,
                      ),
                      title: Text(tab.name),
                      selected: tabs.indexOf(tab) == selectedTabIndex,
                      onTap: () {
                        ref.read(selectedTabProvider.notifier).state = tabs.indexOf(tab);
                      },
                    );
                  }).toList(),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
