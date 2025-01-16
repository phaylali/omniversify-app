import 'package:flutter/material.dart';

class UserPreview {
  final String name;
  final String username;
  final String avatarUrl;
  final String bio;
  final bool isFollowing;

  const UserPreview({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    this.isFollowing = false,
  });
}

class PeopleSection extends StatelessWidget {
  const PeopleSection({super.key});

  List<UserPreview> _getSampleUsers() {
    return [
      const UserPreview(
        name: 'Sarah Johnson',
        username: 'sarahj',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        bio: 'Digital artist & UI designer 🎨',
      ),
      const UserPreview(
        name: 'Alex Chen',
        username: 'alexc',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        bio: 'Tech enthusiast | Coffee lover ☕',
        isFollowing: true,
      ),
      const UserPreview(
        name: 'Maria Garcia',
        username: 'mariag',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        bio: 'Travel photographer 📸 | Explorer',
      ),
      const UserPreview(
        name: 'James Wilson',
        username: 'jamesw',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        bio: 'Software Engineer | Open source contributor',
        isFollowing: true,
      ),
      const UserPreview(
        name: 'Emma Thompson',
        username: 'emmat',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        bio: 'Content creator | Lifestyle blogger ✨',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'People to Follow',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _getSampleUsers().length,
              itemBuilder: (context, index) {
                final user = _getSampleUsers()[index];
                return _UserTile(user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final UserPreview user;

  const _UserTile({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _FollowButton(isFollowing: user.isFollowing),
          ],
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;

  const _FollowButton({
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: isFollowing ? Colors.grey : Theme.of(context).primaryColor,
        side: BorderSide(
          color: isFollowing ? Colors.grey : Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(isFollowing ? 'Following' : 'Follow'),
    );
  }
}
