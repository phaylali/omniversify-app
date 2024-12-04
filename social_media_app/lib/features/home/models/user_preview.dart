class UserPreview {
  final String id;
  final String name;
  final String username;
  final String? avatarUrl;
  final String? bio;
  final bool isFollowing;
  final int followersCount;

  const UserPreview({
    required this.id,
    required this.name,
    required this.username,
    this.avatarUrl,
    this.bio,
    this.isFollowing = false,
    this.followersCount = 0,
  });
}
