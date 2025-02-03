import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              widget.scaffoldKey.currentState?.closeDrawer();
              context.go('/profile');
            },
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text( AppLocalizations.of(context)!.home),
            onTap: () {
              widget.scaffoldKey.currentState?.closeDrawer();
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text( AppLocalizations.of(context)!.settings),
            onTap: () {
              widget.scaffoldKey.currentState?.closeDrawer();
              context.go('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.screen_lock_landscape),
            title: Text( AppLocalizations.of(context)!.scroll),
            onTap: () {
              widget.scaffoldKey.currentState?.closeDrawer();
              context.go('/scroll');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: Text( AppLocalizations.of(context)!.tv),
            onTap: () {
              widget.scaffoldKey.currentState?.closeDrawer();
              context.go('/tv');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text( AppLocalizations.of(context)!.privacy_policy),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text( AppLocalizations.of(context)!.open_link),
                    content: Text( AppLocalizations.of(context)!.open_link_confirmation),
                    actions: <Widget>[
                      TextButton(
                        child: Text( AppLocalizations.of(context)!.cancel),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      TextButton(
                        child: Text( AppLocalizations.of(context)!.open_link),
                        onPressed: () {
                          
                          launchUrl(
                            Uri.parse('https://omniversify.com'),
                            
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(AppLocalizations.of(context)!.licenses),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: AppLocalizations.of(context)!.app_title,
                applicationVersion: _packageInfo?.version ?? '',
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context)!.exit),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.exit),
                    content: Text(AppLocalizations.of(context)!.exit_confirmation),
                    actions: <Widget>[
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.cancel),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.exit),
                        onPressed: () {
                          context.pop();
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          if (_packageInfo != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version ${_packageInfo!.version} (${_packageInfo!.buildNumber})',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
