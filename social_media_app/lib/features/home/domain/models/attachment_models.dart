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
