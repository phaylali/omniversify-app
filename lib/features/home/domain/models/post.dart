import 'package:flutter/foundation.dart';
import 'user_info.dart';
import 'attachment_models.dart';

@immutable
class Post {
  final String id;
  final String content;
  final UserInfo author;
  final DateTime createdAt;
  final List<Attachment> attachments;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;
  final List<String> hashtags;

  const Post({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
    this.attachments = const [],
    this.likes = 0,
    this.dislikes = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.repostsCount = 0,
    this.quotesCount = 0,
    this.hashtags = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      content: json['content'] as String,
      author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) {
        final Map<String, dynamic> attachment = e as Map<String, dynamic>;
        switch (attachment['type']) {
          case 'link':
            return AttachmentLink.fromJson(attachment);
          case 'video':
            return AttachmentVideo.fromJson(attachment);
          case 'image':
            return AttachmentImage.fromJson(attachment);
          case 'book':
            return AttachmentBook.fromJson(attachment);
          default:
            throw Exception('Unknown attachment type: ${attachment['type']}');
        }
      }).toList() ?? [],
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
      'content': content,
      'author': author.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
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
