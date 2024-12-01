import 'user_info.dart';

class EmbeddedPost {
  final String id;
  final UserInfo author;
  final String content;
  final DateTime createdAt;
  final List<String> hashtags;

  const EmbeddedPost({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    this.hashtags = const [],
  });

  factory EmbeddedPost.fromJson(Map<String, dynamic> json) {
    return EmbeddedPost(
      id: json['id'] as String,
      author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      hashtags: (json['hashtags'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'hashtags': hashtags,
    };
  }
}
