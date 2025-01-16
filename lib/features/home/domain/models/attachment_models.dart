import 'package:flutter/foundation.dart';

@immutable
abstract class Attachment {
  final String type;

  const Attachment({required this.type});

  Map<String, dynamic> toJson();
}

class AttachmentLink extends Attachment {
  final String url;

  const AttachmentLink({required this.url}) : super(type: 'link');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
      };

  factory AttachmentLink.fromJson(Map<String, dynamic> json) => AttachmentLink(
        url: json['url'] as String,
      );
}

class AttachmentVideo extends Attachment {
  final String url;
  final String? thumbnailUrl;
  final Duration? duration;

  const AttachmentVideo({
    required this.url,
    this.thumbnailUrl,
    this.duration,
  }) : super(type: 'video');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
        'duration': duration?.inSeconds,
      };

  factory AttachmentVideo.fromJson(Map<String, dynamic> json) =>
      AttachmentVideo(
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String?,
        duration: json['duration'] != null
            ? Duration(seconds: json['duration'] as int)
            : null,
      );
}

class AttachmentImage extends Attachment {
  final String url;
  final String? caption;
  final int? width;
  final int? height;

  const AttachmentImage({
    required this.url,
    this.caption,
    this.width,
    this.height,
  }) : super(type: 'image');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'caption': caption,
        'width': width,
        'height': height,
      };

  factory AttachmentImage.fromJson(Map<String, dynamic> json) =>
      AttachmentImage(
        url: json['url'] as String,
        caption: json['caption'] as String?,
        width: json['width'] as int?,
        height: json['height'] as int?,
      );
}

class AttachmentBook extends Attachment {
  final String id;
  final String url;
  final String author;
  final String? coverUrl;
  final String? description;

  const AttachmentBook({
    required this.id,
    required this.url,
    required this.author,
    this.coverUrl,
    this.description,
  }) : super(type: 'book');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'url': url,
        'author': author,
        'coverUrl': coverUrl,
        'description': description,
      };

  factory AttachmentBook.fromJson(Map<String, dynamic> json) => AttachmentBook(
        id: json['id'] as String,
        url: json['url'] as String,
        author: json['author'] as String,
        coverUrl: json['coverUrl'] as String?,
        description: json['description'] as String?,
      );
}

class AttachmentLocation extends Attachment {
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  final String? placeId;

  const AttachmentLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
    this.placeId,
  }) : super(type: 'location');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'placeId': placeId,
      };

  factory AttachmentLocation.fromJson(Map<String, dynamic> json) =>
      AttachmentLocation(
        name: json['name'] as String,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        address: json['address'] as String?,
        placeId: json['placeId'] as String?,
      );
}

class AttachmentGame extends Attachment {
  final String title;
  final String platform;
  final DateTime releaseDate;
  final String coverUrl;

  const AttachmentGame({
    required this.title,
    required this.platform,
    required this.releaseDate,
    required this.coverUrl,
  }) : super(type: 'game');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'platform': platform,
        'releaseDate': releaseDate.toIso8601String(),
        'coverUrl': coverUrl,
      };

  factory AttachmentGame.fromJson(Map<String, dynamic> json) => AttachmentGame(
        title: json['title'] as String,
        platform: json['platform'] as String,
        releaseDate: DateTime.parse(json['releaseDate'] as String),
        coverUrl: json['coverUrl'] as String,
      );
}

class AttachmentPoll extends Attachment {
  final String question;
  final List<String> options;
  final List<int> votes;

  const AttachmentPoll({
    required this.question,
    required this.options,
    required this.votes,
  }) : super(type: 'poll');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'question': question,
        'options': options,
        'votes': votes,
      };

  factory AttachmentPoll.fromJson(Map<String, dynamic> json) => AttachmentPoll(
        question: json['question'] as String,
        options: List<String>.from(json['options']),
        votes: List<int>.from(json['votes']),
      );
}

class AttachmentMusic extends Attachment {
  final String title;
  final String artist;
  final String album;
  final Duration duration;

  const AttachmentMusic({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
  }) : super(type: 'music');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'artist': artist,
        'album': album,
        'duration': duration.inSeconds,
      };

  factory AttachmentMusic.fromJson(Map<String, dynamic> json) =>
      AttachmentMusic(
        title: json['title'] as String,
        artist: json['artist'] as String,
        album: json['album'] as String,
        duration: Duration(seconds: json['duration'] as int),
      );
}

class AttachmentMovie extends Attachment {
  final String title;
  final String director;
  final int releaseYear;
  final String trailerUrl;

  const AttachmentMovie({
    required this.title,
    required this.director,
    required this.releaseYear,
    required this.trailerUrl,
  }) : super(type: 'movie');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'director': director,
        'releaseYear': releaseYear,
        'trailerUrl': trailerUrl,
      };

  factory AttachmentMovie.fromJson(Map<String, dynamic> json) =>
      AttachmentMovie(
        title: json['title'] as String,
        director: json['director'] as String,
        releaseYear: json['releaseYear'] as int,
        trailerUrl: json['trailerUrl'] as String,
      );
}

class AttachmentSeries extends Attachment {
  final String title;
  final int seasons;
  final int episodes;

  const AttachmentSeries({
    required this.title,
    required this.seasons,
    required this.episodes,
  }) : super(type: 'series');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'seasons': seasons,
        'episodes': episodes,
      };

  factory AttachmentSeries.fromJson(Map<String, dynamic> json) =>
      AttachmentSeries(
        title: json['title'] as String,
        seasons: json['seasons'] as int,
        episodes: json['episodes'] as int,
      );
}

class AttachmentGif extends Attachment {
  final String url;
  final String description;

  const AttachmentGif({
    required this.url,
    required this.description,
  }) : super(type: 'gif');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'description': description,
      };

  factory AttachmentGif.fromJson(Map<String, dynamic> json) => AttachmentGif(
        url: json['url'] as String,
        description: json['description'] as String,
      );
}

class AttachmentAudio extends Attachment {
  final String url;
  final Duration duration;
  final String title;

  const AttachmentAudio({
    required this.url,
    required this.duration,
    required this.title,
  }) : super(type: 'audio');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
        'duration': duration.inSeconds,
        'title': title,
      };

  factory AttachmentAudio.fromJson(Map<String, dynamic> json) =>
      AttachmentAudio(
        url: json['url'] as String,
        duration: Duration(seconds: json['duration'] as int),
        title: json['title'] as String,
      );
}

class AttachmentActivity extends Attachment {
  final String activityType;
  final String description;

  const AttachmentActivity({
    required this.activityType,
    required this.description,
  }) : super(type: 'activity');

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'activityType': activityType,
        'description': description,
      };

  factory AttachmentActivity.fromJson(Map<String, dynamic> json) =>
      AttachmentActivity(
        activityType: json['activityType'] as String,
        description: json['description'] as String,
      );
}
