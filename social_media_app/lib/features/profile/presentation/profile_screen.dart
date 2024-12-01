import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/fab_menu.dart';
import '../../../shared/widgets/app_drawer.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final localizer = ref.read(localizationProvider.notifier);

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
              localizer.translate(context, 'profile'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SliverFillRemaining(
            child: Center(
              child: Text('Profile Screen Content'),
            ),
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
