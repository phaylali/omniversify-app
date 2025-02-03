import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_preview.dart';

final peopleProvider = StateNotifierProvider<PeopleNotifier, List<UserPreview>>((ref) {
  return PeopleNotifier();
});

class PeopleNotifier extends StateNotifier<List<UserPreview>> {
  PeopleNotifier() : super([
        const UserPreview(
      name: 'Sarah Johnson The third wife of the devil',
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
    // Add more mock data here
  ]);

  // Method to update the list of people (e.g., fetch from API)
  void updatePeople(List<UserPreview> newPeople) {
    state = newPeople;
  }
  void toggleFollow(String username) {
    state = state.map((user) {
      if (user.username == username) {
        return UserPreview(
          name: user.name,
          username: user.username,
          avatarUrl: user.avatarUrl,
          bio: user.bio,
          isFollowing: !user.isFollowing,
        );
      }
      return user;
    }).toList();
  }
}
