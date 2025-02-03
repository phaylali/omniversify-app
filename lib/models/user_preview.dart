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