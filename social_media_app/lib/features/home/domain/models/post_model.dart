import 'package:flutter/foundation.dart';
import 'attachment_models.dart';

class AttachmentList {
  final List<Attachment> attachments;

  AttachmentList({required this.attachments});

  factory AttachmentList.fromJson(List<dynamic> json) {
    return AttachmentList(
      attachments: json.map((attachmentJson) {
        final attachmentType = attachmentJson['type'] as String;
        switch (attachmentType) {
          case 'link':
            return AttachmentLink.fromJson(attachmentJson);
          case 'video':
            return AttachmentVideo.fromJson(attachmentJson);
          case 'image':
            return AttachmentImage.fromJson(attachmentJson);
          case 'book':
            return AttachmentBook.fromJson(attachmentJson);
          case 'location':
            return AttachmentLocation.fromJson(attachmentJson);
          case 'game':
            return AttachmentGame.fromJson(attachmentJson);
          case 'poll':
            return AttachmentPoll.fromJson(attachmentJson);
          case 'music':
            return AttachmentMusic.fromJson(attachmentJson);
          case 'movie':
            return AttachmentMovie.fromJson(attachmentJson);
          case 'series':
            return AttachmentSeries.fromJson(attachmentJson);
          case 'gif':
            return AttachmentGif.fromJson(attachmentJson);
          case 'audio':
            return AttachmentAudio.fromJson(attachmentJson);
          case 'activity':
            return AttachmentActivity.fromJson(attachmentJson);
          default:
            throw Exception('Unknown attachment type: $attachmentType');
        }
      }).toList(),
    );
  }

  List<dynamic> toJson() {
    return attachments.map((attachment) => attachment.toJson()).toList();
  }
}

@immutable
class UserInfo {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? displayName;

  const UserInfo({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.displayName,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'avatarUrl': avatarUrl,
        'displayName': displayName,
      };

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json['id'] as String,
        username: json['username'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        displayName: json['displayName'] as String?,
      );
}

class Post {
  final String id;
  final UserInfo author;
  final String content;
  final DateTime createdAt;
  final AttachmentList attachments; // Change here
  final Map<String, int> reactions;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;
  final List<String> hashtags;

  const Post({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.attachments, // Change here
    this.reactions = const {},
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
      attachments: AttachmentList.fromJson(
          json['attachments'] as List<dynamic>), // Use AttachmentList
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
      commentsCount: json['commentsCount'] as int? ?? 0,
      sharesCount: json['sharesCount'] as int? ?? 0,
      repostsCount: json['repostsCount'] as int? ?? 0,
      quotesCount: json['quotesCount'] as int? ?? 0,
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author.toJson(),
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'attachments': attachments.toJson(), // Convert AttachmentList to JSON
        'likes': likes,
        'dislikes': dislikes,
        'commentsCount': commentsCount,
        'sharesCount': sharesCount,
        'repostsCount': repostsCount,
        'quotesCount': quotesCount,
        'hashtags': hashtags,
      };
}

class EmbeddedPost {
  final String id;
  final UserInfo author;
  final String content;
  final DateTime createdAt;
  final List<String> attachments;
  final List<String> mentions;
  final List<String> hashtags;

  const EmbeddedPost({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    this.attachments = const [],
    this.mentions = const [],
    this.hashtags = const [],
  });

  factory EmbeddedPost.fromJson(Map<String, dynamic> json) => EmbeddedPost(
        id: json['id'] as String,
        author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        attachments:
            (json['attachments'] as List<dynamic>?)?.cast<String>() ?? [],
        mentions: (json['mentions'] as List<dynamic>?)?.cast<String>() ?? [],
        hashtags: (json['hashtags'] as List<dynamic>?)?.cast<String>() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author.toJson(),
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'attachments': attachments,
        'mentions': mentions,
        'hashtags': hashtags,
      };
}

class Quote {
  final String id;
  final UserInfo author;
  final String content;
  final DateTime createdAt;
  final EmbeddedPost originalPost;
  final List<String> attachments;
  final List<String> mentions;
  final List<String> hashtags;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;

  const Quote({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.originalPost,
    required this.likes,
    required this.dislikes,
    required this.commentsCount,
    required this.sharesCount,
    required this.repostsCount,
    required this.quotesCount,
    this.attachments = const [],
    this.mentions = const [],
    this.hashtags = const [],
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json['id'] as String,
        author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        originalPost:
            EmbeddedPost.fromJson(json['originalPost'] as Map<String, dynamic>),
        likes: json['likes'] as int,
        dislikes: json['dislikes'] as int,
        commentsCount: json['commentsCount'] as int,
        sharesCount: json['sharesCount'] as int,
        repostsCount: json['repostsCount'] as int,
        quotesCount: json['quotesCount'] as int,
        attachments:
            (json['attachments'] as List<dynamic>?)?.cast<String>() ?? [],
        mentions: (json['mentions'] as List<dynamic>?)?.cast<String>() ?? [],
        hashtags: (json['hashtags'] as List<dynamic>?)?.cast<String>() ?? [],
      );

  Map<String, dynamic> toJson() => {
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
        'attachments': attachments,
        'mentions': mentions,
        'hashtags': hashtags,
      };
}

class Repost {
  final String id;
  final UserInfo author;
  final DateTime createdAt;
  final EmbeddedPost originalPost;
  final List<String> attachments;
  final List<String> mentions;
  final List<String> hashtags;

  const Repost({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.originalPost,
    this.attachments = const [],
    this.mentions = const [],
    this.hashtags = const [],
  });

  factory Repost.fromJson(Map<String, dynamic> json) => Repost(
        id: json['id'] as String,
        author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
        createdAt: DateTime.parse(json['createdAt'] as String),
        originalPost:
            EmbeddedPost.fromJson(json['originalPost'] as Map<String, dynamic>),
        attachments:
            (json['attachments'] as List<dynamic>?)?.cast<String>() ?? [],
        mentions: (json['mentions'] as List<dynamic>?)?.cast<String>() ?? [],
        hashtags: (json['hashtags'] as List<dynamic>?)?.cast<String>() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'originalPost': originalPost.toJson(),
        'attachments': attachments,
        'mentions': mentions,
        'hashtags': hashtags,
      };
}
