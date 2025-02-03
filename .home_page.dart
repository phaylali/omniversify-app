import 'package:flutter/material.dart';
import '../widgets/post_creation_block.dart';
import '../widgets/feed.dart';
import '../widgets/people_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 1200;

    if (!isWideScreen) {
      return Scaffold(
        body: ListView(
          children: [
            //PostCreationBlock(),
            Feed(),
          ],
        ),
      );
    }

    // Calculate center section width (33% of screen width)
    final centerWidth = screenWidth * 0.33;

    // Wide screen layout with three columns
    return Scaffold(
      body: Row(
        children: [
          // Left section (hashtags)
          const Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Hashtags Section'),
                  ),
                ),
              ),
            ),
          ),
          // Center section with fixed 33% width and tabs
          SizedBox(
            width: centerWidth,
            child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'For You'),
                      Tab(text: 'Following'),
                      Tab(text: 'Latest'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        // For You tab
                        Feed(),
                        // Following tab
                        Feed(),
                        // Latest tab
                        Feed(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right section (people)
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 300,
                child: PeopleSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
