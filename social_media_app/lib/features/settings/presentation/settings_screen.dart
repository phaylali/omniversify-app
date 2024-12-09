import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/fab_menu.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../features/tv/domain/models/channel_model.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final localizer = ref.read(localizationProvider.notifier);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(scaffoldKey: _scaffoldKey),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              localizer.translate(context, 'settings'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text(localizer.translate(context, 'theme')),
                trailing: DropdownButton<AppThemeMode>(
                  value: AppThemeMode.values[[
                    AppThemes.lightTheme,
                    AppThemes.darkTheme,
                    AppThemes.customTheme
                  ].indexOf(ref.watch(themeProvider))],
                  onChanged: (AppThemeMode? newTheme) {
                    if (newTheme != null) {
                      themeNotifier.setTheme(newTheme);
                    }
                  },
                  items: AppThemeMode.values
                      .map((mode) => DropdownMenuItem(
                            value: mode,
                            child: Text(mode.toString().split('.').last),
                          ))
                      .toList(),
                ),
              ),
              ListTile(
                title: Text(localizer.translate(context, 'language')),
                trailing: DropdownButton<AppLanguage>(
                  value: AppLanguage.values[AppLocalizations
                      .supportedLocales.values
                      .toList()
                      .indexOf(ref.watch(localizationProvider))],
                  onChanged: (AppLanguage? newLanguage) {
                    if (newLanguage != null) {
                      ref
                          .read(localizationProvider.notifier)
                          .setLanguage(newLanguage);
                    }
                  },
                  items: AppLanguage.values
                      .map((lang) => DropdownMenuItem(
                            value: lang,
                            child: Text(lang.toString().split('.').last),
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Delete All TV Channels'),
                subtitle: const Text(
                    'This will remove all saved channels from your device'),
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
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Delete'),
                            onPressed: () => Navigator.of(context).pop(true),
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
                            content: Text('All channels have been deleted'),
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
              ),
              const Divider(),
            ]),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABMENU(
        scaffoldKey: _scaffoldKey,
        icon1: Icons.wallet,
        icon2: Icons.favorite,
        icon3: Icons.home,
        tooltip1: 'Button 1',
        tooltip2: 'Button 2',
        tooltip3: 'Button 3',
      ),
    );
  }
}
