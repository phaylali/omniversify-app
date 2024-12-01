import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../domain/models/models.dart';
import 'widgets/post_card.dart';
import 'widgets/quote_card.dart';
import 'widgets/repost_card.dart';
import 'widgets/tab_reorder_dialog.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/responsive_width.dart';
import '../../../shared/widgets/fab_menu.dart';
import 'widgets/post_creation_block.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String _tabOrderKey = 'tab_order';
  List<String> _tabs = ['all', 'following', 'trending'];

  final List<dynamic> _posts = [
    // Regular post with high engagement
    Post(
      id: '1',
      author: const UserInfo(
        id: '1',
        username: 'tech_enthusiast',
        displayName: 'Tech Enthusiast',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      content: 'Just launched my new app! 🚀 #coding #tech',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      attachments: const ['https://picsum.photos/500/300?random=1'],
      hashtags: const ['coding', 'tech'],
      likes: 150,
      dislikes: 10,
      commentsCount: 45,
      sharesCount: 12,
      repostsCount: 8,
      quotesCount: 5,
     
    ),
    Post(
      id: '2',
      author: const UserInfo(
        id: '2',
        username: 'travel_enthusiast',
        displayName: 'Travel Enthusiast',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      content: 'Exploring the ancient ruins of Rome. History comes alive! 🏛️ #travel #history #rome',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      attachments: const ['https://picsum.photos/500/300?random=2'],
      hashtags: const ['travel', 'history', 'rome'],
      likes: 200,
      dislikes: 15,
      commentsCount: 60,
      sharesCount: 18,
      repostsCount: 12,
      quotesCount: 6,
    ),
    Post(
      id: '3',
      author: const UserInfo(
        id: '3',
        username: 'foodie_adventures',
        displayName: 'Foodie Adventures',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      content: 'Made this delicious homemade pasta from scratch! 🍝 #cooking #foodie',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      attachments: const ['https://picsum.photos/500/300?random=3'],
      hashtags: const ['cooking', 'foodie'],
      likes: 120,
      dislikes: 5,
      commentsCount: 35,
      sharesCount: 8,
      repostsCount: 5,
      quotesCount: 3,
    ),
    Post(
      id: '4',
      author: const UserInfo(
        id: '4',
        username: 'fitness_guru',
        displayName: 'Fitness Guru',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      content: 'Morning workout complete! Starting the day right 💪 #fitness #motivation',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      attachments: const ['https://picsum.photos/500/300?random=4'],
      hashtags: const ['fitness', 'motivation'],
      likes: 200,
      dislikes: 15,
      commentsCount: 60,
      sharesCount: 18,
      repostsCount: 12,
      quotesCount: 6,
    ),
    Post(
      id: '5',
      author: const UserInfo(
        id: '5',
        username: 'tech_news',
        displayName: 'Tech News',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      content: 'Breaking: New AI breakthrough in quantum computing! 🤖 #tech #AI #quantum',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      attachments: const ['https://picsum.photos/500/300?random=5'],
      hashtags: const ['tech', 'AI', 'quantum'],
      likes: 100,
      dislikes: 25,
      commentsCount: 40,
      sharesCount: 20,
      repostsCount: 15,
      quotesCount: 10,
    ),

    // Reposts
    Repost(
      id: '6',
      author: const UserInfo(
        id: '6',
        username: 'beach_lover',
        displayName: 'Beach Lover',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      originalPost: EmbeddedPost(
        id: '1',
        author: const UserInfo(
          id: '1',
          username: 'john_doe',
          displayName: 'John Doe',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        content: 'Just had an amazing day at the beach! 🏖️ #summer #vacation',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        hashtags: const ['summer', 'vacation'],
      ),
    ),
    Repost(
      id: '7',
      author: const UserInfo(
        id: '7',
        username: 'history_buff',
        displayName: 'History Buff',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
      ),
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      originalPost: EmbeddedPost(
        id: '2',
        author: const UserInfo(
          id: '2',
          username: 'travel_enthusiast',
          displayName: 'Travel Enthusiast',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        content: 'Exploring the ancient ruins of Rome. History comes alive! 🏛️ #travel #history #rome',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        hashtags: const ['travel', 'history', 'rome'],
      ),
    ),
    Repost(
      id: '8',
      author: const UserInfo(
        id: '8',
        username: 'cooking_lover',
        displayName: 'Cooking Lover',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      originalPost: EmbeddedPost(
        id: '3',
        author: const UserInfo(
          id: '3',
          username: 'foodie_adventures',
          displayName: 'Foodie Adventures',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
        ),
        content: 'Made this delicious homemade pasta from scratch! 🍝 #cooking #foodie',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        hashtags: const ['cooking', 'foodie'],
      ),
    ),
    Repost(
      id: '9',
      author: const UserInfo(
        id: '9',
        username: 'gym_rat',
        displayName: 'Gym Rat',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      originalPost: EmbeddedPost(
        id: '4',
        author: const UserInfo(
          id: '4',
          username: 'fitness_guru',
          displayName: 'Fitness Guru',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        content: 'Morning workout complete! Starting the day right 💪 #fitness #motivation',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        hashtags: const ['fitness', 'motivation'],
      ),
    ),
    Repost(
      id: '10',
      author: const UserInfo(
        id: '10',
        username: 'science_geek',
        displayName: 'Science Geek',
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      originalPost: EmbeddedPost(
        id: '5',
        author: const UserInfo(
          id: '5',
          username: 'tech_news',
          displayName: 'Tech News',
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
        ),
        content: 'Breaking: New AI breakthrough in quantum computing! 🤖 #tech #AI #quantum',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        hashtags: const ['tech', 'AI', 'quantum'],
      ),
    ),

    // Quotes
    Quote(
      id: '11',
      author: const UserInfo(
        id: '11',
        username: 'summer_vibes',
        displayName: 'Summer Vibes',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
      ),
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      content: 'This is exactly the motivation I needed to plan my beach vacation! 🌊',
      originalPost: EmbeddedPost(
        id: '1',
        author: const UserInfo(
          id: '1',
          username: 'john_doe',
          displayName: 'John Doe',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        content: 'Just had an amazing day at the beach! 🏖️ #summer #vacation',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        hashtags: const ['summer', 'vacation'],
      ),
      likes: 250,
      dislikes: 50,
      commentsCount: 80,
      sharesCount: 25,
      repostsCount: 15,
      quotesCount: 10,
    ),
    Quote(
      id: '12',
      author: const UserInfo(
        id: '12',
        username: 'archaeologist',
        displayName: 'Archaeologist',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      content: 'The Forum is particularly beautiful this time of year. Make sure to visit early morning to avoid crowds!',
      originalPost: EmbeddedPost(
        id: '2',
        author: const UserInfo(
          id: '2',
          username: 'travel_enthusiast',
          displayName: 'Travel Enthusiast',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        content: 'Exploring the ancient ruins of Rome. History comes alive! 🏛️ #travel #history #rome',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        hashtags: const ['travel', 'history', 'rome'],
      ),
      likes: 100,
      dislikes: 20,
      commentsCount: 30,
      sharesCount: 10,
      repostsCount: 5,
      quotesCount: 3,
    ),
    Quote(
      id: '13',
      author: const UserInfo(
        id: '13',
        username: 'pasta_master',
        displayName: 'Pasta Master',
        avatarUrl: 'https://i.pravatar.cc/150?img=13',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      content: 'Pro tip: Add a pinch of semolina flour to your dough for extra texture! 👨‍🍳',
      originalPost: EmbeddedPost(
        id: '3',
        author: const UserInfo(
          id: '3',
          username: 'foodie_adventures',
          displayName: 'Foodie Adventures',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
        ),
        content: 'Made this delicious homemade pasta from scratch! 🍝 #cooking #foodie',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        hashtags: const ['cooking', 'foodie'],
      ),
      likes: 45,
      dislikes: 5,
      commentsCount: 15,
      sharesCount: 4,
      repostsCount: 2,
      quotesCount: 1,
    ),
    Quote(
      id: '14',
      author: const UserInfo(
        id: '14',
        username: 'wellness_coach',
        displayName: 'Wellness Coach',
        avatarUrl: 'https://i.pravatar.cc/150?img=14',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      content: 'Remember to always warm up properly and stay hydrated! Your body will thank you. 🧘‍♀️',
      originalPost: EmbeddedPost(
        id: '4',
        author: const UserInfo(
          id: '4',
          username: 'fitness_guru',
          displayName: 'Fitness Guru',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        content: 'Morning workout complete! Starting the day right 💪 #fitness #motivation',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        hashtags: const ['fitness', 'motivation'],
      ),
      likes: 50,
      dislikes: 10,
      commentsCount: 20,
      sharesCount: 5,
      repostsCount: 3,
      quotesCount: 2,
    ),
    Quote(
      id: '15',
      author: const UserInfo(
        id: '15',
        username: 'quantum_physicist',
        displayName: 'Quantum Physicist',
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      content: 'This could revolutionize our understanding of quantum entanglement! Exciting times for physics. 🔬',
      originalPost: EmbeddedPost(
        id: '5',
        author: const UserInfo(
          id: '5',
          username: 'tech_news',
          displayName: 'Tech News',
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
        ),
        content: 'Breaking: New AI breakthrough in quantum computing! 🤖 #tech #AI #quantum',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        hashtags: const ['tech', 'AI', 'quantum'],
      ),
      likes: 75,
      dislikes: 15,
      commentsCount: 25,
      sharesCount: 10,
      repostsCount: 5,
      quotesCount: 3,
    ),
    Quote(
      id: '16',
      author: const UserInfo(
        id: '16',
        username: 'social_critic',
        displayName: 'Social Critic',
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
      ),
      content: 'This is a fascinating perspective on modern technology! 🤔',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      originalPost: EmbeddedPost(
        id: '5',
        author: const UserInfo(
          id: '5',
          username: 'tech_news',
          displayName: 'Tech News',
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
        ),
        content: 'Breaking: New AI breakthrough in quantum computing! 🤖 #tech #AI',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        hashtags: const ['tech', 'AI'],
      ),
      likes: 250,
      dislikes: 50,
      commentsCount: 80,
      sharesCount: 25,
      repostsCount: 15,
      quotesCount: 10,
    ),
    Quote(
      id: '17',
      author: const UserInfo(
        id: '17',
        username: 'fitness_skeptic',
        displayName: 'Fitness Skeptic',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
      ),
      content: 'Not everyone needs to wake up at 5 AM to be successful! 😴',
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      originalPost: EmbeddedPost(
        id: '4',
        author: const UserInfo(
          id: '4',
          username: 'fitness_guru',
          displayName: 'Fitness Guru',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        content: 'Morning workout complete! Starting the day right 💪 #fitness #motivation',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        hashtags: const ['fitness', 'motivation'],
      ),
      likes: 0,
      dislikes: 0,
      commentsCount: 0,
      sharesCount: 0,
      repostsCount: 0,
      quotesCount: 0,
    ),
    Quote(
      id: '18',
      author: const UserInfo(
        id: '18',
        username: 'food_expert',
        displayName: 'Food Expert',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      content: 'Pro tip: Try adding a pinch of nutmeg to enhance the flavor! 👨‍🍳',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      originalPost: EmbeddedPost(
        id: '3',
        author: const UserInfo(
          id: '3',
          username: 'foodie_adventures',
          displayName: 'Foodie Adventures',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
        ),
        content: 'Made this delicious homemade pasta from scratch! 🍝 #cooking #foodie',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        hashtags: const ['cooking', 'foodie'],
      ),
      likes: 45,
      dislikes: 5,
      commentsCount: 15,
      sharesCount: 4,
      repostsCount: 2,
      quotesCount: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _loadTabOrder();
  }

  Future<void> _loadTabOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final tabOrder = prefs.getStringList(_tabOrderKey);
    if (tabOrder != null) {
      setState(() {
        _tabs = tabOrder;
      });
      _tabController.dispose();
      _tabController = TabController(length: _tabs.length, vsync: this);
    }
  }

  Future<void> _saveTabOrder(List<String> newOrder) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_tabOrderKey, newOrder);
    setState(() {
      _tabs = newOrder;
    });
    _tabController.dispose();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  void _showReorderDialog() {
    showDialog(
      context: context,
      builder: (context) => TabReorderDialog(
        tabs: _tabs,
        onSave: _saveTabOrder,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<dynamic> _getFilteredPosts(String tab) {
    if (tab == 'all') return _posts;
    if (tab == 'reposts') {
      return _posts.whereType<Repost>().toList();
    }
    if (tab == 'quotes') {
      return _posts.whereType<Quote>().toList();
    }
    return _posts.whereType<Post>().toList();
  }

  Widget _buildPostsList(String tab) {
    final posts = _getFilteredPosts(tab);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: ResponsiveWidth.getContentWidth(context),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: ResponsiveWidth.getHorizontalPadding(context).copyWith(top: 1),
                child: const PostCreationBlock(),
              ),
            ),
            SliverPadding(
              padding: ResponsiveWidth.getHorizontalPadding(context),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PostCard(post: posts[index]),
                  childCount: posts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizer = ref.read(localizationProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(scaffoldKey: _scaffoldKey),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: Column(
          children: [
            CustomAppBar(
              title: localizer.translate(context, 'app_title'),
              onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: _tabs.map((tab) {
                        return Tab(
                          text: localizer.translate(context, tab),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.reorder, color: Colors.white),
                    onPressed: _showReorderDialog,
                    tooltip: 'Reorder Feeds',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          return ListView.builder(
            itemCount: _getFilteredPosts(tab).length,
            itemBuilder: (context, index) {
              final post = _getFilteredPosts(tab)[index];
              if (post is Quote) {
                return QuoteCard(quote: post);
              } else if (post is Repost) {
                return RepostCard(repost: post);
              } else if (post is Post) {
                return PostCard(post: post);
              }
              return const SizedBox(); // Fallback for unknown types
            },
          );
        }).toList(),
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
