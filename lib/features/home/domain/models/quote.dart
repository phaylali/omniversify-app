import 'user_info.dart';
import 'embedded_post.dart';

class Quote {
  final String id;
  final UserInfo author;
  final String content;
  final DateTime createdAt;
  final EmbeddedPost originalPost;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;
  final List<String> hashtags;

  const Quote({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.originalPost,
    this.likes = 0,
    this.dislikes = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.repostsCount = 0,
    this.quotesCount = 0,
    this.hashtags = const [],
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as String,
      author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      originalPost: EmbeddedPost.fromJson(json['originalPost'] as Map<String, dynamic>),
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
      sharesCount: json['sharesCount'] as int? ?? 0,
      repostsCount: json['repostsCount'] as int? ?? 0,
      quotesCount: json['quotesCount'] as int? ?? 0,
      hashtags: (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'originalPost': originalPost.toJson(),
      'likes': likes,
      'dislikes': dislikes,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'repostsCount': repostsCount,
      'quotesCount': quotesCount,
      'hashtags': hashtags,
    };
  }
}
