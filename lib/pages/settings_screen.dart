import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/fab_menu.dart';
import '../models/channel_model.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABMENU(
        icon1: Icons.wallet,
        icon2: Icons.favorite,
        icon3: Icons.home,
        tooltip1: 'Button 1',
        tooltip2: 'Button 2',
        tooltip3: 'Button 3',
        scaffoldKey: scaffoldKey,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth =
                constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth * 0.9;

            return SizedBox(
              width: maxWidth,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.themeMode),
                      trailing: DropdownButton<ThemeMode>(
                        value: themeMode,
                        isDense: true,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 4,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        items: ThemeMode.values.map((mode) {
                          return DropdownMenuItem(
                            value: mode,
                            child: Text(getThemeModeName(mode, context)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(themeProvider.notifier)
                                .setThemeMode(value);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.language),
                      trailing: DropdownButton<Locale>(
                        value: locale,
                        isDense: true,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 4,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        items: [
                          DropdownMenuItem(
                            value: const Locale('en'),
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: const Locale('ar'),
                            child: Text('العربية'),
                          ),
                          DropdownMenuItem(
                            value: const Locale('es'),
                            child: Text('Español'),
                          ),
                          DropdownMenuItem(
                            value: const Locale('zgh'),
                            child: Text('ⵜⵉⴼⵉⵏⴰⵖ'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(localeProvider.notifier).setLocale(value);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            content: Row(
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(width: 24),
                                Text(AppLocalizations.of(context)!
                                    .syncInProgress),
                              ],
                            ),
                          ),
                        );
                        await Future.delayed(const Duration(seconds: 5));
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                      title: Text(AppLocalizations.of(context)!.syncData),
                      trailing: const Icon(Icons.sync),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () async {
                        final bool? confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete All Channels'),
                              content: const Text(
                                  'This will delete all saved TV channels. This action cannot be undone. Are you sure?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          try {
                            await Channel.deleteAllChannels();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('All channels have been deleted'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error deleting channels: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      title: Text(AppLocalizations.of(context)!.deleteDatabase),
                      trailing: const Icon(Icons.sync),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      onTap: () => context.go('/profile'),
                      title: Text(AppLocalizations.of(context)!.logOut),
                      trailing: const Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String getThemeModeName(ThemeMode mode, BuildContext context) {
    switch (mode) {
      case ThemeMode.system:
        return AppLocalizations.of(context)!.systemTheme;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.lightTheme;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.darkTheme;
    }
  }
}
