import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';


class TabReorderDialog extends ConsumerStatefulWidget {
  final List<String> tabs;
  final Function(List<String>) onSave;

  const TabReorderDialog({
    super.key,
    required this.tabs,
    required this.onSave,
  });

  @override
  ConsumerState<TabReorderDialog> createState() => _TabReorderDialogState();
}

class _TabReorderDialogState extends ConsumerState<TabReorderDialog> {
  late List<String> _reorderedTabs;

  @override
  void initState() {
    super.initState();
    _reorderedTabs = List.from(widget.tabs);
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reorder Feeds',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ReorderableListView(
                shrinkWrap: true,
                children: _reorderedTabs.map((tab) {
                  return Container(
                    key: ValueKey(tab),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.drag_handle),
                      title: Text(tab),
                    ),
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = _reorderedTabs.removeAt(oldIndex);
                    _reorderedTabs.insert(newIndex, item);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(_reorderedTabs);
                    context.pop();
                  },
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
