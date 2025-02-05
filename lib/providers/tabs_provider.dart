import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/icons.dart' as i;

enum AttachmentType {
  images,
  videos,
  books,
  links,
  gifs,
  polls,
  series,
  movies,
  locations,
  music,
  audio,
  games,
  activities,
}

class TabCategory {
  final String name;
  final String? attachmentType;
  final Widget? icon;
  TabCategory(
    this.name,
    this.icon, {
    this.attachmentType,
  });
}

final tabsProvider = Provider<List<TabCategory>>((ref) {
  return [
    TabCategory('Feed', i.feed),
    TabCategory('Images', i.images, attachmentType: 'image'),
    TabCategory('Videos', i.videos, attachmentType: 'video'),
    TabCategory('Books', i.books, attachmentType: 'book'),
    TabCategory('Links', i.links, attachmentType: 'link'),
    TabCategory('GIFs', i.gifs, attachmentType: 'gif'),
    TabCategory('Polls', i.polls, attachmentType: 'poll'),
    TabCategory('Series', i.series, attachmentType: 'series'),
    TabCategory('Movies', i.movies, attachmentType: 'movie'),
    TabCategory('Locations', i.locations, attachmentType: 'location'),
    TabCategory('Music', i.music, attachmentType: 'music'),
    TabCategory('Audio', i.audio, attachmentType: 'audio'),
    TabCategory('Games', i.games, attachmentType: 'game'),
    TabCategory('Activities', i.activities, attachmentType: 'activity'),
  ];
});

final selectedTabProvider = StateProvider<int>((ref) => 0);
