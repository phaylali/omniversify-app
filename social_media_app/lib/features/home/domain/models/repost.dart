import 'user_info.dart';
import 'embedded_post.dart';

class Repost {
  final String id;
  final UserInfo author;
  final DateTime createdAt;
  final EmbeddedPost originalPost;

  const Repost({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.originalPost,
  });

  factory Repost.fromJson(Map<String, dynamic> json) {
    return Repost(
      id: json['id'] as String,
      author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      originalPost: EmbeddedPost.fromJson(json['originalPost'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'originalPost': originalPost.toJson(),
    };
  }
}
