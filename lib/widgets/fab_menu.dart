import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:go_router/go_router.dart';

class FABMENU extends StatelessWidget {
  const FABMENU({
    super.key,
    required this.scaffoldKey,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.tooltip1,
    required this.tooltip2,
    required this.tooltip3,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String tooltip1;
  final String tooltip2;
  final String tooltip3;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      animationDuration: const Duration(milliseconds: 250),
      ringWidthLimitFactor: 0.25,
      ringDiameter: 300,
      ringColor: Colors.black.withAlpha(2),
      fabMargin: const EdgeInsets.all(2),
      fabCloseIcon: const Icon(Icons.close),
      fabOpenIcon: const Icon(Icons.menu),
      fabOpenColor: Theme.of(context).primaryColor,
      fabCloseColor: Theme.of(context).primaryColor,
      children: <Widget>[
        IconButton(
            icon: Icon(icon1),
            tooltip: tooltip1,
            onPressed: () {
              if (kDebugMode) {
                print(tooltip1);
              }
            }),
        IconButton(
            icon: Icon(icon2),
            tooltip: tooltip2,
            onPressed: () {
              if (kDebugMode) {
                print(tooltip2);
              }
            }),
        IconButton(
            icon: Icon(icon3),
            tooltip: tooltip3,
            onPressed: () {
              if (kDebugMode) {
                context.go('/');
              }
            }),
        IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              if (kDebugMode) {
                print('Settings');
              }
              //scaffoldKey.currentState?.openDrawer();
              context.go('/settings');
            })
      ],
    );
  }
}
