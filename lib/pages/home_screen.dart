import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/features/home/presentation/widgets/post_creation_block.dart';
import '../shared/widgets/app_drawer.dart';
import '../shared/widgets/custom_app_bar.dart';
import '../features/home/domain/models/models.dart';
import '../features/home/presentation/widgets/people_section.dart';
import '../features/home/presentation/widgets/post_card.dart';
import '../features/home/presentation/widgets/quote_card.dart';
import '../features/home/presentation/widgets/repost_card.dart';
import '../shared/widgets/fab_menu.dart';
import '../features/home/data/mock_data.dart';
import 'package:go_router/go_router.dart';

enum ContentType {
  all,
  posts,
  reposts,
  quotes,
  images,
  videos,
  books,
  links,
  gifs,
  polls,
  series,
  movies,
  locations,
  music,
  audio,
  games,
  activities,
  custom
}

class CustomTab {
  final String label;

  const CustomTab({required this.label});

  Map<String, dynamic> toJson() => {
        'label': label,
      };

  factory CustomTab.fromJson(Map<String, dynamic> json) {
    return CustomTab(
      label: json['label'] as String,
    );
  }
}

extension ContentTypeExtension on ContentType {
  String get label => toString().split('.').last;

  IconData get icon {
    switch (this) {
      case ContentType.all:
        return Icons.dashboard;
      case ContentType.posts:
        return Icons.article;
      case ContentType.reposts:
        return Icons.repeat;
      case ContentType.quotes:
        return Icons.format_quote;
      case ContentType.images:
        return Icons.image;
      case ContentType.videos:
        return Icons.videocam;
      case ContentType.books:
        return Icons.book;
      case ContentType.links:
        return Icons.link;
      case ContentType.gifs:
        return Icons.gif;
      case ContentType.polls:
        return Icons.poll;
      case ContentType.series:
        return Icons.tv;
      case ContentType.movies:
        return Icons.movie;
      case ContentType.locations:
        return Icons.location_on;
      case ContentType.music:
        return Icons.music_note;
      case ContentType.audio:
        return Icons.audiotrack;
      case ContentType.games:
        return Icons.sports_esports;
      case ContentType.activities:
        return Icons.local_activity;
      case ContentType.custom:
        return Icons.label_outline;
    }
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  static const String _activeTabsKey = 'active_tabs';
  static const String _customTabsKey = 'custom_tabs';

  List<ContentType> _activeTabs = [ContentType.all];
  Map<String, CustomTab> _customTabs = {};
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Initialize with default tabs first
    _tabController = TabController(
      length: _activeTabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    // Load saved tabs
    _loadTabSettings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTabSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTabs = prefs.getStringList(_activeTabsKey);
    final savedCustomTabs = prefs.getStringList(_customTabsKey);

    // Load custom tabs first
    if (savedCustomTabs != null) {
      _customTabs = Map.fromEntries(
        savedCustomTabs.map((entry) {
          final parts = entry.split('|');
          return MapEntry(parts[0], CustomTab(label: parts[1]));
        }),
      );
    }

    if (savedTabs != null && mounted) {
      final newTabs = savedTabs
          .map((tab) => ContentType.values.firstWhere(
                (t) => t.label == tab,
                orElse: () => ContentType.custom,
              ))
          .toList();

      // Ensure "all" tab is present and first
      if (!newTabs.contains(ContentType.all)) {
        newTabs.insert(0, ContentType.all);
      } else if (newTabs.indexOf(ContentType.all) != 0) {
        newTabs.remove(ContentType.all);
        newTabs.insert(0, ContentType.all);
      }

      setState(() {
        _activeTabs = newTabs;
        // Recreate controller with new length
        _tabController.dispose();
        _tabController = TabController(
          length: _activeTabs.length,
          vsync: this,
        );
        _tabController.addListener(() {
          if (!_tabController.indexIsChanging) {
            setState(() {});
          }
        });
      });
    }
  }

  Future<void> _saveTabSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _activeTabsKey,
      _activeTabs.map((tab) => tab.label).toList(),
    );
    await prefs.setStringList(
      _customTabsKey,
      _customTabs.entries.map((e) => '${e.key}|${e.value.label}').toList(),
    );
  }

  void _addCustomTab(String label) {
    if (label.isNotEmpty && !_customTabs.containsKey(label)) {
      setState(() {
        _customTabs[label] = CustomTab(label: label);
        _activeTabs.add(ContentType.custom);
        _tabController.dispose();
        _tabController = TabController(length: _activeTabs.length, vsync: this);
        _tabController.addListener(() {
          if (!_tabController.indexIsChanging) {
            setState(() {});
          }
        });
        _saveTabSettings();
      });
    }
  }

  void _showTabManager() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tabs Manager',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ReorderableListView(
                      shrinkWrap: true,
                      children: _activeTabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;
                        final bool isAllTab = tab == ContentType.all;
                        return ListTile(
                          key: ValueKey('tab_$index'),
                          leading: Icon(tab.icon),
                          title: Text(tab.label),
                          trailing: isAllTab
                              ? const Tooltip(
                                  message: 'Default tab cannot be removed',
                                  child: Icon(Icons.lock_outline,
                                      color: Colors.grey),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      _activeTabs.remove(tab);
                                      _tabController.dispose();
                                      _tabController = TabController(
                                          length: _activeTabs.length,
                                          vsync: this);
                                      _tabController.addListener(() {
                                        if (!_tabController.indexIsChanging) {
                                          setState(() {});
                                        }
                                      });
                                      _saveTabSettings();
                                    });
                                    context.pop();
                                  },
                                ),
                        );
                      }).toList(),
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = _activeTabs.removeAt(oldIndex);
                          _activeTabs.insert(newIndex, item);
                          _tabController.dispose();
                          _tabController = TabController(
                              length: _activeTabs.length, vsync: this);
                          _tabController.addListener(() {
                            if (!_tabController.indexIsChanging) {
                              setState(() {});
                            }
                          });
                          _saveTabSettings();
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Tab'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 300),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Add Tab',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Flexible(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              'Available Tabs',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: ContentType.values
                                                  .where((type) =>
                                                      !_activeTabs
                                                          .contains(type) &&
                                                      type != ContentType.all &&
                                                      type !=
                                                          ContentType.custom)
                                                  .map((type) => ActionChip(
                                                        avatar: Icon(type.icon,
                                                            size: 18),
                                                        label: Text(type.label),
                                                        onPressed: () {
                                                          setState(() {
                                                            _activeTabs
                                                                .add(type);
                                                            _tabController
                                                                .dispose();
                                                            _tabController =
                                                                TabController(
                                                                    length: _activeTabs
                                                                        .length,
                                                                    vsync:
                                                                        this);
                                                            _tabController
                                                                .addListener(
                                                                    () {
                                                              if (!_tabController
                                                                  .indexIsChanging) {
                                                                setState(() {});
                                                              }
                                                            });
                                                            _saveTabSettings();
                                                          });
                                                          context.pop();
                                                        },
                                                      ))
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Custom Tab',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            TextField(
                                              decoration: const InputDecoration(
                                                labelText: 'Tab Name',
                                                border: OutlineInputBorder(),
                                                prefixIcon:
                                                    Icon(Icons.label_outline),
                                              ),
                                              onSubmitted: (value) {
                                                if (value.isNotEmpty) {
                                                  _addCustomTab(value);
                                                  context.pop();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () => context.pop(),
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<dynamic> _getFilteredPosts(ContentType tab) {
    switch (tab) {
      case ContentType.all:
        return mockPosts;
      case ContentType.posts:
        return mockPosts.whereType<Post>().toList();
      case ContentType.reposts:
        return mockPosts.whereType<Repost>().toList();
      case ContentType.quotes:
        return mockPosts.whereType<Quote>().toList();
      default:
        return mockPosts;
    }
  }

  Widget _buildPostsList(ContentType tab) {
    final filteredPosts = _getFilteredPosts(tab);
    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
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

  List<Widget> _buildTabs() {
    return _activeTabs.asMap().entries.map((entry) {
      final index = entry.key;
      final tab = entry.value;
      if (tab == ContentType.custom) {
        // Find the corresponding custom tab label
        final customTab = _customTabs.entries.firstWhere(
          (entry) =>
              _activeTabs.indexOf(ContentType.custom) ==
              _activeTabs.indexOf(tab),
          orElse: () => const MapEntry('Custom', CustomTab(label: 'Custom')),
        );
        return Tab(
          key: ValueKey('reorderable_tab_$index'),
          icon: Icon(tab.icon),
          text: customTab.value.label,
        );
      }
      return Tab(
        key: ValueKey('reorderable_tab_$index'),
        icon: Icon(tab.icon),
        text: tab.label,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 1200;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        tabController: _tabController,
        tabs: _buildTabs(),
        onReorder: _showTabManager,
      ),
      drawer: AppDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      body: isWideScreen
          ? Row(
              children: [
                // Left section (hashtags)
                SizedBox(
                  width: screenWidth * 0.20,
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: PostCreationBlock(),
                      ),
                      Expanded(
                        child: SizedBox.expand(
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trending Topics',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text('#Flutter'),
                                  Text('#Dart'),
                                  Text('#OpenSource'),
                                  Text('#WebDev'),
                                  Text('#MobileApps'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Center section with fixed width and tabs
                SizedBox(
                  width: screenWidth * 0.40,
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: _activeTabs
                              .map((tab) => _buildPostsList(tab))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right section (people)
                SizedBox(
                  width: screenWidth * 0.20,
                  child: const PeopleSection(),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children:
                        _activeTabs.map((tab) => _buildPostsList(tab)).toList(),
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
