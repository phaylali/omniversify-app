import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/features/home/presentation/widgets/post_creation_block.dart';
//import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../domain/models/models.dart';
import 'widgets/post_card.dart';
import 'widgets/quote_card.dart';
import 'widgets/repost_card.dart';
import '../../../shared/widgets/fab_menu.dart';
import '../data/mock_data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String _tabOrderKey = 'tab_order';
  List<String> _tabs = ['all', 'posts', 'reposts', 'quotes'];

  @override
  void initState() {
    super.initState();
    _loadTabOrder();
    _initTabController();
  }

  void _initTabController() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  Future<void> _loadTabOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList(_tabOrderKey);
    if (savedOrder != null && mounted) {
      setState(() {
        _tabs = savedOrder;
      });
      _initTabController();
    }
  }

  void _saveTabOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_tabOrderKey, _tabs);
    if (mounted) {
      _initTabController();
      setState(() {});
    }
  }

  void _showReorderDialog() {
    List<String> tempTabs = List.from(_tabs);
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Reorder Tabs'),
          content: SizedBox(
            width: double.maxFinite,
            child: ReorderableListView(
              shrinkWrap: true,
              children: tempTabs
                  .map(
                    (tab) => ListTile(
                      key: ValueKey(tab),
                      title: Text(tab.toUpperCase()),
                      leading: const Icon(Icons.drag_handle),
                    ),
                  )
                  .toList(),
              onReorder: (oldIndex, newIndex) {
                setDialogState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = tempTabs.removeAt(oldIndex);
                  tempTabs.insert(newIndex, item);
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tabs = tempTabs;
                });
                _saveTabOrder();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _getFilteredPosts(String tab) {
    switch (tab.toLowerCase()) {
      case 'all':
        return mockPosts;
      case 'posts':
        return mockPosts.whereType<Post>().toList();
      case 'quotes':
        return mockPosts.whereType<Quote>().toList();
      case 'reposts':
        return mockPosts.whereType<Repost>().toList();
      default:
        return mockPosts;
    }
  }

  Widget _buildPostsList(String tab) {
    final filteredPosts = _getFilteredPosts(tab);
    return ListView.builder(
      itemCount: tab.toLowerCase() == 'all' ? filteredPosts.length + 1 : filteredPosts.length,
      itemBuilder: (context, index) {
        if (tab.toLowerCase() == 'all' && index == 0) {
          return const PostCreationBlock();
        }
        final post = tab.toLowerCase() == 'all' ? filteredPosts[index - 1] : filteredPosts[index];
        if (post is Repost) {
          return RepostCard(repost: post);
        } else if (post is Quote) {
          return QuoteCard(quote: post);
        } else {
          return PostCard(post: post);
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final localizer = ref.read(localizationProvider.notifier);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        tabController: _tabController,
        tabs: _tabs,
        onReorder: _showReorderDialog,
      ),
      drawer: AppDrawer(scaffoldKey: _scaffoldKey),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) => _buildPostsList(tab)).toList(),
        ),
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
