class UserInfo {
  final String id;
  final String username;
  final String? displayName;
  final String? avatarUrl;

  const UserInfo({
    required this.id,
    required this.username,
    this.displayName,
    this.avatarUrl,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }
}
