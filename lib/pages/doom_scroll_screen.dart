import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../shared/widgets/fab_menu.dart';
import '../shared/widgets/app_drawer.dart';
class DoomScrollScreen extends ConsumerStatefulWidget {
  const DoomScrollScreen({super.key});

  @override
  ConsumerState<DoomScrollScreen> createState() => _DoomScrollScreenState();
}

class _DoomScrollScreenState extends ConsumerState<DoomScrollScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(
    viewportFraction: 1.0,
    initialPage: 0,
  );
  double? _dragStartPosition;
  double? _dragEndPosition;

  final List<Map<String, dynamic>> _shorts = [
    {
      'username': '@user1',
      'description': 'Amazing sunset view! 🌅 #nature #sunset',
      'likes': 1200,
      'dislikes': 50,
      'commentsCount': 3,
      'reposts': 45,
      'comments': [
        {'user': '@nature_lover', 'text': 'Stunning view! 😍'},
        {'user': '@photo_pro', 'text': 'Great composition!'},
        {'user': '@traveler', 'text': 'Where is this?'},
      ],
    },
    {
      'username': '@techie',
      'description': 'Quick tech tip! 💡 #technology #tips',
      'likes': 3400,
      'dislikes': 120,
      'commentsCount': 4,
      'reposts': 89,
      'comments': [
        {'user': '@geek', 'text': 'Super helpful! 👍'},
        {'user': '@dev123', 'text': 'Nice hack!'},
        {'user': '@newbie', 'text': 'Can you explain more?'},
        {'user': '@tech_fan', 'text': 'Game changer!'},
      ],
    },
    {
      'username': '@foodlover',
      'description': 'Easy 5-minute recipe 🍳 #cooking #food',
      'likes': 5600,
      'dislikes': 200,
      'commentsCount': 3,
      'reposts': 123,
      'comments': [
        {'user': '@chef', 'text': 'Great technique!'},
        {'user': '@homecook', 'text': 'Trying this tonight!'},
        {'user': '@foodie', 'text': 'Looks delicious! 😋'},
      ],
    },
    {
      'username': '@fitness_guru',
      'description': 'Quick home workout 💪 No equipment needed! #fitness #health',
      'likes': 8900,
      'dislikes': 300,
      'commentsCount': 3,
      'reposts': 234,
      'comments': [
        {'user': '@gym_rat', 'text': 'Perfect form! 💯'},
        {'user': '@beginner', 'text': 'Thanks for sharing!'},
        {'user': '@trainer', 'text': 'Great routine!'},
      ],
    },
    {
      'username': '@artist',
      'description': 'Speed painting process 🎨 #art #creative',
      'likes': 2300,
      'dislikes': 80,
      'commentsCount': 3,
      'reposts': 67,
      'comments': [
        {'user': '@art_lover', 'text': 'Incredible talent!'},
        {'user': '@painter', 'text': 'What brushes do you use?'},
        {'user': '@student', 'text': 'So inspiring! ✨'},
      ],
    },
    {
      'username': '@musician',
      'description': 'Guitar cover 🎸 #music #cover',
      'likes': 4500,
      'dislikes': 150,
      'commentsCount': 3,
      'reposts': 156,
      'comments': [
        {'user': '@guitar_hero', 'text': 'Awesome skills! 🔥'},
        {'user': '@music_fan', 'text': 'Love this song!'},
        {'user': '@bassist', 'text': 'Great arrangement!'},
      ],
    },
  ];

  void _handleMouseScroll(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      if (event.scrollDelta.dy > 0) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (event.scrollDelta.dy < 0) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final localizer = ref.read(localeProvider.notifier);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text( AppLocalizations.of(context)!.scroll),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: AppDrawer(scaffoldKey: _scaffoldKey),
      body: Listener(
        onPointerSignal: _handleMouseScroll,
        child: GestureDetector(
          onVerticalDragStart: (details) {
            _dragStartPosition = details.globalPosition.dy;
          },
          onVerticalDragUpdate: (details) {
            _dragEndPosition = details.globalPosition.dy;
          },
          onVerticalDragEnd: (details) {
            if (_dragStartPosition != null && _dragEndPosition != null) {
              final screenMidPoint = screenHeight / 2;
              final startedInTopHalf = _dragStartPosition! < screenMidPoint;
              final endedInBottomHalf = _dragEndPosition! > screenMidPoint;
              
              // If started in top half and ended in bottom half -> previous page
              if (startedInTopHalf && endedInBottomHalf) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
              // If started in bottom half and ended in top half -> next page
              else if (!startedInTopHalf && !endedInBottomHalf) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
              
              _dragStartPosition = null;
              _dragEndPosition = null;
            }
          },
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _shorts.length,
            physics: const ClampingScrollPhysics(),
            pageSnapping: true,
            onPageChanged: (index) {
              HapticFeedback.mediumImpact();
            },
            dragStartBehavior: DragStartBehavior.down,
            itemBuilder: (context, index) {
              final short = _shorts[index];
              return Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    // Center: Video placeholder
                    Positioned(
                      left: MediaQuery.of(context).size.width / 3,
                      right: MediaQuery.of(context).size.width / 3,
                      top: 0,
                      bottom: 0,
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Left column: User info and action buttons
                    Positioned(
                      top: kToolbarHeight + 16,
                      left: 0,
                      bottom: 16,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User info section
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Text(
                                    (short['username'] as String).substring(1, 3).toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        short['username'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Description
                            Text(
                              short['description'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            // Action buttons in a row at the bottom
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildActionButton(
                                    icon: Icons.thumb_up,
                                    label: '${short['likes']}',
                                    onTap: () {
                                      // Handle like action
                                      if (kDebugMode) {
                                        print('Like tapped');
                                      }
                                    },
                                  ),
                                  _buildActionButton(
                                    icon: Icons.thumb_down,
                                    label: '${short['dislikes']}',
                                    onTap: () {
                                      // Handle dislike action
                                      if (kDebugMode) {
                                        print('Dislike tapped');
                                      }
                                    },
                                  ),
                                  _buildActionButton(
                                    icon: Icons.percent,
                                    label: '${((short['likes'] / (short['likes'] + short['dislikes'])) * 100).toStringAsFixed(1)}%',
                                    onTap: () {},
                                  ),
                                  _buildActionButton(
                                    icon: Icons.comment,
                                    label: '${short['commentsCount']}',
                                    onTap: () {
                                      // Handle comment action
                                      if (kDebugMode) {
                                        print('Comment tapped');
                                      }
                                    },
                                  ),
                                  _buildActionButton(
                                    icon: Icons.repeat,
                                    label: '${short['reposts']}',
                                    onTap: () {
                                      // Handle repost action
                                      if (kDebugMode) {
                                        print('Repost tapped');
                                      }
                                    },
                                  ),
                                  _buildActionButton(
                                    icon: Icons.share,
                                    label: 'Share',
                                    onTap: () {
                                      // Handle share action
                                      if (kDebugMode) {
                                        print('Share tapped');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right column: Comments
                    Positioned(
                      top: kToolbarHeight + 16,
                      right: 0,
                      bottom: 16,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: (short['comments'] as List).length,
                                itemBuilder: (context, commentIndex) {
                                  final comment = (short['comments'] as List)[commentIndex] as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          child: Text(
                                            (comment['user'] as String).substring(1, 2).toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                comment['user'] as String,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                comment['text'] as String,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
