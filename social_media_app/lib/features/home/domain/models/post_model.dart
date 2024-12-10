import 'package:flutter/foundation.dart';

import 'attachment_models.dart';

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
  final List<Attachment> attachments;
  final Map<String, int> reactions;
  final int likes;
  final int dislikes;
  final int commentsCount;
  final int sharesCount;
  final int repostsCount;
  final int quotesCount;
  final int clapsCount;
  final int wowCount;
  final int heartCount;
  final int rocketCount;
  final int partyPopperCount;
  final List<String> mentions;
  final List<String> hashtags;

  const Post({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likes,
    required this.dislikes,
    required this.commentsCount,
    required this.sharesCount,
    required this.repostsCount,
    required this.quotesCount,
    this.attachments = const [],
    this.reactions = const {},
    this.clapsCount = 0,
    this.wowCount = 0,
    this.heartCount = 0,
    this.rocketCount = 0,
    this.partyPopperCount = 0,
    this.mentions = const [],
    this.hashtags = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'] as String,
        author: UserInfo.fromJson(json['author'] as Map<String, dynamic>),
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        likes: json['likes'] as int,
        dislikes: json['dislikes'] as int,
        commentsCount: json['commentsCount'] as int,
        sharesCount: json['sharesCount'] as int,
        repostsCount: json['repostsCount'] as int,
        quotesCount: json['quotesCount'] as int,
        attachments:
            (json['attachments'] as List<dynamic>?)?.cast<String>() ?? [],
        reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, v as int),
            ) ??
            {},
        clapsCount: json['clapsCount'] as int? ?? 0,
        wowCount: json['wowCount'] as int? ?? 0,
        heartCount: json['heartCount'] as int? ?? 0,
        rocketCount: json['rocketCount'] as int? ?? 0,
        partyPopperCount: json['partyPopperCount'] as int? ?? 0,
        mentions: (json['mentions'] as List<dynamic>?)?.cast<String>() ?? [],
        hashtags: (json['hashtags'] as List<dynamic>?)?.cast<String>() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author.toJson(),
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'likes': likes,
        'dislikes': dislikes,
        'commentsCount': commentsCount,
        'sharesCount': sharesCount,
        'repostsCount': repostsCount,
        'quotesCount': quotesCount,
        'attachments': attachments,
        'reactions': reactions,
        'clapsCount': clapsCount,
        'wowCount': wowCount,
        'heartCount': heartCount,
        'rocketCount': rocketCount,
        'partyPopperCount': partyPopperCount,
        'mentions': mentions,
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
